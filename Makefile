build-release:
	xcodebuild
	ditto -c -k --sequesterRsrc --keepParent ./build/Release/Ristretto.app ./release/Ristretto.app.zip
