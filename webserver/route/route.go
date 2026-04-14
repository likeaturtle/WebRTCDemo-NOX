package route

import (
	"io/fs"
	"net/http"
	"os"
	"path/filepath"

	"WebRTCDemo/assets"
	"WebRTCDemo/config"
	"WebRTCDemo/webserver/handler"

	"github.com/gin-gonic/gin"
)

// certFiles 存储临时证书文件路径
var certFiles struct {
	Cert string
	Key  string
}

// Router 返回路由器
func Router() *gin.Engine {
	//初始化
	gin.SetMode(gin.ReleaseMode) //全局设置环境，此为开发环境，线上环境为gin.ReleaseMode
	router := gin.Default()

	// 使用嵌入的静态资源
	staticSubFS, err := fs.Sub(assets.StaticFS, "static")
	if err != nil {
		panic(err)
	}
	router.StaticFS("/static/", http.FS(staticSubFS))

	// 处理默认首页
	router.GET("/", handler.DefaultHomePageHandler)

	//处理socketio请求
	router.GET("/socket.io/", handler.SocketIOServerHandler)
	router.POST("/socket.io/", handler.SocketIOServerHandler)
	router.Handle("WS", "/socket.io", handler.SocketIOServerHandler)
	router.Handle("WSS", "/socket.io", handler.SocketIOServerHandler)

	return router
}

// GetCertFiles 获取证书文件路径
// 如果通过命令行参数指定了证书路径，则使用指定路径
// 否则从嵌入的文件系统中提取证书到临时目录
func GetCertFiles() (certPath string, keyPath string) {
	// 如果已经提取过，直接返回
	if certFiles.Cert != "" && certFiles.Key != "" {
		return certFiles.Cert, certFiles.Key
	}

	// 如果通过命令行参数指定了证书路径，直接使用
	if config.CertFile != "" && config.KeyFile != "" {
		return config.CertFile, config.KeyFile
	}

	// 创建临时目录
	tmpDir, err := os.MkdirTemp("", "webrtc-certs-*")
	if err != nil {
		panic(err)
	}

	// 提取 server.crt
	certData, err := assets.SSLFS.ReadFile("ssl/server.crt")
	if err != nil {
		panic(err)
	}
	certPath = filepath.Join(tmpDir, "server.crt")
	if err := os.WriteFile(certPath, certData, 0644); err != nil {
		panic(err)
	}

	// 提取 server.key
	keyData, err := assets.SSLFS.ReadFile("ssl/server.key")
	if err != nil {
		panic(err)
	}
	keyPath = filepath.Join(tmpDir, "server.key")
	if err := os.WriteFile(keyPath, keyData, 0600); err != nil {
		panic(err)
	}

	certFiles.Cert = certPath
	certFiles.Key = keyPath

	return certPath, keyPath
}
