From: =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Date: Thu, 20 Dec 2018 12:13:56 +0000
Subject: [PATCH v2 3/4] ARM: dts: imx28-cfa10036: Fix the reset gpio signal polarity
Message-Id: <1545308005-51559-4-git-send-email-michal.vokac@ysoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1545308005-51559-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1545308005-51559-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Ripard <maxime.ripard@bootlin.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>

VGhlIHJlc2V0IHNpZ25hbCBvZiB0aGUgU1NEMTMwNiBPTEVEIGRpc3BsYXkgaXMgYWN0dWFsbHkg
YWN0aXZlLWxvdy4NCkFkYXB0IHRoZSBEVCB0byByZWZsZWN0IHRoZSByZWFsIHdvcmxkLg0KDQpS
ZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6
IE1pY2hhbCBWb2vDocSNIDxtaWNoYWwudm9rYWNAeXNvZnQuY29tPg0KLS0tDQpDaGFuZ2VzIGZy
b20gdjE6DQogLSBBZGQgUi1ieSBmcm9tIFJvYg0KDQogYXJjaC9hcm0vYm9vdC9kdHMvaW14Mjgt
Y2ZhMTAwMzYuZHRzIHwgMyArKy0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXgyOC1jZmEx
MDAzNi5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9pbXgyOC1jZmExMDAzNi5kdHMNCmluZGV4IDgz
MzdjYTIuLmQ2ZWNhMzEgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXgyOC1jZmEx
MDAzNi5kdHMNCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDI4LWNmYTEwMDM2LmR0cw0KQEAg
LTExLDYgKzExLDcgQEANCiANCiAvZHRzLXYxLzsNCiAjaW5jbHVkZSAiaW14MjguZHRzaSINCisj
aW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9ncGlvLmg+DQogDQogLyB7DQogCW1vZGVsID0gIkNy
eXN0YWxmb250eiBDRkEtMTAwMzYgQm9hcmQiOw0KQEAgLTk1LDcgKzk2LDcgQEANCiAJCQkJCXBp
bmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQogCQkJCQlwaW5jdHJsLTAgPSA8JnNzZDEzMDZfY2Zh
MTAwMzY+Ow0KIAkJCQkJcmVnID0gPDB4M2M+Ow0KLQkJCQkJcmVzZXQtZ3Bpb3MgPSA8JmdwaW8y
IDcgMD47DQorCQkJCQlyZXNldC1ncGlvcyA9IDwmZ3BpbzIgNyBHUElPX0FDVElWRV9MT1c+Ow0K
IAkJCQkJc29sb21vbixoZWlnaHQgPSA8MzI+Ow0KIAkJCQkJc29sb21vbix3aWR0aCA9IDwxMjg+
Ow0KIAkJCQkJc29sb21vbixwYWdlLW9mZnNldCA9IDwwPjsNCi0tIA0KMi4xLjQNCg0K
