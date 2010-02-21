From: d binderman <dcb314@hotmail.com>
Date: Sun, 21 Feb 2010 10:19:38 +0000
Subject: drivers/video/uvesafb.c: 6 * redundant condition
Message-Id: <BLU108-W1367923D11AF128D7564D39C440@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="_445ce773-0122-42a9-8d0c-b5a38e5582ea_"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--_445ce773-0122-42a9-8d0c-b5a38e5582ea_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello there=2C

I just ran the sourceforge tool cppcheck over the source code of the
new Linux kernel 2.6.33-rc8

It said

[./drivers/video/uvesafb.c:238]: (style) Redundant condition. It is safe to=
 deallocate a NULL pointer
[./drivers/video/uvesafb.c:1321]: (style) Redundant condition. It is safe t=
o deallocate a NULL pointer
[./drivers/video/uvesafb.c:1799]: (style) Redundant condition. It is safe t=
o deallocate a NULL pointer
[./drivers/video/uvesafb.c:1822]: (style) Redundant condition. It is safe t=
o deallocate a NULL pointer
[./drivers/video/uvesafb.c:1824]: (style) Redundant condition. It is safe t=
o deallocate a NULL pointer
[./drivers/video/uvesafb.c:1826]: (style) Redundant condition. It is safe t=
o deallocate a NULL pointer


I checked the source code and I agree with cppcheck.
Patch file attached.

Regards

David Binderman

 		 	   		 =20
_________________________________________________________________
Do you have a story that started on Hotmail? Tell us now
http://clk.atdmt.com/UKM/go/195013117/direct/01/=

--_445ce773-0122-42a9-8d0c-b5a38e5582ea_
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="bug34.patch"

ClNpZ25lZC1vZmYtYnk6IERhdmlkIEJpbmRlcm1hbiA8ZGNiMzE0QGhvdG1haWwuY29tPgoKLS0t
IGRyaXZlcnMvdmlkZW8vdXZlc2FmYi5jLnNhdgkyMDEwLTAyLTIxIDEwOjA4OjI3LjAwMDAwMDAw
MCArMDAwMAorKysgZHJpdmVycy92aWRlby91dmVzYWZiLmMJMjAxMC0wMi0yMSAxMDowOTozNS4w
MDAwMDAwMDAgKzAwMDAKQEAgLTIzNSw4ICsyMzUsNyBAQCBvdXQ6CiBzdGF0aWMgdm9pZCB1dmVz
YWZiX2ZyZWUoc3RydWN0IHV2ZXNhZmJfa3Rhc2sgKnRhc2spCiB7CiAJaWYgKHRhc2spIHsKLQkJ
aWYgKHRhc2stPmRvbmUpCi0JCQlrZnJlZSh0YXNrLT5kb25lKTsKKwkJa2ZyZWUodGFzay0+ZG9u
ZSk7CiAJCWtmcmVlKHRhc2spOwogCX0KIH0KQEAgLTEzMTgsOCArMTMxNyw4IEBAIHNldG1vZGU6
CiAJCQkJRkJfVklTVUFMX1BTRVVET0NPTE9SIDogRkJfVklTVUFMX1RSVUVDT0xPUjsKIAlpbmZv
LT5maXgubGluZV9sZW5ndGggPSBtb2RlLT5ieXRlc19wZXJfc2Nhbl9saW5lOwogCi1vdXQ6CWlm
IChjcnRjICE9IE5VTEwpCi0JCWtmcmVlKGNydGMpOworb3V0OgorCWtmcmVlKGNydGMpOwogCXV2
ZXNhZmJfZnJlZSh0YXNrKTsKIAogCXJldHVybiBlcnI7CkBAIC0xNzk2LDggKzE3OTUsNyBAQCBv
dXRfbW9kZToKIAlmYl9kZXN0cm95X21vZGVkYihpbmZvLT5tb25zcGVjcy5tb2RlZGIpOwogCWZi
X2RlYWxsb2NfY21hcCgmaW5mby0+Y21hcCk7CiBvdXQ6Ci0JaWYgKHBhci0+dmJlX21vZGVzKQot
CQlrZnJlZShwYXItPnZiZV9tb2Rlcyk7CisJa2ZyZWUocGFyLT52YmVfbW9kZXMpOwogCiAJZnJh
bWVidWZmZXJfcmVsZWFzZShpbmZvKTsKIAlyZXR1cm4gZXJyOwpAQCAtMTgxOSwxMiArMTgxNyw5
IEBAIHN0YXRpYyBpbnQgdXZlc2FmYl9yZW1vdmUoc3RydWN0IHBsYXRmb3IKIAkJZmJfZGVhbGxv
Y19jbWFwKCZpbmZvLT5jbWFwKTsKIAogCQlpZiAocGFyKSB7Ci0JCQlpZiAocGFyLT52YmVfbW9k
ZXMpCi0JCQkJa2ZyZWUocGFyLT52YmVfbW9kZXMpOwotCQkJaWYgKHBhci0+dmJlX3N0YXRlX29y
aWcpCi0JCQkJa2ZyZWUocGFyLT52YmVfc3RhdGVfb3JpZyk7Ci0JCQlpZiAocGFyLT52YmVfc3Rh
dGVfc2F2ZWQpCi0JCQkJa2ZyZWUocGFyLT52YmVfc3RhdGVfc2F2ZWQpOworCQkJa2ZyZWUocGFy
LT52YmVfbW9kZXMpOworCQkJa2ZyZWUocGFyLT52YmVfc3RhdGVfb3JpZyk7CisJCQlrZnJlZShw
YXItPnZiZV9zdGF0ZV9zYXZlZCk7CiAJCX0KIAogCQlmcmFtZWJ1ZmZlcl9yZWxlYXNlKGluZm8p
Owo=

--_445ce773-0122-42a9-8d0c-b5a38e5582ea_--
