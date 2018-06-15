From: Leonard Crestez <leonard.crestez@nxp.com>
Date: Fri, 15 Jun 2018 20:58:06 +0000
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Message-Id: <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
         <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
         <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
In-Reply-To: <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "festevam@gmail.com" <festevam@gmail.com>, "stefan@agner.ch" <stefan@agner.ch>, "marex@denx.de" <marex@denx.de>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "marcofrk@gmail.com" <marcofrk@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>

T24gRnJpLCAyMDE4LTA2LTE1IGF0IDE2OjQ3IC0wMzAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
DQo+IE9uIEZyaSwgSnVuIDE1LCAyMDE4IGF0IDQ6NDMgUE0sIExlb25hcmQgQ3Jlc3Rleg0KPiA8
bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+IHdyb3RlOg0KPiA+IFRoZSBGQkRFViBkcml2ZXIgdXNl
cyB0aGUgc2FtZSBuYW1lIGFuZCBib3RoIGNhbid0IGJlIHJlZ2lzdGVyZWQgYXQgdGhlDQo+ID4g
c2FtZSB0aW1lLiBGaXggdGhpcyBieSByZW5hbWluZyB0aGUgZHJtIGRyaXZlciB0byBteHNmYi1k
cm0NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jl
c3RlekBueHAuY29tPg0KPiANCj4gU3RlZmFuIHNlbnQgdGhlIHNhbWUgcGF0Y2ggYSBmZXcgZGF5
cyBhZ286DQo+IGh0dHA6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvZHJpLWRldmVsL21zZzE3OTQ4
OS5odG1sDQoNCkluIHRoYXQgdGhyZWFkIHRoZXJlIGlzIGEgcHJvcG9zYWwgZm9yIHJlbW92aW5n
IHRoZSBvbGQgZmJkZXYvbXhzZmINCmRyaXZlciBlbnRpcmVseS4NCg0KVGhhdCB3b3VsZCBicmVh
ayBvbGQgRFRCcywgaXNuJ3QgdGhpcyBnZW5lcmFsbHkgY29uc2lkZXJlZCBiYWQ/IEFsc28sDQph
cmUgd2Ugc3VyZSB0aGUgcmVtb3ZhbCBvZiBmYmRldi9teHNmYiB3b3VsZG4ndCBsb3NlIGFueSBm
ZWF0dXJlcz8NCg0KV2hhdCBteSBzZXJpZXMgZG9lcyBpcyBtYWtlIGJvdGggZHJpdmVycyB3b3Jr
IHdpdGggdGhlIHNhbWUga2VybmVsDQppbWFnZSBhbmQgdHVybnMgdGhlIGNob2ljZSBpbnRvIGEg
Ym9hcmQtbGV2ZWwgZHRiIGRlY2lzaW9uLiBTdXBwb3J0aW5nDQpldmVyeXRoaW5nIGF0IG9uY2Ug
c2VlbXMgZGVzaXJhYmxlIHRvIG1lIGFuZCBpdCBhbGxvd3MgZm9yIGEgdmVyeQ0Kc21vb3RoIHVw
Z3JhZGUgcGF0aC4NCg0KVGhlIG9sZCBkcml2ZXIgY291bGQgYmUgcmVtb3ZlZCBsYXRlciwgYWZ0
ZXIgYWxsIHVzZXJzIGFyZSBjb252ZXJ0ZWQuDQoNCi0tDQpSZWdhcmRzLA0KTGVvbmFyZA=
