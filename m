From: Thibaut VARENE <varenet@esiee.fr>
Subject: Re: Re: [PATCH][RFC] Add support for Epson S1D13806 FB
Date: Mon, 14 Mar 2005 15:09:05 +0100
Message-ID: <20050314140912.D41C236590E@mail.esiee.fr>
References: <200503142153.48697.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="'ThIs-RaNdOm-StRiNg-/=_.807635741:"
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAqG4-0002tN-AE
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 06:09:24 -0800
Received: from mail.esiee.fr ([147.215.1.3])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAqG2-0001Xs-Mu
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 06:09:24 -0800
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


--'ThIs-RaNdOm-StRiNg-/=_.807635741:
MIME-Version: 1.0
Content-Length: 341
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

-------------------
>=20
> Once the platform bits are fixed, if ever, let me know or submit an
> incremental patch.

They are. Patch is on its way to the platform maintainer :)

Since I had also forgotten to remove the .fb_check_var initialization,
attached is an incremental patch fixing both issues.

Thanks again

Thibaut VARENE
--'ThIs-RaNdOm-StRiNg-/=_.807635741:
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Content-Length: 3098
Content-Type: application/octet-stream;name=patch-s1d13xxxfb_driver-2.diff
Content-Disposition: attachment;filename=patch-s1d13xxxfb_driver-2.diff

