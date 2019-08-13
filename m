From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 13 Aug 2019 10:30:22 +0000
Subject: Re: [PATCH 10/11] mfd: Drop obsolete JZ4740 driver
Message-Id: <20190813103022.GB26727@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190725220215.460-1-paul@crapouillou.net>
 <20190725220215.460-11-paul@crapouillou.net>
 <20190812081640.GA26727@dell>
 <4b48e597-951e-45fd-dfb2-4a1292a8b067@amsat.org>
 <1565690508.1856.0@crapouillou.net>
In-Reply-To: <1565690508.1856.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1254"
Content-Transfer-Encoding: base64
To: Paul Cercueil <paul@crapouillou.net>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-fbdev@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, James Hogan <jhogan@kernel.org>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, od@zcrc.me, linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>, Artur Rojek <contact@artur-rojek.eu>, Richard Weinberger <richard@nod.at>, linux-pm@vger.kernel.org, Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kerne>

T24gVHVlLCAxMyBBdWcgMjAxOSwgUGF1bCBDZXJjdWVpbCB3cm90ZToKCj4gSGkgUGhpbGlwcGUs
Cj4gCj4gCj4gTGUgbWFyLiAxMyBhb8O7dCAyMDE5IMOgIDEwOjQ0LCBQaGlsaXBwZSA9P2lzby04
ODU5LTE/cT9NYXRoaWV1LURhdWTpPz4gPGY0YnVnQGFtc2F0Lm9yZz4gYSDDqWNyaXQgOgo+ID4g
SGkgTGVlLAo+ID4gCj4gPiBPbiA4LzEyLzE5IDEwOjE2IEFNLCBMZWUgSm9uZXMgd3JvdGU6Cj4g
PiA+ICBPbiBUaHUsIDI1IEp1bCAyMDE5LCBQYXVsIENlcmN1ZWlsIHdyb3RlOgo+ID4gPiAKPiA+
ID4gPiAgSXQgaGFzIGJlZW4gcmVwbGFjZWQgd2l0aCB0aGUgaW5nZW5pYy1paW8gZHJpdmVyIGZv
ciB0aGUgQURDLgo+ID4gPiA+IAo+ID4gPiA+ICBTaWduZWQtb2ZmLWJ5OiBQYXVsIENlcmN1ZWls
IDxwYXVsQGNyYXBvdWlsbG91Lm5ldD4KPiA+ID4gPiAgVGVzdGVkLWJ5OiBBcnR1ciBSb2playA8
Y29udGFjdEBhcnR1ci1yb2play5ldT4KPiA+ID4gPiAgLS0tCj4gPiA+ID4gICBkcml2ZXJzL21m
ZC9LY29uZmlnICAgICAgfCAgIDkgLS0KPiA+ID4gPiAgIGRyaXZlcnMvbWZkL01ha2VmaWxlICAg
ICB8ICAgMSAtCj4gPiA+ID4gICBkcml2ZXJzL21mZC9qejQ3NDAtYWRjLmMgfCAzMjQKPiA+ID4g
PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ID4gPiAgIDMgZmls
ZXMgY2hhbmdlZCwgMzM0IGRlbGV0aW9ucygtKQo+ID4gPiA+ICAgZGVsZXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvbWZkL2p6NDc0MC1hZGMuYwo+ID4gPiAKPiA+ID4gIEFwcGxpZWQsIHRoYW5rcy4K
PiA+IAo+ID4gSXQgc2VlbXMgdGhlIHJlcGxhY2VtZW50IGlzIGRvbmUgaW4gIk1JUFM6IHFpX2xi
NjA6IE1pZ3JhdGUgdG8KPiA+IGRldmljZXRyZWUiIHdoaWNoIGlzIG5vdCB5ZXQgbWVyZ2VkLgo+
IAo+IEl0J3MgbWVyZ2VkIGluIHRoZSBNSVBTIHRyZWUsIHRob3VnaCwgc28gaXQnbGwgYmxlbmQg
dG9nZXRoZXIganVzdAo+IGZpbmUgaW4gbGludXgtbmV4dC4KCldvbmRlcmZ1bC4gIFRoYW5rcyBQ
YXVsLgoKLS0gCkxlZSBKb25lcyBb5p2O55C85pavXQpMaW5hcm8gU2VydmljZXMgVGVjaG5pY2Fs
IExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZv
bGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2c=
