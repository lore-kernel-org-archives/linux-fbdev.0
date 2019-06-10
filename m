From: Matt Redfearn <matt.redfearn@thinci.com>
Date: Mon, 10 Jun 2019 13:14:56 +0000
Subject: Re: [PATCH 5/8] drivers: media: coda: fix warning same module names
Message-Id: <c2ff2c77-5c14-4bc4-f59c-7012d272ec76@thinci.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190606094722.23816-1-anders.roxell@linaro.org>
 <d6b79ee0-07c6-ad81-16b0-8cf929cc214d@xs4all.nl>
 <CADYN=9KY5=FzrkC7MKj9QnG-eM1NVuL00w8Xv4yU2r05rhr7WQ@mail.gmail.com>
In-Reply-To: <CADYN=9KY5=FzrkC7MKj9QnG-eM1NVuL00w8Xv4yU2r05rhr7WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anders Roxell <anders.roxell@linaro.org>, Hans Verkuil <hverkuil@xs4all.nl>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, David Airlie <airlied@linux.ie>, "stefan@agner.ch" <stefan@agner.ch>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "a.hajda@samsung.com" <a.hajda@samsung.com>, Lee Jones <lee.jones@linaro.org>, "marex@denx.de" <marex@denx.de>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Mark Brown <broonie@kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Networking <netdev@vger.kernel.org>, Liam Girdwood <lg>

DQoNCk9uIDEwLzA2LzIwMTkgMTQ6MDMsIEFuZGVycyBSb3hlbGwgd3JvdGU6DQo+IE9uIFRodSwg
NiBKdW4gMjAxOSBhdCAxMjoxMywgSGFucyBWZXJrdWlsIDxodmVya3VpbEB4czRhbGwubmw+IHdy
b3RlOg0KPj4NCj4+IE9uIDYvNi8xOSAxMTo0NyBBTSwgQW5kZXJzIFJveGVsbCB3cm90ZToNCj4+
PiBXaGVuIGJ1aWxkaW5nIHdpdGggQ09ORklHX1ZJREVPX0NPREEgYW5kIENPTkZJR19DT0RBX0ZT
IGVuYWJsZWQgYXMNCj4+PiBsb2FkYWJsZSBtb2R1bGVzLCB3ZSBzZWUgdGhlIGZvbGxvd2luZyB3
YXJuaW5nOg0KPj4+DQo+Pj4gd2FybmluZzogc2FtZSBtb2R1bGUgbmFtZXMgZm91bmQ6DQo+Pj4g
ICAgZnMvY29kYS9jb2RhLmtvDQo+Pj4gICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9jb2RhL2Nv
ZGEua28NCj4+Pg0KPj4+IFJld29yayBzbyBtZWRpYSBjb2RhIG1hdGNoZXMgdGhlIGNvbmZpZyBm
cmFnbWVudC4gTGVhdmluZyBDT0RBX0ZTIGFzIGlzDQo+Pj4gc2luY2UgdGhhdHMgYSB3ZWxsIGtu
b3duIG1vZHVsZS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEFuZGVycyBSb3hlbGwgPGFuZGVy
cy5yb3hlbGxAbGluYXJvLm9yZz4NCj4+PiAtLS0NCj4+PiAgIGRyaXZlcnMvbWVkaWEvcGxhdGZv
cm0vY29kYS9NYWtlZmlsZSB8IDQgKystLQ0KPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL2NvZGEvTWFrZWZpbGUgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2NvZGEv
TWFrZWZpbGUNCj4+PiBpbmRleCA1NGU5YTczYTkyYWIuLjU4OGU2YmY3YzE5MCAxMDA2NDQNCj4+
PiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2NvZGEvTWFrZWZpbGUNCj4+PiArKysgYi9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL2NvZGEvTWFrZWZpbGUNCj4+PiBAQCAtMSw2ICsxLDYgQEAN
Cj4+PiAgICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPj4+DQo+Pj4g
LWNvZGEtb2JqcyA6PSBjb2RhLWNvbW1vbi5vIGNvZGEtYml0Lm8gY29kYS1nZGkubyBjb2RhLWgy
NjQubyBjb2RhLW1wZWcyLm8gY29kYS1tcGVnNC5vIGNvZGEtanBlZy5vDQo+Pj4gK3ZpZGVvLWNv
ZGEtb2JqcyA6PSBjb2RhLWNvbW1vbi5vIGNvZGEtYml0Lm8gY29kYS1nZGkubyBjb2RhLWgyNjQu
byBjb2RhLW1wZWcyLm8gY29kYS1tcGVnNC5vIGNvZGEtanBlZy5vDQo+Pj4NCj4+PiAtb2JqLSQo
Q09ORklHX1ZJREVPX0NPREEpICs9IGNvZGEubw0KPj4+ICtvYmotJChDT05GSUdfVklERU9fQ09E
QSkgKz0gdmlkZW8tY29kYS5vDQo+Pg0KPj4gSG93IGFib3V0IGlteC1jb2RhPyB2aWRlby1jb2Rh
IHN1Z2dlc3RzIGl0IGlzIHBhcnQgb2YgdGhlIHZpZGVvIHN1YnN5c3RlbSwNCj4+IHdoaWNoIGl0
IGlzbid0Lg0KPiANCj4gSSdsbCByZXNlbmQgYSB2MiBzaG9ydGx5IHdpdGggaW14LWNvZGEgaW5z
dGVhZC4NCg0KV2hhdCBhYm91dCBvdGhlciB2ZW5kb3IgU29DcyBpbXBsZW1lbnRpbmcgdGhlIENv
ZGEgSVAgYmxvY2sgd2hpY2ggYXJlIA0Kbm90IGFuIGlteD8gSSdkIHByZWZlciBhIG1vcmUgZ2Vu
ZXJpYyBuYW1lIC0gbWF5YmUgbWVkaWEtY29kYS4NCg0KVGhhbmtzLA0KTWF0dA0KDQo+IA0KPiAN
Cj4gQ2hlZXJzLA0KPiBBbmRlcnMNCj4gDQo+Pg0KPj4gUmVnYXJkcywNCj4+DQo+PiAgICAgICAg
ICBIYW5zDQo+Pg0KPj4+ICAgb2JqLSQoQ09ORklHX1ZJREVPX0lNWF9WRE9BKSArPSBpbXgtdmRv
YS5vDQo+Pj4NCj4+DQo
