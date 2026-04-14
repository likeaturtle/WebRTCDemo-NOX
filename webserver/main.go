package main

import (
	"WebRTCDemo/config"
	"WebRTCDemo/webserver/route"
)

func main() {
	router := route.Router()

	// 从嵌入的文件系统中获取证书
	certFile, keyFile := route.GetCertFiles()
	router.RunTLS(config.WebServerHostTLS, certFile, keyFile)
}
