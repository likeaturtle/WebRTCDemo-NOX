package main

import (
	"WebRTCDemo/config"
	"WebRTCDemo/webserver/route"
)

func main() {
	// 解析命令行参数
	config.ParseFlags()

	router := route.Router()

	// 获取证书文件路径（优先使用命令行参数指定的路径）
	certFile, keyFile := route.GetCertFiles()
	router.RunTLS(config.WebServerHostTLS, certFile, keyFile)
}
