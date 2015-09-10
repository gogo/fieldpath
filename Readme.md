#Fieldpath

_pbpath_, is a debugging tool, which allows you to stringify a marshaled protocol buffer on the command line.
_pbpath_ does not have the protocol buffer definitions compiled in and makes extensive use of the _fieldpath_ library.

A typical example:

    cat marshalled.dat | pbpath -D=desc.out mypackage.MyMarshaledMessage

The desc.out file can be created with protoc as such:

    protoc --descriptor_set_out=desc.out --include_imports mymessage.proto