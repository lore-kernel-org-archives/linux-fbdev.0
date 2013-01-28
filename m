From: "Mohammed, Afzal" <afzal@ti.com>
Date: Mon, 28 Jan 2013 09:17:19 +0000
Subject: RE: RE: RE: [PATCH v4 12/12] video: da8xx-fb: CCF clock divider handling
Message-Id: <C8443D0743D26F4388EA172BF4E2A7A93EA943E9@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1358937685.git.afzal@ti.com>
 <fa8dab522507e087d5a94bac13dda71544911707.1358937685.git.afzal@ti.com>
 <20130123202204.9205.66575@quantum>
 <C8443D0743D26F4388EA172BF4E2A7A93EA92ADF@DBDE01.ent.ti.com>
 <20130124170044.10623.45314@quantum>
 <C8443D0743D26F4388EA172BF4E2A7A93EA9383E@DBDE01.ent.ti.com>
 <20130125224453.10623.74434@quantum>
In-Reply-To: <20130125224453.10623.74434@quantum>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Valkeinen,
 Tomi" <tomi.valkeinen-l0cyMroinI0@public.gmane.org>

SGkgTWlrZSwNCg0KT24gU2F0LCBKYW4gMjYsIDIwMTMgYXQgMDQ6MTQ6NTMsIE1pa2UgVHVycXVl
dHRlIHdyb3RlOg0KDQo+IEkgdGhpbmsgUGF1bCBXLiBvciBzb21lb25lIG9uIHRoZSBUSSBzaWRl
IHNob3VsZCB3ZWlnaCBpbiBvbiB5b3VyIGNsa2Rldg0KPiBlbnRyaWVzLiAgTXkgbWFpbiBwb2lu
dCBpcyB0aGF0IHRoZSBhY3R1YWwgdHJlZSBzaG91bGQgYmUgbW9kZWxlZCBhbmQNCj4gY2xvY2tz
IHNob3VsZG4ndCBiZSBnbG9iYmVkIHRvZ2V0aGVyIHVubmVjZXNzYXJpbHkuICBBcyBtZW50aW9u
ZWQgaW4gdGhlDQo+IG90aGVyIG1haWwgdGhyZWFkIHlvdSBtaWdodCBiZSBiZXR0ZXIgb2ZmIG1h
a2luZyBhIGRpdmlkZXIgZm9yIHlvdXIgTENEQw0KPiBJUCBibG9jayBhbmQgbW9kZWxpbmcgZWFj
aCBub2RlIGluZGl2aWR1YWxseS4NCg0KSXQgc2VlbXMgY29tcGxleGl0eSBvZiBkcml2ZXIgd291
bGQgaW5jcmVhc2UgYnkgY3JlYXRpbmcgYSBuZXcgaW5oZXJpdGVkDQpkaXZpZGVyIGNsb2NrIGFu
ZCBoYXZpbmcgYSB0b3RhbCAzLTQgY2xvY2sgbm9kZXMuIFRoZSBhZHZhbnRhZ2UgZ29pbmcNCndp
dGggaXQgd291bGQgYmUgaGlnaGVyIGNvbmZpZ3VyYWJsZSByZXNvbHV0aW9uIGZvciBwaXhlbCBj
bG9jay4NCkN1cnJlbnQgdXNlIGNhc2VzIHdvcmsgd2l0aG91dCBoaWdoZXIgcGl4ZWwgY2xvY2sg
cmVzb2x1dGlvbi4NCg0KQW5kIGRybSBkcml2ZXIgcG9zdGVkIGZvciB0aGUgc2FtZSBJUCBpcyB3
aXRob3V0IENDRiBtb2RlbGluZy4NCg0KU28gSSB3aWxsIHByZXNlbnRseSBub3QgbW9kZWwgY2xv
Y2sgbm9kZXMgaW4gTENEQyBJUCwgbGF0ZXIgaWYgdXNlIGNhc2VzDQpiYWRseSByZXF1aXJlLCB0
aGlzIGNhbiBiZSBkb25lIChhbmQgaWYgaXQgaGFwcGVucywgaG9wZWZ1bGx5IGJ5IHRoYXQNCkRh
VmluY2kgd291bGQgYmUgQ0NGJ2VkIGFuZCBpdCB3b3VsZCBiZSBtb3JlIGNsZWFuIHRvIGltcGxl
bWVudCBpdCkuDQoNClRoYW5rcyBmb3Igc2hhcmluZyB5b3VyIGlkZWFzLg0KDQpSZWdhcmRzDQpB
ZnphbA0K
