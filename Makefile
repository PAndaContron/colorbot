all: main

main: obj/main.o obj/cmds.o concord/lib/libdiscord.a
	cobc -x $^ -o $@ -lcurl -lpthread

obj/main.o: main.cob | obj
	cobc -x -c $< -o $@

obj/cmds.o: cmds.cob | obj
	cobc -c $< -o $@

obj:
	mkdir -p $@

concord/lib/libdiscord.a: concord
concord:
	CFLAGS="$$CFLAGS -DCCORD_SIGINTCATCH" $(MAKE) -C concord

clean:
	$(RM) main
	$(RM) -r obj

clean-concord:
	$(MAKE) -C concord clean

.PHONY: all concord clean clean-concord
