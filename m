From: Thibaut VARENE <varenet@esiee.fr>
Subject: Re: Re: [PATCH][RFC] Add support for Epson S1D13806 FB
Date: Mon, 14 Mar 2005 15:12:50 +0100
Message-ID: <20050314141250.3E0B936591C@mail.esiee.fr>
References: <200503142153.48697.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="'ThIs-RaNdOm-StRiNg-/=_.210689685:"
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAqJV-00033r-5D
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 06:12:57 -0800
Received: from mail.esiee.fr ([147.215.1.3])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAqJU-0001tz-Ht
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 06:12:57 -0800
In-Reply-To: <200503142153.48697.adaplas@hotpop.com>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Thibaut VARENE <T-Bone@parisc-linux.org>, Antonino Daplas <adaplas@pol.net>, Ben Dooks <ben-linux-arm@fluff.org>


--'ThIs-RaNdOm-StRiNg-/=_.210689685:
MIME-Version: 1.0
Content-Length: 310
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

-------------------=20
> Once the platform bits are fixed, if ever, let me know or submit an
> incremental patch.

Oops, willing to do things fast and doing them too fast. Please
disregard the previous incremental patch, sent you the wrong file (not
fixed the release_mem_region() calls).

Thibaut VARENE
--'ThIs-RaNdOm-StRiNg-/=_.210689685:
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Content-Length: 3592
Content-Type: application/octet-stream;name=patch-s1d13xxxfb_driver-2.diff
Content-Disposition: attachment;filename=patch-s1d13xxxfb_driver-2.diff

