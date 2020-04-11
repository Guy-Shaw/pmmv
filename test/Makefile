DATE_PATTERN := [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]
TIME_PATTERN := [0-9][0-9][0-9][0-9][0-9][0-9]
TS_PATTERN := $(DATE_PATTERN)$(TIME_PATTERN)
TMP_PATTERN  := tmp-$(TS_PATTERN)-[0-9][0-9][0-9]

.PHONY: test lstmp clean show-targets

test:
	./test-01

lstmp:
	@ls -1 tmp $(TMP_PATTERN)

clean:
	@rm -rf tmp $(TMP_PATTERN)

show-targets:
	@show-makefile-targets

show-%:
	@echo $*=$($*)