LS0tIGxpbnV4LTIuNi4xMC5vcmlnL2RyaXZlcnMvdmlkZW8vczFkMTN4eHhmYi5jCTIwMDUtMDMt
MTQgMTQ6NTc6NTkuNTEwMzMyNzY4ICswMTAwCisrKyBsaW51eC0yLjYuMTAubmV3L2RyaXZlcnMv
dmlkZW8vczFkMTN4eHhmYi5jCTIwMDUtMDMtMTQgMTU6MDM6MDkuODM4MTU1MDAwICswMTAwCkBA
IC0zNjgsNyArMzY4LDYgQEAKIAogc3RhdGljIHN0cnVjdCBmYl9vcHMgczFkMTN4eHhmYl9mYm9w
cyA9IHsKIAkub3duZXIJCT0gVEhJU19NT0RVTEUsCi0JLmZiX2NoZWNrX3Zhcgk9IHMxZDEzeHh4
ZmJfY2hlY2tfdmFyLAogCS5mYl9zZXRfcGFyCT0gczFkMTN4eHhmYl9zZXRfcGFyLAogCS5mYl9z
ZXRjb2xyZWcJPSBzMWQxM3h4eGZiX3NldGNvbHJlZywKIAkuZmJfYmxhbmsJPSBzMWQxM3h4eGZi
X2JsYW5rLApAQCAtNTYzLDE0ICs1NjIsMTQgQEAKIAl9CiAJCiAJaWYgKCFyZXF1ZXN0X21lbV9y
ZWdpb24ocGRldi0+cmVzb3VyY2VbMF0uc3RhcnQsIAotCQlwZGV2LT5yZXNvdXJjZVswXS5lbmQg
LSBwZGV2LT5yZXNvdXJjZVswXS5zdGFydCwgInMxZDEzeHh4ZmIgbWVtIikpIHsKKwkJcGRldi0+
cmVzb3VyY2VbMF0uZW5kIC0gcGRldi0+cmVzb3VyY2VbMF0uc3RhcnQgKzEsICJzMWQxM3h4eGZi
IG1lbSIpKSB7CiAJCWRldl9kYmcoZGV2LCAicmVxdWVzdF9tZW1fcmVnaW9uIGZhaWxlZFxuIik7
CiAJCXJldCA9IC1FQlVTWTsKIAkJZ290byBiYWlsOwogCX0KIAogCWlmICghcmVxdWVzdF9tZW1f
cmVnaW9uKHBkZXYtPnJlc291cmNlWzFdLnN0YXJ0LCAKLQkJcGRldi0+cmVzb3VyY2VbMV0uZW5k
IC0gcGRldi0+cmVzb3VyY2VbMV0uc3RhcnQsICJzMWQxM3h4eGZiIHJlZ3MiKSkgeworCQlwZGV2
LT5yZXNvdXJjZVsxXS5lbmQgLSBwZGV2LT5yZXNvdXJjZVsxXS5zdGFydCArMSwgInMxZDEzeHh4
ZmIgcmVncyIpKSB7CiAJCWRldl9kYmcoZGV2LCAicmVxdWVzdF9tZW1fcmVnaW9uIGZhaWxlZFxu
Iik7CiAJCXJldCA9IC1FQlVTWTsKIAkJZ290byBiYWlsOwpAQCAtNTg0LDcgKzU4Myw3IEBACiAK
IAlkZWZhdWx0X3BhciA9IGluZm8tPnBhcjsKIAlkZWZhdWx0X3Bhci0+cmVncyA9IGlvcmVtYXBf
bm9jYWNoZShwZGV2LT5yZXNvdXJjZVsxXS5zdGFydCwKLQkJCXBkZXYtPnJlc291cmNlWzFdLmVu
ZCAtIHBkZXYtPnJlc291cmNlWzFdLnN0YXJ0KTsKKwkJCXBkZXYtPnJlc291cmNlWzFdLmVuZCAt
IHBkZXYtPnJlc291cmNlWzFdLnN0YXJ0ICsxKTsKIAlpZiAoIWRlZmF1bHRfcGFyLT5yZWdzKSB7
CiAJCXByaW50ayhLRVJOX0VSUiBQRlggInVuYWJsZSB0byBtYXAgcmVnaXN0ZXJzXG4iKTsKIAkJ
cmV0ID0gLUVOT01FTTsKQEAgLTU5Myw3ICs1OTIsNyBAQAogCWluZm8tPnBzZXVkb19wYWxldHRl
ID0gZGVmYXVsdF9wYXItPnBzZXVkb19wYWxldHRlOwogCiAJaW5mby0+c2NyZWVuX2Jhc2UgPSBp
b3JlbWFwX25vY2FjaGUocGRldi0+cmVzb3VyY2VbMF0uc3RhcnQsCi0JCQlwZGV2LT5yZXNvdXJj
ZVswXS5lbmQgLSBwZGV2LT5yZXNvdXJjZVswXS5zdGFydCk7CisJCQlwZGV2LT5yZXNvdXJjZVsw
XS5lbmQgLSBwZGV2LT5yZXNvdXJjZVswXS5zdGFydCArMSk7CiAJCQkKIAlpZiAoIWluZm8tPnNj
cmVlbl9iYXNlKSB7CiAJCXByaW50ayhLRVJOX0VSUiBQRlggInVuYWJsZSB0byBtYXAgZnJhbWVi
dWZmZXJcbiIpOwpAQCAtNjEwLDkgKzYwOSw5IEBACiAJCiAJaW5mby0+Zml4ID0gczFkMTN4eHhm
Yl9maXg7IAogCWluZm8tPmZpeC5tbWlvX3N0YXJ0ID0gcGRldi0+cmVzb3VyY2VbMV0uc3RhcnQ7
Ci0JaW5mby0+Zml4Lm1taW9fbGVuID0gcGRldi0+cmVzb3VyY2VbMV0uZW5kIC0gcGRldi0+cmVz
b3VyY2VbMV0uc3RhcnQ7CisJaW5mby0+Zml4Lm1taW9fbGVuID0gcGRldi0+cmVzb3VyY2VbMV0u
ZW5kIC0gcGRldi0+cmVzb3VyY2VbMV0uc3RhcnQgKzE7CiAJaW5mby0+Zml4LnNtZW1fc3RhcnQg
PSBwZGV2LT5yZXNvdXJjZVswXS5zdGFydDsKLQlpbmZvLT5maXguc21lbV9sZW4gPSBwZGV2LT5y
ZXNvdXJjZVswXS5lbmQgLSBwZGV2LT5yZXNvdXJjZVswXS5zdGFydDsKKwlpbmZvLT5maXguc21l
bV9sZW4gPSBwZGV2LT5yZXNvdXJjZVswXS5lbmQgLSBwZGV2LT5yZXNvdXJjZVswXS5zdGFydCAr
MTsKIAogCXByaW50ayhLRVJOX0lORk8gUEZYICJyZWdzIG1hcHBlZCBhdCAweCVwLCBmYiAlZCBL
aUIgbWFwcGVkIGF0IDB4JXBcbiIsCiAJICAgICAgIGRlZmF1bHRfcGFyLT5yZWdzLCBpbmZvLT5m
aXguc21lbV9sZW4gLyAxMDI0LCBpbmZvLT5zY3JlZW5fYmFzZSk7Cg==
--'ThIs-RaNdOm-StRiNg-/=_.807635741:--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
