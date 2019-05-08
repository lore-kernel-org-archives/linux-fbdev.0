From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Date: Wed, 08 May 2019 13:22:03 +0000
Subject: Re: [PATCH 03/16] lib,treewide: add new match_string() helper/macro
Message-Id: <b2440bc9485456a7a90a488c528997587b22088b.camel@analog.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190508112842.11654-1-alexandru.ardelean@analog.com>
 <20190508112842.11654-5-alexandru.ardelean@analog.com>
 <20190508131128.GL9224@smile.fi.intel.com>
 <20190508131856.GB10138@kroah.com>
In-Reply-To: <20190508131856.GB10138@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

T24gV2VkLCAyMDE5LTA1LTA4IGF0IDE1OjE4ICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiANCj4g
DQo+IE9uIFdlZCwgTWF5IDA4LCAyMDE5IGF0IDA0OjExOjI4UE0gKzAzMDAsIEFuZHkgU2hldmNo
ZW5rbyB3cm90ZToNCj4gPiBPbiBXZWQsIE1heSAwOCwgMjAxOSBhdCAwMjoyODoyOVBNICswMzAw
LCBBbGV4YW5kcnUgQXJkZWxlYW4gd3JvdGU6DQo+ID4gPiBUaGlzIGNoYW5nZSByZS1pbnRyb2R1
Y2VzIGBtYXRjaF9zdHJpbmcoKWAgYXMgYSBtYWNybyB0aGF0IHVzZXMNCj4gPiA+IEFSUkFZX1NJ
WkUoKSB0byBjb21wdXRlIHRoZSBzaXplIG9mIHRoZSBhcnJheS4NCj4gPiA+IFRoZSBtYWNybyBp
cyBhZGRlZCBpbiBhbGwgdGhlIHBsYWNlcyB0aGF0IGRvDQo+ID4gPiBgbWF0Y2hfc3RyaW5nKF9h
LCBBUlJBWV9TSVpFKF9hKSwgcylgLCBzaW5jZSB0aGUgY2hhbmdlIGlzIHByZXR0eQ0KPiA+ID4g
c3RyYWlnaHRmb3J3YXJkLg0KPiA+IA0KPiA+IENhbiB5b3Ugc3BsaXQgaW5jbHVkZS9saW51eC8g
Y2hhbmdlIGZyb20gdGhlIHJlc3Q/DQo+IA0KPiBUaGF0IHdvdWxkIGJyZWFrIHRoZSBidWlsZCwg
d2h5IGRvIHlvdSB3YW50IGl0IHNwbGl0IG91dD8gIFRoaXMgbWFrZXMNCj4gc2Vuc2UgYWxsIGFz
IGEgc2luZ2xlIHBhdGNoIHRvIG1lLg0KPiANCg0KTm90IHJlYWxseS4NCkl0IHdvdWxkIGJlIGp1
c3QgYmUgdGhlIG5ldyBtYXRjaF9zdHJpbmcoKSBoZWxwZXIvbWFjcm8gaW4gYSBuZXcgY29tbWl0
Lg0KQW5kIHRoZSBjb252ZXJzaW9ucyBvZiB0aGUgc2ltcGxlIHVzZXJzIG9mIG1hdGNoX3N0cmlu
ZygpICh0aGUgb25lcyB1c2luZw0KQVJSQVlfU0laRSgpKSBpbiBhbm90aGVyIGNvbW1pdC4NCg0K
VGhhbmtzDQpBbGV4DQoNCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg=
