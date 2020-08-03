From: Jiri Slaby <jirislaby@kernel.org>
Date: Mon, 03 Aug 2020 08:08:43 +0000
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
Message-Id: <9386c640-34dd-0a50-5694-4f87cc600e0f@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <659f8dcf-7802-1ca1-1372-eb7fefd4d8f4@kernel.org>
 <dbcf2841-7718-2ba7-11e0-efa4b9de8de1@nsfocus.com>
 <9fb43895-ca91-9b07-ebfd-808cf854ca95@nsfocus.com>
In-Reply-To: <9fb43895-ca91-9b07-ebfd-808cf854ca95@nsfocus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ibm855"
Content-Transfer-Encoding: base64
To: =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>, Solar Designer <solar@openwall.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Kyungtae Kim <kt0755@gmail.com>, b.zolnierkie@samsung.com, Greg KH <greg@kroah.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, DRI devel <dri-devel@lists.freedesktop.org>, Anthony Liguori <aliguori@amazon.com>, Yang Yingliang <yangyingliang@huawei.com>, xiao.zhang@windriver.com, Linus Torvalds <torvalds@linux-foundation.org>, "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>

SGksCgpPbiAzMS4gMDcuIDIwLCA3OjIyLCDVxdTGuqMgd3JvdGU6Cj4gUmVtb3ZlIHdoaXRlc3Bh
Y2UgYXQgRU9MCgpJIGFtIGZpbmUgd2l0aCB0aGUgcGF0Y2guIEhvd2V2ZXIgaXQgc2hvdWxkIGJl
IHNlbnQgcHJvcGVybHkgKGlubGluZQptYWlsLCBoYXZpbmcgYSBQQVRDSCBzdWJqZWN0IGV0Yy4g
LS0gc2VlCkRvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0KS4gZ2l0
IHNlbmQtZW1haWwgYWZ0ZXIgZ2l0CmZvcm1hdC1wYXRjaCBoYW5kbGVzIG1vc3Qgb2YgaXQuCgpU
aGVyZSBpcyBhbHNvIHF1ZXN0aW9uIHdobyBpcyB3aWxsaW5nIHRvIHRha2UgaXQ/CgpCYXJ0PyBH
cmVnPyBTaG91bGQgd2Ugcm91dGUgaXQgdmlhIGFrcG0sIG9yIHdpbGwgeW91IExpbnVzIGRpcmVj
dGx5PyAoSQpjYW4gc2lnbiBvZmYgYW5kIHJlc2VuZCB0aGUgcGF0Y2ggd2hpY2ggd2FzIGF0dGFj
aGVkIHRvIHRoZSBtYWlsIEkgYW0KcmVwbHlpbmcgdG8gdG9vLCBpZiBuZWVkIGJlLikKCnRoYW5r
cywKLS0gCmpzCnN1c2UgbGFicw==
