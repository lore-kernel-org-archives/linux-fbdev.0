From: Dave Airlie <airlied@gmail.com>
Date: Sun, 20 Dec 2009 06:11:07 +0000
Subject: Re: drivers/gpu/drm/radeon/radeon_test.c:45: undefined reference to
Message-Id: <21d7e9970912192211y6cb02557se261787f3b56d2a8@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="001636ed6870ac29a5047b22d6ed"
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LNX.2.01.0912181147200.9874@filesrv1.baby-dragons.com>
In-Reply-To: <alpine.LNX.2.01.0912181147200.9874@filesrv1.baby-dragons.com>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev@vger.kernel.org, Linux Kernel Maillist <linux-kernel@vger.kernel.org>

--001636ed6870ac29a5047b22d6ed
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 19, 2009 at 6:54 AM, Mr. James W. Laferriere
<babydr@baby-dragons.com> wrote:
> =A0 =A0 =A0 =A0Hello Benjamin , =A0I am not having a good time compiling =
2.6.32.1 .
> First RCU 'inline' difficulties then fusion-mpt 'inline' difficulty , =A0=
Now
> this .
> =A0 =A0 =A0 =A0This one is not a simple as removing 'inline' from a state=
ment .
> =A0 =A0 =A0 =A0Would you please look into this ? =A0Anything else you nee=
d please just
> ask .
> =A0 =A0 =A0 =A0Please cc: me as I am not subscribed to linux-fbdev .
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Tia , =A0JimL
>

Can you try the attached patch?

Dave.

--001636ed6870ac29a5047b22d6ed
Content-Type: application/octet-stream; 
	name="0001-drm-radeon-fix-build-on-64-bit-with-some-compilers.patch"
Content-Disposition: attachment; 
	filename="0001-drm-radeon-fix-build-on-64-bit-with-some-compilers.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g3ff5b980

RnJvbSAzYzVmYWY5ZTFhMmQ0MjlhN2UzZTE2YzdlYmYwZTgxNjYxOTcyYTkxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZlIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KRGF0ZTog
U3VuLCAyMCBEZWMgMjAwOSAxNjowODo0MCArMTAwMApTdWJqZWN0OiBbUEFUQ0hdIGRybS9yYWRl
b246IGZpeCBidWlsZCBvbiA2NC1iaXQgd2l0aCBzb21lIGNvbXBpbGVycy4KCmRyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX3Rlc3QuYzo0NTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgX191
ZGl2ZGkzJwoKUmVwb3J0ZWQtYnk6IE1yLiBKYW1lcyBXLiBMYWZlcnJpZXJlIDxiYWJ5ZHJAYmFi
eS1kcmFnb25zLmNvbT4KU2lnbmVkLW9mZi1ieTogRGF2ZSBBaXJsaWUgPGFpcmxpZWRAcmVkaGF0
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90ZXN0LmMgfCAgICA0ICsr
LS0KIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3Rlc3QuYyBiL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX3Rlc3QuYwppbmRleCAzOTFjOTczLi45ZjVlMmY5IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90ZXN0LmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdGVzdC5jCkBAIC00Miw4ICs0Miw4IEBAIHZvaWQgcmFk
ZW9uX3Rlc3RfbW92ZXMoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCiAJLyogTnVtYmVyIG9m
IHRlc3RzID0KIAkgKiAoVG90YWwgR1RUIC0gSUIgcG9vbCAtIHdyaXRlYmFjayBwYWdlIC0gcmlu
ZyBidWZmZXIpIC8gdGVzdCBzaXplCiAJICovCi0JbiA9IChyZGV2LT5tYy5ndHRfc2l6ZSAtIFJB
REVPTl9JQl9QT09MX1NJWkUqNjQqMTAyNCAtIFJBREVPTl9HUFVfUEFHRV9TSVpFIC0KLQkgICAg
IHJkZXYtPmNwLnJpbmdfc2l6ZSkgLyBzaXplOworCW4gPSAoKHUzMikocmRldi0+bWMuZ3R0X3Np
emUgLSBSQURFT05fSUJfUE9PTF9TSVpFKjY0KjEwMjQgLSBSQURFT05fR1BVX1BBR0VfU0laRSAt
CisJICAgICByZGV2LT5jcC5yaW5nX3NpemUpKSAvIHNpemU7CiAKIAlndHRfb2JqID0ga3phbGxv
YyhuICogc2l6ZW9mKCpndHRfb2JqKSwgR0ZQX0tFUk5FTCk7CiAJaWYgKCFndHRfb2JqKSB7Ci0t
IAoxLjYuNS4yCgo=
--001636ed6870ac29a5047b22d6ed--
