From: =?euc-kr?B?x9HB+LG4?= <jg1.han@samsung.com>
Date: Thu, 16 May 2013 02:04:02 +0000
Subject: Re: [PATCH 1/2] video: exynos_dp: Add parsing of gpios pins to exynos-dp driver
Message-Id: <26364319.123371368669839202.JavaMail.weblogic@epml12>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1528008.HgBKZQmFTy@amdc1227>
In-Reply-To: <1528008.HgBKZQmFTy@amdc1227>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomasz Figa <t.figa@samsung.com>, Vikas Sajjan <vikas.sajjan@linaro.org>
Cc: =?euc-kr?Q?=C7=D1=C1=F8=B1=B8?= <jg1.han@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, =?euc-kr?Q?=B1=E8=B1=B9=C1=F8?= <kgene.kim@samsung.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "FlorianSchandinat@gmx.de" <FlorianSchandinat@gmx.de>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

VHVlc2RheSwgTWF5IDE0LCAyMDEzIDExOjE3IFBNLCBWaWthcyBTYWpqYW4gd3JvdGU6DQo+IA0K
PiBIaSBWaWthcywNCj4gDQo+IE9uIFR1ZXNkYXkgMTQgb2YgTWF5IDIwMTMgMTg6MjU6NTEgVmlr
YXMgU2FqamFuIHdyb3RlOg0KPiA+ICBBZGRzIEdQSU8gcGFyc2luZyBmdW5jdGlvbmFsaXR5IGZv
ciAiTENEIGJhY2tsaWdodCIgYW5kICJMQ0QgZW5hYmxlIg0KPiA+ICBHUElPIHBpbnMgb2YgZXh5
bm9zIGRwIGNvbnRyb2xsZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBWaWthcyBTYWpqYW4g
PHZpa2FzLnNhamphbkBsaW5hcm8ub3JnPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3ZpZGVvL2V4
eW5vcy9leHlub3NfZHBfY29yZS5jIHwgICA0NQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKyAxIGZpbGUgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+IA0KPiBJ
IGRvbid0IHRoaW5rIHRoYXQgRXh5bm9zIERQIGRyaXZlciBpcyByaWdodCBwbGFjZSBmb3Igc3Vj
aCBjb2RlLiBCYWNrbGlnaHQNCj4gYW5kIExDRCBkcml2ZXJzIGFyZSByZXNwb25zaWJsZSBmb3Ig
YmFja2xpZ2h0IGFuZCBMQ0QgcG93ZXIgY29udHJvbCB1c2luZw0KPiBiYWNrbGlnaHQgYW5kIExD
RCBzdWJzeXN0ZW1zLg0KPiANCj4gSU1ITyB0aGUgY29ycmVjdCBzb2x1dGlvbiB3b3VsZCBiZSB0
byBlaXRoZXIgZXh0ZW5kIGV4aXN0aW5nIGJhY2tsaWdodC9sY2QNCj4gZHJpdmVycyBmb3VuZCBp
biBkcml2ZXJzL3ZpZGVvL2JhY2tsaWdodCB0byBzdXBwb3J0IGRpcmVjdCBHUElPIGNvbnRyb2wg
YW5kDQo+IHBhcnNlIEdQSU8gcGlucyBmcm9tIGRldmljZSB0cmVlIG9yIGNyZWF0ZSBuZXcgZ3Bp
b19ibCBhbmQgZ3Bpb19sY2QgZHJpdmVycy4NCg0KSGkgVmlrYXMgU2FqaWFuLA0KDQpJIGFncmVl
IHdpdGggVG9tYXN6IEZpZ2EncyBvcGluaW9uLg0KQmFja2xpZ2h0L0xDRCBmcmFtZXdvcmsgc2hv
dWxkIGJlIHVzZWQuDQplRFAgcGFuZWwgYmFja2xpZ2h0IG9uIFNNREs1MjEwIGJvYXJkIGNhbiBi
ZSBjb250cm9sbGVkIGJ5IFBXTTsNCnRodXMsIHB3bS1iYWNrbGlnaHQgZHJpdmVyIHNob3VsZCBi
ZSB1c2VkLg0KQWxzbywgZURQIHBhbmVsIHJlc2V0IHBpbiBzaG91bGQgYmUgY29udHJvbGxlZCBi
eSB1c2luZw0KcGxhdGZvcm0tbGNkIGRyaXZlci4NCg0KPiANCj4gQ0NpbmcgUmljaGFyZCwgRmxv
cmlhbiBhbmQgbGludXgtZmJkZXYuDQoNCkFsc28sIEkgaGF2ZSBiZWVuIGRvaW5nIGJhY2tsaWdo
dCByZXZpZXdzIGluc3RlYWQgb2YgUmljaGFyZCwNCnBsZWFzZSBkbyBDQydpbmcgbWUuDQoNCkJl
c3QgcmVnYXJkcywNCkppbmdvbyBIYW4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBUb21hc3oN
Cg=


