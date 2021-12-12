#!/bin/bash

version=$(grep ^Version deb/DEBIAN/control | awk '{print $2}')

dpkg-deb --build --root-owner-group deb ramlog-oe_$version.deb
