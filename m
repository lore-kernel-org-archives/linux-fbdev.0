From: Jon Smirl <jonsmirl@gmail.com>
Subject: PATCH: Make sysfs color_map attribute work
Date: Sun, 12 Jun 2005 11:30:36 -0400
Message-ID: <9e47339105061208305d0cf3cc@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_6499_17903773.1118590236450"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DhUQ6-0002ky-P5
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Jun 2005 08:30:42 -0700
Received: from wproxy.gmail.com ([64.233.184.203])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DhUQ5-0006jK-VO
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Jun 2005 08:30:42 -0700
Received: by wproxy.gmail.com with SMTP id 69so919563wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 12 Jun 2005 08:30:36 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

------=_Part_6499_17903773.1118590236450
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These two patches make the sysfs color_map attribute work. There is a
minor bug in sysfs fixed by sysfs_offbyone.patch. I sent the sysfs fix
separately to GregKH.

Sysfs usually works in text instead of binary. That lets scripts set
the attributes. You can set an attribute from a program with normal
file writes. The values have to be less than PAGE_SIZE in size.

Color maps have up to 256 entries. 4096/256 allows for 16 characters per li=
ne.

The format for a cmap entry is "%02x%c%4x%4x%4x\n"
%02x entry %c transp %4x red %4x blue %4x green

You don't have to start at zero, you can change one or more entries
this way. Build up a line per entry and set the whole block into the
attribute.

You can read the color_map with cat fb0/color_map.

My assumption from looking at the code that transparent is a boolean
flag. If the "%c" column is not a space transparent will be set for
that entry.

--=20
Jon Smirl
jonsmirl@gmail.com

------=_Part_6499_17903773.1118590236450
Content-Type: text/x-diff; name="sysfs_offbyone.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sysfs_offbyone.patch"

