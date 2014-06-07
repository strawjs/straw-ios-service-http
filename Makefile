.PHONY: clean test kill-stub

clean:
	xctool clean

test:
	stubbatti --kill
	(stubbatti &)
	xctool test
	stubbatti --kill

kill-stub:
	stubbatti --kill
