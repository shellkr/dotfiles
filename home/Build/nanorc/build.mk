generate: $(addprefix build/, $(wildcard *.nanorc))

build/%.nanorc: %.nanorc mixins/*.nanorc $(THEME) | build/
	@sed -f mixins.sed $< | sed -f $(THEME) $(FILTER) > $@
	@echo $@

build/:
	@mkdir $@

clean:
	rm -rf build/


.PHONY: generate clean
