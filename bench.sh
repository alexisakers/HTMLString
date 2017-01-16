swift build --clean

swift build -c debug -Xswiftc -D -Xswiftc DEBUG
swift build -c release -Xswiftc -D -Xswiftc RELEASE

./.build/debug/Performance
./.build/release/Performance