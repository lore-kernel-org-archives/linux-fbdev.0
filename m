From: "Mohammed, Afzal" <afzal@ti.com>
Date: Mon, 07 Jan 2013 09:21:15 +0000
Subject: RE: [PATCH 08/10] video: da8xx-fb: obtain fb_videomode info from dt
Message-Id: <C8443D0743D26F4388EA172BF4E2A7A93EA7FC7A@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1357304090.git.afzal@ti.com>
 <78e026555731e0bbe8475610279d3e5265d124b9.1357304090.git.afzal@ti.com>
 <20130107091131.GC23478@pengutronix.de>
In-Reply-To: <20130107091131.GC23478-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Nori,
 Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Valkeinen,
 Tomi" <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

SGkgU3RlZmZlbiwNCg0KT24gTW9uLCBKYW4gMDcsIDIwMTMgYXQgMTQ6NDE6MzEsIFN0ZWZmZW4g
VHJ1bXRyYXIgd3JvdGU6DQo+IE9uIE1vbiwgSmFuIDA3LCAyMDEzIGF0IDEwOjQxOjMwQU0gKzA1
MzAsIEFmemFsIE1vaGFtbWVkIHdyb3RlOg0KDQo+ID4gT2J0YWluIGZiX3ZpZGVvbW9kZSBkZXRh
aWxzIGZvciB0aGUgY29ubmVjdGVkIGxjZCBwYW5lbCB1c2luZyB0aGUNCj4gPiBkaXNwbGF5IHRp
bWluZyBkZXRhaWxzIHByZXNlbnQgaW4gRFQuDQoNCj4gPiArLSBkaXNwbGF5LXRpbWluZ3M6IGxp
c3Qgb2YgZGlmZmVyZW50IHZpZGVvbW9kZXMgc3VwcG9ydGVkIGJ5IHRoZSBsY2QNCj4gPiArICBw
YW5lbCwgcmVwcmVzZW50ZWQgYXMgY2hpbGRzLCBjYW4gaGF2ZSBtdWx0aXBsZSBtb2RlcyBzdXBw
b3J0ZWQsIGlmDQo+ID4gKyAgb25seSBvbmUsIHRoZW4gaXQgaXMgY29uc2lkZXJlZCBuYXRpdmUg
bW9kZSwgaWYgbXVsdGlwbGUgbW9kZXMgYXJlDQo+ID4gKyAgcHJvdmlkZWQsIG5hdGl2ZSBtb2Rl
IGNhbiBiZSBzZXQgZXhwbGljaXRseSwgbW9yZSBkZXRhaWxzIGF2YWlsYWJsZQ0KPiA+ICsgIEBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdmlkZW8vZGlzcGxheS10aW1pbmcudHh0
DQoNCj4gS2VlcCBpbiBtaW5kIHRoYXQgdGhlIHRleHQgY29tYmluZWQgd2l0aC4uLg0KDQo+ID4g
KwkJaWYgKG9mX2dldF9mYl92aWRlb21vZGUobnAsIGxjZGNfaW5mbywgMCkpIHsNCj4gPiArCQkJ
ZGV2X2VycigmZGV2LT5kZXYsICJ0aW1pbmdzIG5vdCBhdmFpbGFibGUgaW4gRFRcbiIpOw0KPiA+
ICsJCQlyZXR1cm4gTlVMTDsNCj4gPiArCQl9DQo+ID4gKwkJcmV0dXJuIGxjZGNfaW5mbzsNCj4g
PiArCX0NCj4gDQo+IC4uLiB0aGlzIGlzIG5vdCBjb3JyZWN0LiBZb3UgYXJlIGp1c3Qgc3VwcG9y
dGluZyB0aGUgZmlyc3QgZGlzcGxheS10aW1pbmdzDQo+IHN1Ym5vZGUgKG9mX2dldF9mYl92aWRl
b21vZGUoLi4uLCAwKSkuDQoNCg0KWWVzIHJpZ2h0LCBJIHdpbGwgbW9kaWZ5IHRoZSB0ZXh0IHRv
IHJlZmxlY3Qgd2hhdCB0aGUgZHJpdmVyIGRvZXMuDQoNClJlZ2FyZHMNCkFmemFsDQo