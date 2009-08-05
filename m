From: InKi Dae <daeinki@gmail.com>
Subject: [PATCH] fixed distortedness situation for Samsung SoC Framebuffer 
	Driver
Date: Wed, 5 Aug 2009 19:31:43 +0900
Message-ID: <90b950fc0908050331i7c98a008qc3e66ce849019cb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175cd6946afa7b04706282be
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934181AbZHEKbp@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Kyungmin Park <kmpark@infradead.org>

--0015175cd6946afa7b04706282be
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch solves the problem that image is distorted in the mode more
then 24bpp.

In 16bit mode, WINCON0[16] should be Swap Enable(HAWSWP_F) and in the
mode more then 24bpp,
WINCON0[15] should be Swap Enable(WSWP_F).

For this, I added a MACRO in regs-fb.h file for 24bpp+ and modified
s3c-fb.c file also.
It was tested on s5pc100 and s5pc110 and worked fine.

signed-off-by: InKi Dae <inki.dae@samsung.com>

Thank you.

--0015175cd6946afa7b04706282be
Content-Type: application/octet-stream; name="s3cfb.patch"
Content-Disposition: attachment; filename="s3cfb.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fxzwujqz0

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtczNjL2luY2x1ZGUvcGxhdC9yZWdzLWZiLmggYi9h
cmNoL2FybS9wbGF0LXMzYy9pbmNsdWRlL3BsYXQvcmVncy1mYi5oCmluZGV4IGU5ZWU1OTkuLmFl
NWViNWQgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL3BsYXQtczNjL2luY2x1ZGUvcGxhdC9yZWdzLWZi
LmgKKysrIGIvYXJjaC9hcm0vcGxhdC1zM2MvaW5jbHVkZS9wbGF0L3JlZ3MtZmIuaApAQCAtMTcz
LDYgKzE3Myw3IEBACiAjZGVmaW5lIFdJTkNPTnhfQklUU1dQCQkJCSgxIDw8IDE4KQogI2RlZmlu
ZSBXSU5DT054X0JZVFNXUAkJCQkoMSA8PCAxNykKICNkZWZpbmUgV0lOQ09OeF9IQVdTV1AJCQkJ
KDEgPDwgMTYpCisjZGVmaW5lIFdJTkNPTnhfV1NXUAkJCQkoMSA8PCAxNSkKICNkZWZpbmUgV0lO
Q09OeF9CVVJTVExFTl9NQVNLCQkJKDB4MyA8PCA5KQogI2RlZmluZSBXSU5DT054X0JVUlNUTEVO
X1NISUZUCQkJKDkpCiAjZGVmaW5lIFdJTkNPTnhfQlVSU1RMRU5fMTZXT1JECQkJKDB4MCA8PCA5
KQpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9zM2MtZmIuYyBiL2RyaXZlcnMvdmlkZW8vczNj
LWZiLmMKaW5kZXggNWE3MjA4My4uMjRkNTZlZCAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9z
M2MtZmIuYworKysgYi9kcml2ZXJzL3ZpZGVvL3MzYy1mYi5jCkBAIC00MjIsNiArNDIyLDcgQEAg
c3RhdGljIGludCBzM2NfZmJfc2V0X3BhcihzdHJ1Y3QgZmJfaW5mbyAqaW5mbykKIAkJZWxzZQog
CQkJZGF0YSB8PSBXSU5DT04wX0JQUE1PREVfMjRCUFBfODg4OwogCisJCWRhdGEgfD0gV0lOQ09O
eF9XU1dQOwogCQlkYXRhIHw9IFdJTkNPTnhfQlVSU1RMRU5fMTZXT1JEOwogCQlicmVhazsKIAl9
Cg==
--0015175cd6946afa7b04706282be--
