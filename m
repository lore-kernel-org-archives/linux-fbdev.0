From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 03 Jun 2015 11:53:33 +0000
Subject: Re: [PATCH 2/4] video: fbdev: imxfb: Constify platform_device_id
Message-Id: <556EEABD.6020902@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="CHnpDIuQsEU42V5WaoKe6C34kPCfLH73h"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430494721-30793-2-git-send-email-k.kozlowski.k@gmail.com>
 <20150505082807.GV4047@x1> <556EE743.5030405@ti.com>
 <20150603115050.GB12304@x1>
In-Reply-To: <20150603115050.GB12304@x1>
To: linux-arm-kernel@lists.infradead.org

--CHnpDIuQsEU42V5WaoKe6C34kPCfLH73h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 03/06/15 14:50, Lee Jones wrote:
> On Wed, 03 Jun 2015, Tomi Valkeinen wrote:
>=20
>> Hi Lee,
>>
>> On 05/05/15 11:28, Lee Jones wrote:
>>> On Sat, 02 May 2015, Krzysztof Kozlowski wrote:
>>>
>>>> The platform_device_id is not modified by the driver and core uses i=
t as
>>>> const.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
>>>> ---
>>>>  drivers/video/fbdev/imxfb.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> Applied, thanks.
>>
>> You applied the fbdev changes in this series also, not only the
>> backlight changes?
>=20
> Ah, yes I did.  I assumed they were all due for Backlight.
>=20
> Would you like me to un-apply the non-Backlight patches?

If you can easily remove them, yes.

But chances for conflict are quite minimal, so if you already have a
pile of commits on top of these, it's fine if they go via backlight tree.=


 Tomi


--CHnpDIuQsEU42V5WaoKe6C34kPCfLH73h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVbuq9AAoJEPo9qoy8lh710NAP/1+RYIk6bmWiWQZlWL+uKYMR
MbEs6La3sCNMa3AbNIT9SKoNUpV8G1fsQMIro6aSMSIKkAxrrORNgTzsLfLthOGs
RgKtbkOp0CFVM4LHIBxhxY93QJwtYujsQYCxc2iKANDD8NmvoPiXdDI5TgdFWDjt
/NYL8A+51R7n9NXohHKj6LMhUSs7xopqvWRN2OoJh3vb/LITGPFXhVMWf6t01jZ9
WJ3QJbJ5iC71Ycj7+tFDx1gJ1BEBFuFCL52LnXjvm4R3dcK1W+G9CsS1nTqI4GlS
6pux+p+1TBVBueIoRr3uM4WCLpE9qzkMwkj8bIKBVZWX9pzX6x6LOcWwnXEysr8y
yHAc2T86Ic36tEKVs57TiZpi1S9NHsgp+1hUjIhCC4R7p4DGWe1jRZYfuAbhpgc8
/xyuHjfNsU62eASlghmd5/ma1SLIMydN5ZAR07MRTYPrtMK0LyvsCgTvBdM0Fp2u
KksRBeTwfjuqaPJ/T3VuTel8xX9XtCvY/dTTP5C2VXGC5mG+b/HMA2FlqrJNRjVr
nzxOggwlsfsNPxzo4135l7GiztLRuiyW8JUQpY6Yg5tvadejqAki8X5babrQkWoz
gRaH1+LIJufQQpet+D5/mD9BPAw+a1BKEMLxOKnq0ZcJm8+6zgoMVt4BEjrE0iqt
hOA6gszC2AOFkklbmJD2
=x4H4
-----END PGP SIGNATURE-----

--CHnpDIuQsEU42V5WaoKe6C34kPCfLH73h--