LS0tIGxpbnV4LTIuNi4xMC5vcmlnL2RyaXZlcnMvdmlkZW8vczFkMTN4eHhmYi5jCTIwMDUtMDMt
MTQgMTQ6NTc6NTkuNTEwMzMyNzY4ICswMTAwCisrKyBsaW51eC0yLjYuMTAubmV3L2RyaXZlcnMv
dmlkZW8vczFkMTN4eHhmYi5jCTIwMDUtMDMtMTQgMTU6MDk6MjkuODE4Mzg5OTkyICswMTAwCkBA
IC0zNjgsNyArMzY4LDYgQEAKIAogc3RhdGljIHN0cnVjdCBmYl9vcHMgczFkMTN4eHhmYl9mYm9w
cyA9IHsKIAkub3duZXIJCT0gVEhJU19NT0RVTEUsCi0JLmZiX2NoZWNrX3Zhcgk9IHMxZDEzeHh4
ZmJfY2hlY2tfdmFyLAogCS5mYl9zZXRfcGFyCT0gczFkMTN4eHhmYl9zZXRfcGFyLAogCS5mYl9z
ZXRjb2xyZWcJPSBzMWQxM3h4eGZiX3NldGNvbHJlZywKIAkuZmJfYmxhbmsJPSBzMWQxM3h4eGZi
X2JsYW5rLApAQCAtNTE5LDkgKzUxOCw5IEBACiAJfQogCQogCXJlbGVhc2VfbWVtX3JlZ2lvbihw
ZGV2LT5yZXNvdXJjZVswXS5zdGFydCwgCi0JCQlwZGV2LT5yZXNvdXJjZVswXS5lbmQgLSBwZGV2
LT5yZXNvdXJjZVswXS5zdGFydCk7CisJCQlwZGV2LT5yZXNvdXJjZVswXS5lbmQgLSBwZGV2LT5y
ZXNvdXJjZVswXS5zdGFydCArMSk7CiAJcmVsZWFzZV9tZW1fcmVnaW9uKHBkZXYtPnJlc291cmNl
WzFdLnN0YXJ0LCAKLQkJCXBkZXYtPnJlc291cmNlWzFdLmVuZCAtIHBkZXYtPnJlc291cmNlWzFd
LnN0YXJ0KTsKKwkJCXBkZXYtPnJlc291cmNlWzFdLmVuZCAtIHBkZXYtPnJlc291cmNlWzFdLnN0
YXJ0ICsxKTsKIAlyZXR1cm4gMDsKIH0KIApAQCAtNTYzLDE0ICs1NjIsMTQgQEAKIAl9CiAJCiAJ
aWYgKCFyZXF1ZXN0X21lbV9yZWdpb24ocGRldi0+cmVzb3VyY2VbMF0uc3RhcnQsIAotCQlwZGV2
LT5yZXNvdXJjZVswXS5lbmQgLSBwZGV2LT5yZXNvdXJjZVswXS5zdGFydCwgInMxZDEzeHh4ZmIg
bWVtIikpIHsKKwkJcGRldi0+cmVzb3VyY2VbMF0uZW5kIC0gcGRldi0+cmVzb3VyY2VbMF0uc3Rh
cnQgKzEsICJzMWQxM3h4eGZiIG1lbSIpKSB7CiAJCWRldl9kYmcoZGV2LCAicmVxdWVzdF9tZW1f
cmVnaW9uIGZhaWxlZFxuIik7CiAJCXJldCA9IC1FQlVTWTsKIAkJZ290byBiYWlsOwogCX0KIAog
CWlmICghcmVxdWVzdF9tZW1fcmVnaW9uKHBkZXYtPnJlc291cmNlWzFdLnN0YXJ0LCAKLQkJcGRl
di0+cmVzb3VyY2VbMV0uZW5kIC0gcGRldi0+cmVzb3VyY2VbMV0uc3RhcnQsICJzMWQxM3h4eGZi
IHJlZ3MiKSkgeworCQlwZGV2LT5yZXNvdXJjZVsxXS5lbmQgLSBwZGV2LT5yZXNvdXJjZVsxXS5z
dGFydCArMSwgInMxZDEzeHh4ZmIgcmVncyIpKSB7CiAJCWRldl9kYmcoZGV2LCAicmVxdWVzdF9t
ZW1fcmVnaW9uIGZhaWxlZFxuIik7CiAJCXJldCA9IC1FQlVTWTsKIAkJZ290byBiYWlsOwpAQCAt
NTg0LDcgKzU4Myw3IEBACiAKIAlkZWZhdWx0X3BhciA9IGluZm8tPnBhcjsKIAlkZWZhdWx0X3Bh
ci0+cmVncyA9IGlvcmVtYXBfbm9jYWNoZShwZGV2LT5yZXNvdXJjZVsxXS5zdGFydCwKLQkJCXBk
ZXYtPnJlc291cmNlWzFdLmVuZCAtIHBkZXYtPnJlc291cmNlWzFdLnN0YXJ0KTsKKwkJCXBkZXYt
PnJlc291cmNlWzFdLmVuZCAtIHBkZXYtPnJlc291cmNlWzFdLnN0YXJ0ICsxKTsKIAlpZiAoIWRl
ZmF1bHRfcGFyLT5yZWdzKSB7CiAJCXByaW50ayhLRVJOX0VSUiBQRlggInVuYWJsZSB0byBtYXAg
cmVnaXN0ZXJzXG4iKTsKIAkJcmV0ID0gLUVOT01FTTsKQEAgLTU5Myw3ICs1OTIsNyBAQAogCWlu
Zm8tPnBzZXVkb19wYWxldHRlID0gZGVmYXVsdF9wYXItPnBzZXVkb19wYWxldHRlOwogCiAJaW5m
by0+c2NyZWVuX2Jhc2UgPSBpb3JlbWFwX25vY2FjaGUocGRldi0+cmVzb3VyY2VbMF0uc3RhcnQs
Ci0JCQlwZGV2LT5yZXNvdXJjZVswXS5lbmQgLSBwZGV2LT5yZXNvdXJjZVswXS5zdGFydCk7CisJ
CQlwZGV2LT5yZXNvdXJjZVswXS5lbmQgLSBwZGV2LT5yZXNvdXJjZVswXS5zdGFydCArMSk7CiAJ
CQkKIAlpZiAoIWluZm8tPnNjcmVlbl9iYXNlKSB7CiAJCXByaW50ayhLRVJOX0VSUiBQRlggInVu
YWJsZSB0byBtYXAgZnJhbWVidWZmZXJcbiIpOwpAQCAtNjEwLDkgKzYwOSw5IEBACiAJCiAJaW5m
by0+Zml4ID0gczFkMTN4eHhmYl9maXg7IAogCWluZm8tPmZpeC5tbWlvX3N0YXJ0ID0gcGRldi0+
cmVzb3VyY2VbMV0uc3RhcnQ7Ci0JaW5mby0+Zml4Lm1taW9fbGVuID0gcGRldi0+cmVzb3VyY2Vb
MV0uZW5kIC0gcGRldi0+cmVzb3VyY2VbMV0uc3RhcnQ7CisJaW5mby0+Zml4Lm1taW9fbGVuID0g
cGRldi0+cmVzb3VyY2VbMV0uZW5kIC0gcGRldi0+cmVzb3VyY2VbMV0uc3RhcnQgKzE7CiAJaW5m
by0+Zml4LnNtZW1fc3RhcnQgPSBwZGV2LT5yZXNvdXJjZVswXS5zdGFydDsKLQlpbmZvLT5maXgu
c21lbV9sZW4gPSBwZGV2LT5yZXNvdXJjZVswXS5lbmQgLSBwZGV2LT5yZXNvdXJjZVswXS5zdGFy
dDsKKwlpbmZvLT5maXguc21lbV9sZW4gPSBwZGV2LT5yZXNvdXJjZVswXS5lbmQgLSBwZGV2LT5y
ZXNvdXJjZVswXS5zdGFydCArMTsKIAogCXByaW50ayhLRVJOX0lORk8gUEZYICJyZWdzIG1hcHBl
ZCBhdCAweCVwLCBmYiAlZCBLaUIgbWFwcGVkIGF0IDB4JXBcbiIsCiAJICAgICAgIGRlZmF1bHRf
cGFyLT5yZWdzLCBpbmZvLT5maXguc21lbV9sZW4gLyAxMDI0LCBpbmZvLT5zY3JlZW5fYmFzZSk7
Cg==
--'ThIs-RaNdOm-StRiNg-/=_.210689685:--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
