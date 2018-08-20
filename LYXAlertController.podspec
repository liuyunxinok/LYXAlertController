Pod::Spec.new do |s|
s.name         = "LYXAlertController"             #名称
s.version      = "0.0.1"              #版本号
s.summary      = "Customizable alert"       #简短介绍
s.description  = <<-DESC
a custom AlertController
* Markdown 格式
DESC

s.homepage     = "https://github.com/liuyunxin2014/LYXAlertController"
# s.screenshots  = "www.example.com/screenshots_1.gif"
s.license      = "MIT"                #开源协议
s.author             = { "liuyunxin" => "1320379312@qq.com" }

s.source       = { :git => "https://github.com/liuyunxin2014/YXAlertController.git" }
## 这里不支持ssh的地址，只支持HTTP和HTTPS，最好使用HTTPS
## 正常情况下我们会使用稳定的tag版本来访问，如果是在开发测试的时候，不需要发布release版本，直接指向git地址使用
## 待测试通过完成后我们再发布指定release版本，使用如下方式
#s.source       = { :git => "https://github.com/liuyunxin2014/LYXAlertController.git", :tag => s.version }

s.platform     = :ios, "6.0"          #支持的平台及版本，6.0
s.requires_arc = true                 #是否使用ARC

s.source_files  = "YXCustomAlert/**/*.{h,m}"    #OC可以使用类似这样"Classes/**/*.{h,m}"

s.frameworks = 'UIKit', 'QuartzCore', 'Foundation'    #所需的framework,多个用逗号隔开
s.module_name = 'YXCustomAlert'              #模块名称

# s.dependency "JSONKit", "~> 1.4"    #依赖关系，该项目所依赖的其他库，如果有多个可以写多个 s.dependency

end
