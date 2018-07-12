From: Leonard Crestez <leonard.crestez@nxp.com>
Date: Thu, 12 Jul 2018 13:03:14 +0000
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Message-Id: <7f40f34a401ced78703b1a151d9f5fe4ed8c209f.camel@nxp.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
         <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
         <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
         <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
         <638457fd-85da-8fec-d146-517c43f71813@denx.de>
         <b3fa74c5110b45e5992920485749869ab1f7ebce.camel@nxp.com>
         <6995fa4b-47a9-887b-5e4f-4284ca6a2c79@gmail.com>
         <fd22085f646d97f66cff5b7f22785500@agner.ch>
         <6fdba55b-0be6-9e28-d87a-43d876a1fd09@denx.de>
         <617c0a7e9132b929877b8cbcf116b1ea@agner.ch>
In-Reply-To: <617c0a7e9132b929877b8cbcf116b1ea@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "stefan@agner.ch" <stefan@agner.ch>, "marex@denx.de" <marex@denx.de>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "marcofrk@gmail.com" <marcofrk@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "marek.vasut@gmail.com" <marek.vasut@gmail.com>

T24gVGh1LCAyMDE4LTA3LTEyIGF0IDExOjIxICswMjAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IE9uIDEwLjA3LjIwMTggMTE6MTEsIE1hcmVrIFZhc3V0IHdyb3RlOg0KPiA+IE9uIDA3LzEwLzIw
MTggMTE6MDYgQU0sIFN0ZWZhbiBBZ25lciB3cm90ZToNCj4gPiA+IFRoaXMgaXMgb25lIG9mIHRo
ZSBzaXR1YXRpb24gd2hlcmUgc3RhdGVzIHF1byBpcyBraW5kYSB0aGUgd29yc3QNCj4gPiA+IHNp
dHVhdGlvbi4NCj4gPiA+IA0KPiA+ID4gQ3VycmVudGx5IGlteF92Nl92N19kZWZjb25maWcgYW5k
IG14c19kZWZjb25maWcgYWN0dWFsbHkgc3RpbGwgdXNlcw0KPiA+ID4gQ09ORklHX0ZCX01YUy4N
Cj4gPiA+IA0KPiA+ID4gSSB1bmRlcnN0YW5kIHRoYXQgeW91J2QgcmF0aGVyIHByZWZlciB0byBt
b3ZlIGZvcndhcmQuIEkgc3VnZ2VzdCB3ZSBkbw0KPiA+ID4gaXQgaW4gc3RlcHMuDQo+ID4gPiAN
Cj4gPiA+IEluIDQuMTk6DQo+ID4gPiANCj4gPiA+IC0gQ2hhbmdlIERSTSBkcml2ZXIubmFtZSB0
byBteHNmYi1kcm0gc28gd2UgYXZvaWQgY29uZmxpY3RzIGZvciBub3cNCj4gPiANCj4gPiBCdXQg
dGhpcyB3aWxsIGJyZWFrIG1lc2EgaWYgaXQgZGVwZW5kcyBvbiBteHNmYiBuYW1lIGZvciBpZS4g
ZXRuYXZpdg0KPiA+IGJpbmRpbmcuDQo+IA0KPiBEb2VzIGl0PyBncmVwIC1yIC1lIG14c2ZiIGlu
IGxpYmRybSBhbmQgbWVzYSBtYXN0ZXIgcmV0dXJucyBub3RoaW5nLg0KPiANCj4gVGhlcmUgaXMg
YWxzbyAubmFtZSBpbiBzdHJ1Y3QgZHJtX2RyaXZlciwgd2hpY2ggaXMgYWxyZWFkeSBzZXQgdG8N
Cj4gbXhzZmItZHJtLi4uIElzIHRoYXQgdGhlIG9uZSBleHBvc2VkIHRvIHVzZXIgc3BhY2U/DQoN
ClJ1bm5pbmcgZXRuYXZpdit4MTEgd2l0aCBhIHJlbmFtZWQgbXhzZmIgZHJpdmVyIHdvcmtzIGZp
bmUgb24gaW14NnN4LQ0Kc2RiLg0KDQpUb29scyBsaWtlIG1vZGV0ZXN0IGFscmVhZHkgbmVlZCAt
TSBteHNmYi1kcm0sIHRoZSBkcm1fZHJpdmVyLm5hbWUNCnNlZW1zIHRvIGJlIHdoYXQgbWF0dGVy
cy4NCg0KPiAtIFJlbW92ZSBDT05GSUdfRkJfTVhTIGZyb20gaW14X3Y2X3Y3X2RlZmNvbmZpZy9t
eHNfZGVmY29uZmlnIG5vdywgYW5kDQo+IG9ubHkgZW5hYmxlIENPTkZJR19EUk1fTVhTRkI9eQ0K
DQpJZiBvbmUgb2YgdGhlIGRyaXZlcnMgaXMgcmVuYW1lZCB0aGVuIHRoZXkgY2FuIGNvZXhpc3Q6
IHNpbmNlIHRoZQ0KYmluZGluZ3MgYXJlIGRpc3RpbmN0IG9uZSBkcml2ZXIgd2lsbCByZXR1cm4g
YSBwcm9iZSBlcnJvciBhbmQgdGhlDQpvdGhlciB3aWxsIGJpbmQgc3VjY2Vzc2Z1bGx5LiBUaGlz
IGNhbiBldmVuIGJlIGFkanVzdGVkIHNvIHRoYXQgaXQNCmRvZXNuJ3QgZXZlbiBwcmludCB1Z2x5
IHNjYXJ5IGVycm9ycy4NCg0KVGhpcyBjYW4gbGFzdCB1bnRpbCBzb21lYm9keSBpbXBsZW1lbnRz
IHN1cHBvcnQgZm9yIG9sZCBiaW5kaW5ncyBpbiB0aGUNCmRybSBkcml2ZXIgYW5kIHRoZW4gRkJf
TVhTIGNhbiBqdXN0IGJlIGRlbGV0ZWQu