ZGlmZiAtLWdpdCBhL2ZzL3N5c2ZzL2ZpbGUuYyBiL2ZzL3N5c2ZzL2ZpbGUuYwotLS0gYS9mcy9z
eXNmcy9maWxlLmMKKysrIGIvZnMvc3lzZnMvZmlsZS5jCkBAIC0xODIsNyArMTgyLDcgQEAgZmls
bF93cml0ZV9idWZmZXIoc3RydWN0IHN5c2ZzX2J1ZmZlciAqIAogCQlyZXR1cm4gLUVOT01FTTsK
IAogCWlmIChjb3VudCA+PSBQQUdFX1NJWkUpCi0JCWNvdW50ID0gUEFHRV9TSVpFIC0gMTsKKwkJ
Y291bnQgPSBQQUdFX1NJWkU7CiAJZXJyb3IgPSBjb3B5X2Zyb21fdXNlcihidWZmZXItPnBhZ2Us
YnVmLGNvdW50KTsKIAlidWZmZXItPm5lZWRzX3JlYWRfZmlsbCA9IDE7CiAJcmV0dXJuIGVycm9y
ID8gLUVGQVVMVCA6IGNvdW50Owo=
------=_Part_6499_17903773.1118590236450
Content-Type: text/x-diff; name="cmap_sysfs.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cmap_sysfs.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vZmJzeXNmcy5jIGIvZHJpdmVycy92aWRlby9mYnN5
c2ZzLmMKLS0tIGEvZHJpdmVycy92aWRlby9mYnN5c2ZzLmMKKysrIGIvZHJpdmVycy92aWRlby9m
YnN5c2ZzLmMKQEAgLTI0NCwxMCArMjQyLDY4IEBAIHN0YXRpYyBzc2l6ZV90IHNob3dfdmlydHVh
bChzdHJ1Y3QgY2xhc3MKIAkJCWZiX2luZm8tPnZhci54cmVzX3ZpcnR1YWwpOwogfQogCi1zdGF0
aWMgc3NpemVfdCBzdG9yZV9jbWFwKHN0cnVjdCBjbGFzc19kZXZpY2UgKmNsYXNzX2RldmljZSwg
Y29uc3QgY2hhciAqIGJ1ZiwKKy8qIEZvcm1hdCBmb3IgY21hcCBpcyAiJTAyeCVjJTR4JTR4JTR4
XG4iICovCisvKiAlMDJ4IGVudHJ5ICVjIHRyYW5zcCAlNHggcmVkICU0eCBibHVlICU0eCBncmVl
biBcbiAqLworLyogMjU1IHJvd3MgYXQgMTYgY2hhcnMgZXF1YWxzIDQwOTYgKi8KKy8qIFBBR0Vf
U0laRSBjYW4gYmUgNDA5NiBvciBsYXJnZXIgKi8KK3N0YXRpYyBzc2l6ZV90IHN0b3JlX2NtYXAo
c3RydWN0IGNsYXNzX2RldmljZSAqY2xhc3NfZGV2aWNlLCBjb25zdCBjaGFyICpidWYsCiAJCQkg
IHNpemVfdCBjb3VudCkKIHsKLS8vCXN0cnVjdCBmYl9pbmZvICpmYl9pbmZvID0gKHN0cnVjdCBm
Yl9pbmZvICopY2xhc3NfZ2V0X2RldmRhdGEoY2xhc3NfZGV2aWNlKTsKKwlzdHJ1Y3QgZmJfaW5m
byAqZmJfaW5mbyA9IChzdHJ1Y3QgZmJfaW5mbyAqKWNsYXNzX2dldF9kZXZkYXRhKGNsYXNzX2Rl
dmljZSk7CisJaW50IHJjLCBpLCBzdGFydCwgbGVuZ3RoLCB0cmFuc3AgPSAwOworCisJaWYgKChj
b3VudCA+IDQwOTYpIHx8ICgoY291bnQgJSAxNikgIT0gMCkgfHwgKFBBR0VfU0laRSA8IDQwOTYp
KQorCQlyZXR1cm4gLUVJTlZBTDsKKworCWlmICghZmJfaW5mby0+ZmJvcHMtPmZiX3NldGNvbHJl
ZyAmJiAhZmJfaW5mby0+ZmJvcHMtPmZiX3NldGNtYXApCisJCXJldHVybiAtRUlOVkFMOworCisJ
c3NjYW5mKGJ1ZiwgIiUwMngiLCAmc3RhcnQpOworCWxlbmd0aCA9IGNvdW50IC8gMTY7CisKKwlm
b3IgKGkgPSAwOyBpIDwgbGVuZ3RoOyBpKyspCisJCWlmIChidWZbaSAqIDE2ICsgMl0gIT0gJyAn
KQorCQkJdHJhbnNwID0gMTsKKworCS8qIElmIHdlIGNhbiBiYXRjaCwgZG8gaXQgKi8KKwlpZiAo
ZmJfaW5mby0+ZmJvcHMtPmZiX3NldGNtYXAgJiYgbGVuZ3RoID4gMSkgeworCQlzdHJ1Y3QgZmJf
Y21hcCB1bWFwOworCisJCW1lbXNldCgmdW1hcCwgMCwgc2l6ZW9mKHVtYXApKTsKKwkJaWYgKChy
YyA9IGZiX2FsbG9jX2NtYXAoJnVtYXAsIGxlbmd0aCwgdHJhbnNwKSkpCisJCQlyZXR1cm4gcmM7
CisKKwkJdW1hcC5zdGFydCA9IHN0YXJ0OworCQlmb3IgKGkgPSAwOyBpIDwgbGVuZ3RoOyBpKysp
IHsKKwkJCXNzY2FuZigmYnVmW2kgKiAxNiArICAzXSwgIiU0aHgiLCAmdW1hcC5yZWRbaV0pOwor
CQkJc3NjYW5mKCZidWZbaSAqIDE2ICsgIDddLCAiJTRoeCIsICZ1bWFwLmJsdWVbaV0pOworCQkJ
c3NjYW5mKCZidWZbaSAqIDE2ICsgMTFdLCAiJTRoeCIsICZ1bWFwLmdyZWVuW2ldKTsKKwkJCWlm
ICh0cmFuc3ApCisJCQkJdW1hcC50cmFuc3BbaV0gPSAoYnVmW2kgKiAxNiArICAyXSAhPSAnICcp
OworCQl9CisJCXJjID0gZmJfaW5mby0+ZmJvcHMtPmZiX3NldGNtYXAoJnVtYXAsIGZiX2luZm8p
OworCQlmYl9jb3B5X2NtYXAoJnVtYXAsICZmYl9pbmZvLT5jbWFwKTsKKwkJZmJfZGVhbGxvY19j
bWFwKCZ1bWFwKTsKKworCQlyZXR1cm4gcmM7CisJfQorCWZvciAoaSA9IDA7IGkgPCBsZW5ndGg7
IGkrKykgeworCQl1MTYgcmVkLCBibHVlLCBncmVlbiwgdHNwOworCisJCXNzY2FuZigmYnVmW2kg
KiAxNiArICAzXSwgIiU0aHgiLCAmcmVkKTsKKwkJc3NjYW5mKCZidWZbaSAqIDE2ICsgIDddLCAi
JTRoeCIsICZibHVlKTsKKwkJc3NjYW5mKCZidWZbaSAqIDE2ICsgMTFdLCAiJTRoeCIsICZncmVl
bik7CisJCXRzcCA9IChidWZbaSAqIDE2ICsgIDJdICE9ICcgJyk7CisJCWlmICgocmMgPSBmYl9p
bmZvLT5mYm9wcy0+ZmJfc2V0Y29scmVnKHN0YXJ0KyssCisJCQkJICAgICAgcmVkLCBncmVlbiwg
Ymx1ZSwgdHNwLCBmYl9pbmZvKSkpCisJCQlyZXR1cm4gcmM7CisKKwkJZmJfaW5mby0+Y21hcC5y
ZWRbaV0gPSByZWQ7CisJCWZiX2luZm8tPmNtYXAuYmx1ZVtpXSA9IGJsdWU7CisJCWZiX2luZm8t
PmNtYXAuZ3JlZW5baV0gPSBncmVlbjsKKwkJaWYgKHRyYW5zcCkKKwkJCWZiX2luZm8tPmNtYXAu
dHJhbnNwW2ldID0gdHNwOworCX0KIAlyZXR1cm4gMDsKIH0KIApAQCAtMjU1LDIwICszMTEsMjQg
QEAgc3RhdGljIHNzaXplX3Qgc2hvd19jbWFwKHN0cnVjdCBjbGFzc19kZQogewogCXN0cnVjdCBm
Yl9pbmZvICpmYl9pbmZvID0KIAkJKHN0cnVjdCBmYl9pbmZvICopY2xhc3NfZ2V0X2RldmRhdGEo
Y2xhc3NfZGV2aWNlKTsKLQl1bnNpZ25lZCBpbnQgb2Zmc2V0ID0gMCwgaTsKKwl1bnNpZ25lZCBp
bnQgaTsKIAogCWlmICghZmJfaW5mby0+Y21hcC5yZWQgfHwgIWZiX2luZm8tPmNtYXAuYmx1ZSB8
fAotCSAgICBmYl9pbmZvLT5jbWFwLmdyZWVuIHx8IGZiX2luZm8tPmNtYXAudHJhbnNwKQorCSAg
ICAhZmJfaW5mby0+Y21hcC5ncmVlbikKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlpZiAoUEFHRV9T
SVpFIDwgNDA5NikKIAkJcmV0dXJuIC1FSU5WQUw7CiAKKwkvKiBkb24ndCBtZXNzIHdpdGggdGhl
IGZvcm1hdCwgdGhlIGJ1ZmZlciBpcyBQQUdFX1NJWkUgKi8KKwkvKiAyNTUgZW50cmllcyBhdCAx
NiBjaGFycyBwZXIgbGluZSBlcXVhbHMgNDA5NiA9IFBBR0VfU0laRSAqLwogCWZvciAoaSA9IDA7
IGkgPCBmYl9pbmZvLT5jbWFwLmxlbjsgaSsrKSB7Ci0JCW9mZnNldCArPSBzbnByaW50ZihidWYs
IFBBR0VfU0laRSAtIG9mZnNldCwKLQkJCQkgICAiJWQsJWQsJWQsJWQsJWRcbiIsIGkgKyBmYl9p
bmZvLT5jbWFwLnN0YXJ0LAotCQkJCSAgIGZiX2luZm8tPmNtYXAucmVkW2ldLCBmYl9pbmZvLT5j
bWFwLmJsdWVbaV0sCi0JCQkJICAgZmJfaW5mby0+Y21hcC5ncmVlbltpXSwKLQkJCQkgICBmYl9p
bmZvLT5jbWFwLnRyYW5zcFtpXSk7CisJCXNwcmludGYoJmJ1ZlsgaSAqIDE2XSwgIiUwMnglYyU0
eCU0eCU0eFxuIiwgaSArIGZiX2luZm8tPmNtYXAuc3RhcnQsCisJCQkoKGZiX2luZm8tPmNtYXAu
dHJhbnNwICYmIGZiX2luZm8tPmNtYXAudHJhbnNwW2ldKSA/ICcqJyA6ICcgJyksCisJCQlmYl9p
bmZvLT5jbWFwLnJlZFtpXSwgZmJfaW5mby0+Y21hcC5ibHVlW2ldLAorCQkJZmJfaW5mby0+Y21h
cC5ncmVlbltpXSk7CiAJfQotCXJldHVybiBvZmZzZXQ7CisJcmV0dXJuIDQwOTY7CiB9CiAKIHN0
YXRpYyBzc2l6ZV90IHN0b3JlX2JsYW5rKHN0cnVjdCBjbGFzc19kZXZpY2UgKmNsYXNzX2Rldmlj
ZSwgY29uc3QgY2hhciAqIGJ1ZiwK
------=_Part_6499_17903773.1118590236450--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
