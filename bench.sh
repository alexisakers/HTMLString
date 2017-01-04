swift build --clean

time swift build -c debug -Xswiftc -D -Xswiftc DEBUG
time swift build -c release -Xswiftc -D -Xswiftc RELEASE

./.build/debug/Performance
./.build/release/Performance