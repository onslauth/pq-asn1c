include $(PQ_FACTORY)/factory.mk

pq_part_name := asn1c-0.9.26
pq_part_file := $(pq_part_name).tar.gz

pq_asn1c_configuration_flags += --prefix=$(part_dir)

PQ_BIN += asn1c

build-stamp: stage-stamp
	$(MAKE) -C $(pq_part_name) mkinstalldirs=$(part_dir)
	$(MAKE) -C $(pq_part_name) mkinstalldirs=$(part_dir) DESTDIR=$(stage_dir) install
	touch $@

stage-stamp: configure-stamp

configure-stamp: patch-stamp
	cd $(pq_part_name) && ./configure $(pq_asn1c_configuration_flags)
	touch $@

patch-stamp: unpack-stamp makefile-in.patch
	patch -p0 < $(source_dir)/makefile-in.patch
	touch $@

unpack-stamp: $(pq_part_file)
	tar xf $(source_dir)/$(pq_part_file)
	touch $@
