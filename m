From: =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Date: Tue, 04 Dec 2018 15:03:38 +0000
Subject: [PATCH 3/4] ARM: dts: imx28-cfa10036: Fix the reset gpio signal polarity
Message-Id: <1543935806-94880-4-git-send-email-michal.vokac@ysoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1543935806-94880-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1543935806-94880-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Ripard <maxime.ripard@bootlin.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>

VGhlIHJlc2V0IHNpZ25hbCBvZiB0aGUgU1NEMTMwNiBPTEVEIGRpc3BsYXkgaXMgYWN0dWFsbHkg
YWN0aXZlLWxvdy4NCkFkYXB0IHRoZSBEVCB0byByZWZsZWN0IHRoZSByZWFsIHdvcmxkLg0KDQpT
aWduZWQtb2ZmLWJ5OiBNaWNoYWwgVm9rw6HEjSA8bWljaGFsLnZva2FjQHlzb2Z0LmNvbT4NCi0t
LQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDI4LWNmYTEwMDM2LmR0cyB8IDMgKystDQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vYm9vdC9kdHMvaW14MjgtY2ZhMTAwMzYuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMv
aW14MjgtY2ZhMTAwMzYuZHRzDQppbmRleCA4MzM3Y2EyLi5kNmVjYTMxIDEwMDY0NA0KLS0tIGEv
YXJjaC9hcm0vYm9vdC9kdHMvaW14MjgtY2ZhMTAwMzYuZHRzDQorKysgYi9hcmNoL2FybS9ib290
L2R0cy9pbXgyOC1jZmExMDAzNi5kdHMNCkBAIC0xMSw2ICsxMSw3IEBADQogDQogL2R0cy12MS87
DQogI2luY2x1ZGUgImlteDI4LmR0c2kiDQorI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bp
by5oPg0KIA0KIC8gew0KIAltb2RlbCA9ICJDcnlzdGFsZm9udHogQ0ZBLTEwMDM2IEJvYXJkIjsN
CkBAIC05NSw3ICs5Niw3IEBADQogCQkJCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KIAkJ
CQkJcGluY3RybC0wID0gPCZzc2QxMzA2X2NmYTEwMDM2PjsNCiAJCQkJCXJlZyA9IDwweDNjPjsN
Ci0JCQkJCXJlc2V0LWdwaW9zID0gPCZncGlvMiA3IDA+Ow0KKwkJCQkJcmVzZXQtZ3Bpb3MgPSA8
JmdwaW8yIDcgR1BJT19BQ1RJVkVfTE9XPjsNCiAJCQkJCXNvbG9tb24saGVpZ2h0ID0gPDMyPjsN
CiAJCQkJCXNvbG9tb24sd2lkdGggPSA8MTI4PjsNCiAJCQkJCXNvbG9tb24scGFnZS1vZmZzZXQg
PSA8MD47DQotLSANCjIuMS40DQoNCg=
