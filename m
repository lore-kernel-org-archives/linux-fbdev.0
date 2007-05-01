From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] skeletonfb: More corrections
Date: Tue, 01 May 2007 16:57:57 +0200
Message-ID: <4637557596419@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part4637557598b2d"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hitnt-0003ll-GC for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 May 2007 07:58:16 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hitnr-0004ui-MC
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 May 2007 07:58:09 -0700
Received: from poczta-16.free.wp-sa.pl (HELO localhost) ([10.1.1.71])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 1 May 2007 16:57:57 +0200
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--part4637557598b2d
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

More corrections to skeletonfb.c file:
- fixed types of more arguments
- removed returned values in void functions
- removed not existing fb_poll function
- fixed closing comment typo
- corrected misleading constant name ADDR

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch requires patches already sent to mm tree.

Somehow not all fixes went previously into my patch. Some of=20
fixes correct changes in the last patch.

----------------------------------------------------
Skorzystaj ze staro=BFytnej chi=F1skiej m=B1dro=B6ci. Tw=F3j horoskop wio=
senny
- http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fchinski2=
.html&sid=3D1121

--part4637557598b2d
Content-Type: application/octet-stream; name="skeletonfb-more-fixes.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="skeletonfb-more-fixes.diff"

ZGlmZiAtdXJwIGxpbnV4LTIuNi4yMS5vcmlnL2RyaXZlcnMvdmlkZW8vc2tlbGV0b25mYi5jIGxp
bnV4LTIuNi4yMS9kcml2ZXJzL3ZpZGVvL3NrZWxldG9uZmIuYwotLS0gbGludXgtMi42LjIxLm9y
aWcvZHJpdmVycy92aWRlby9za2VsZXRvbmZiLmMJMjAwNy0wNS0wMSAxMToyNDo0Mi4wMDAwMDAw
MDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMS9kcml2ZXJzL3ZpZGVvL3NrZWxldG9uZmIuYwkyMDA3
LTA1LTAxIDE2OjM2OjU0LjAwMDAwMDAwMCArMDIwMApAQCAtMTQ4LDcgKzE0OCw3IEBAIGludCB4
eHhmYl9zZXR1cChjaGFyKik7CiAgKgogICoJUmV0dXJucyBuZWdhdGl2ZSBlcnJubyBvbiBlcnJv
ciwgb3IgemVybyBvbiBzdWNjZXNzLgogICovCi1zdGF0aWMgaW50IHh4eGZiX29wZW4oY29uc3Qg
c3RydWN0IGZiX2luZm8gKmluZm8sIGludCB1c2VyKQorc3RhdGljIGludCB4eHhmYl9vcGVuKHN0
cnVjdCBmYl9pbmZvICppbmZvLCBpbnQgdXNlcikKIHsKICAgICByZXR1cm4gMDsKIH0KQEAgLTE2
Nyw3ICsxNjcsNyBAQCBzdGF0aWMgaW50IHh4eGZiX29wZW4oY29uc3Qgc3RydWN0IGZiX2luCiAg
KgogICoJUmV0dXJucyBuZWdhdGl2ZSBlcnJubyBvbiBlcnJvciwgb3IgemVybyBvbiBzdWNjZXNz
LgogICovCi1zdGF0aWMgaW50IHh4eGZiX3JlbGVhc2UoY29uc3Qgc3RydWN0IGZiX2luZm8gKmlu
Zm8sIGludCB1c2VyKQorc3RhdGljIGludCB4eHhmYl9yZWxlYXNlKHN0cnVjdCBmYl9pbmZvICpp
bmZvLCBpbnQgdXNlcikKIHsKICAgICByZXR1cm4gMDsKIH0KQEAgLTYyOSwxOSArNjI5LDYgQEAg
dm9pZCB4eHhmYl9yb3RhdGUoc3RydWN0IGZiX2luZm8gKmluZm8sIAogfQogCiAvKioKLSAqCXh4
eGZiX3BvbGwgLSBOT1QgYSByZXF1aXJlZCBmdW5jdGlvbi4gVGhlIHB1cnBvc2Ugb2YgdGhpcwot
ICoJCSAgICAgZnVuY3Rpb24gaXMgdG8gcHJvdmlkZSBhIHdheSBmb3Igc29tZSBwcm9jZXNzCi0g
KgkJICAgICB0byB3YWl0IHVudGlsIGEgc3BlY2lmaWMgaGFyZHdhcmUgZXZlbnQgb2NjdXJzCi0g
KgkJICAgICBmb3IgdGhlIGZyYW1lYnVmZmVyIGRldmljZS4KLSAqIAkJCQkgCi0gKiAgICAgIEBp
bmZvOiBmcmFtZSBidWZmZXIgc3RydWN0dXJlIHRoYXQgcmVwcmVzZW50cyBhIHNpbmdsZSBmcmFt
ZSBidWZmZXIKLSAqCUB3YWl0OiBwb2xsIHRhYmxlIHdoZXJlIHdlIHN0b3JlIHByb2Nlc3MgdGhh
dCBhd2FpdCBhIGV2ZW50LiAgICAgCi0gKi8KLXZvaWQgeHh4ZmJfcG9sbChzdHJ1Y3QgZmJfaW5m
byAqaW5mbywgcG9sbF90YWJsZSAqd2FpdCkKLXsKLX0KLQotLyoqCiAgKgl4eHhmYl9zeW5jIC0g
Tk9UIGEgcmVxdWlyZWQgZnVuY3Rpb24uIE5vcm1hbGx5IHRoZSBhY2NlbCBlbmdpbmUgCiAgKgkJ
ICAgICBmb3IgYSBncmFwaGljcyBjYXJkIHRha2UgYSBzcGVjaWZpYyBhbW91bnQgb2YgdGltZS4K
ICAqCQkgICAgIE9mdGVuIHdlIGhhdmUgdG8gd2FpdCBmb3IgdGhlIGFjY2VsZXJhdG9yIHRvIGZp
bmlzaApAQCAtNjc4LDcgKzY2NSw2IEBAIHN0YXRpYyBzdHJ1Y3QgZmJfb3BzIHh4eGZiX29wcyA9
IHsKIAkuZmJfaW1hZ2VibGl0CT0geHh4ZmJfaW1hZ2VibGl0LAkvKiBOZWVkZWQgISEhICovCiAJ
LmZiX2N1cnNvcgk9IHh4eGZiX2N1cnNvciwJCS8qIE9wdGlvbmFsICEhISAqLwogCS5mYl9yb3Rh
dGUJPSB4eHhmYl9yb3RhdGUsCi0JLmZiX3BvbGwJPSB4eHhmYl9wb2xsLAogCS5mYl9zeW5jCT0g
eHh4ZmJfc3luYywKIAkuZmJfaW9jdGwJPSB4eHhmYl9pb2N0bCwKIAkuZmJfbW1hcAk9IHh4eGZi
X21tYXAsCkBAIC02OTIsNyArNjc4LDcgQEAgc3RhdGljIHN0cnVjdCBmYl9vcHMgeHh4ZmJfb3Bz
ID0gewogCiAvKiBzdGF0aWMgaW50IF9faW5pdCB4eGZiX3Byb2JlIChzdHJ1Y3QgZGV2aWNlICpk
ZXZpY2UpIC0tIGZvciBwbGF0Zm9ybSBkZXZzICovCiBzdGF0aWMgaW50IF9fZGV2aW5pdCB4eHhm
Yl9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqZGV2LAotCQkJICAgICAgY29uc3Rfc3RydWN0IHBjaV9k
ZXZpY2VfaWQgKmVudCkKKwkJCSAgICAgIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICplbnQp
CiB7CiAgICAgc3RydWN0IGZiX2luZm8gKmluZm87CiAgICAgc3RydWN0IHh4eF9wYXIgKnBhcjsK
QEAgLTg1OCw4ICs4NDQsNiBAQCBzdGF0aWMgdm9pZCBfX2RldmV4aXQgeHh4ZmJfcmVtb3ZlKHN0
cnVjCiAJCS8qIC4uLiAqLwogCQlmcmFtZWJ1ZmZlcl9yZWxlYXNlKGluZm8pOwogCX0KLQotCXJl
dHVybiAwOwogfQogCiAjaWZkZWYgQ09ORklHX1BDSQpAQCAtOTAyLDcgKzg4Niw3IEBAIHN0YXRp
YyBpbnQgeHh4ZmJfcmVzdW1lKHN0cnVjdCBwY2lfZGV2ICoKIHN0YXRpYyBzdHJ1Y3QgcGNpX2Rl
dmljZV9pZCB4eHhmYl9pZF90YWJsZVtdID0gewogCXsgUENJX1ZFTkRPUl9JRF9YWFgsIFBDSV9E
RVZJQ0VfSURfWFhYLAogCSAgUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgUENJX0JBU0VfQ0xBU1Nf
RElTUExBWSA8PCAxNiwKLQkgIEFERFIsIDAgfSwKKwkgIFBDSV9DTEFTU19NQVNLLCAwIH0sCiAJ
eyAwLCB9CiB9OwogCkBAIC0xMDMzLDcgKzEwMTcsNyBAQCBpbnQgX19pbml0IHh4eGZiX3NldHVw
KGNoYXIgKm9wdGlvbnMpCiB7CiAgICAgLyogUGFyc2UgdXNlciBzcGVmaWNpZWQgb3B0aW9ucyAo
YHZpZGVvPXh4eGZiOicpICovCiB9Ci0jZW5kaWYgLyogTU9EVUxFICo/CisjZW5kaWYgLyogTU9E
VUxFICovCiAKIC8qIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gKi8KIAo=

--part4637557598b2d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part4637557598b2d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part4637557598b2d--
