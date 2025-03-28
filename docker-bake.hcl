variable "IMAGE_NAMESPACE" {
  default = "$IMAGE_NAMESPACE"
}

variable "VERSION" {
  default = "$VERSION"
}

variable "LOCAL_PLATFORM" {
  default = "linux/amd64"
}

variable "GO_JSONNET_VERSION" {
  default = "v0.20.0"
}

variable "GO_JSONNET_LINTER_VERSION" {
  default = "v0.20.0"
}

variable "JSONNET_BUNDLER_VERSION" {
  default = "v0.6.0"
}

group "load" {
  targets = ["load_local"]
}

group "push" {
  targets = ["push_dockerhub"]
}

target "base" {
  dockerfile = "./Dockerfile"
  context    = "./"
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${IMAGE_NAMESPACE}:${VERSION}",
    "${IMAGE_NAMESPACE}:latest"
  ]
  args = {
    GO_JSONNET_VERSION        = "${GO_JSONNET_VERSION}"
    GO_JSONNET_LINTER_VERSION = "${GO_JSONNET_LINTER_VERSION}"
    JSONNET_BUNDLER_VERSION   = "${JSONNET_BUNDLER_VERSION}"
  }
}

target "load_local" {
  inherits = ["base"]
  platforms = ["${LOCAL_PLATFORM}"]
  output = ["type=docker"]
}

target "push_dockerhub" {
  inherits = ["base"]
  output = ["type=registry,name=docker.io"]
}
