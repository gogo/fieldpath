# Extensions for Protocol Buffers to create more go like structures.
#
# Copyright (c) 2013, Vastech SA (PTY) LTD. All rights reserved.
# http://github.com/gogo/protobuf/gogoproto
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#     * Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
# copyright notice, this list of conditions and the following disclaimer
# in the documentation and/or other materials provided with the
# distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

.PHONY: nuke regenerate tests clean install gofmt vet

all: clean install regenerate install tests vet

install:
	go install ./fieldpath-gen
	go install .
	go install ./cmd/pbpath

clean:
	go clean ./...

nuke:
	go clean -i ./...

gofmt:
	gofmt -l -s -w .

regenerate:
	make -C fieldpath-gen regenerate
	make gofmt

tests:
	go test ./...

vet:
	go vet ./...
	go tool vet --shadow .

drone:
	sudo apt-get install protobuf-compiler
	go get -u github.com/gogo/protobuf
	go get -u github.com/gogo/pbparser
	(cd $(GOPATH)/src/github.com/gogo/protobuf && make all)