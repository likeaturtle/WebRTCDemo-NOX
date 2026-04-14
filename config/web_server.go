package config

import (
	"flag"
)

var (
	// WebServerHostTLS 服务器监听地址，可通过 -addr 参数指定
	WebServerHostTLS string
	// CertFile SSL证书文件路径，可通过 -cert 参数指定
	CertFile string
	// KeyFile SSL密钥文件路径，可通过 -key 参数指定
	KeyFile string
)

func init() {
	flag.StringVar(&WebServerHostTLS, "addr", "0.0.0.0:8081", "服务器监听地址 (默认: 0.0.0.0:8081)")
	flag.StringVar(&CertFile, "cert", "", "SSL证书文件路径 (默认使用嵌入的证书)")
	flag.StringVar(&KeyFile, "key", "", "SSL密钥文件路径 (默认使用嵌入的证书)")
}

// ParseFlags 解析命令行参数，需要在 main() 中调用
func ParseFlags() {
	flag.Parse()
}
