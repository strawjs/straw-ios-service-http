.PHONY: clean test stub-kill

clean:
	xctool clean

test:
	(stubbatti &)
	xctool test
	stubbatti --kill

stub-kill:
	stubbatti --kill
