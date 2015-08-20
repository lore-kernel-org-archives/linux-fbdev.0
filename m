From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 20 Aug 2015 10:51:15 +0000
Subject: Re: [PATCH] video: fbdev: atmel: fix warning for const return value
Message-Id: <55D5B123.8090000@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="TLl9CrVcp85Dswn60sEGE849NFTXPtrC5"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438011701-18423-1-git-send-email-robh@kernel.org> <20150807052221.GC3537@sudip-pc>
In-Reply-To: <20150807052221.GC3537@sudip-pc>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

--TLl9CrVcp85Dswn60sEGE849NFTXPtrC5
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 07/08/15 08:22, Sudip Mukherjee wrote:
> On Mon, Jul 27, 2015 at 10:41:41AM -0500, Rob Herring wrote:
>> A const on a return value is meaningless and generates a warning on so=
me
>> versions of gcc:
>>
>> drivers/video/fbdev/atmel_lcdfb.c:1003: warning: type qualifiers ignor=
ed on function return type
> maybe this one should have been static instead of const.

I think that makes sense. I will apply the following patch instead of Rob=
's,
if no one complains.

Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date:   Thu Aug 20 13:46:10 2015 +0300

    video: fbdev: atmel: fix warning for const return value
   =20
    A const on a return value is meaningless and generates a warning on s=
ome
    versions of gcc:
   =20
    drivers/video/fbdev/atmel_lcdfb.c:1003: warning: type qualifiers igno=
red on function return type
   =20
    The function in question is only used inside the .c file, so the auth=
or
    of the code most likely means "static" instead of "const".
   =20
    Change the const to static.
   =20
    Reported-by: Fengguang Wu <fengguang.wu@intel.com>
    Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atme=
l_lcdfb.c
index abadc490fa1f..016cae1425a4 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -999,7 +999,7 @@ static const char *atmel_lcdfb_wiring_modes[] =3D {
 	[ATMEL_LCDC_WIRING_RGB]	=3D "RGB",
 };
=20
-const int atmel_lcdfb_get_of_wiring_modes(struct device_node *np)
+static int atmel_lcdfb_get_of_wiring_modes(struct device_node *np)
 {
 	const char *mode;
 	int err, i;


--TLl9CrVcp85Dswn60sEGE849NFTXPtrC5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1bEjAAoJEPo9qoy8lh71NmIP/RaL0Fyrlp4gsnyW5+rc9vuM
mMWwLIVKmBap0UTDvUGMhOh18cb+iPwywgJWZU3GXNKhL79Tng04MZiBP1rGAAeO
QRcQafsl0YYKnTkkaOBn97Z0XWK2jSj3CVkJy7DcAiFtrmUveNQq0OT+202x6sea
kvuzzX2bGdm3sMII55r0beav7TdjAlIdOy8tPyn3CTGRwIPtCh9kPg9Lx7RuHzL8
tNp5k0cBjp4c+ytl9jKaygpn2OLvT9qad917oa96t+/PwzxvVho9TriGqb8HH/vW
Ka3rp/n8zndX6t5MFF3OQRV3itRpqd24N5fcWRUwxYSpOMWmy08eueEgQeAE5cnx
1Rv7gNc+EU0nizCWv5OiyW8eY0JMHcQex399Gd8jlaz48mRFt+8iM4GRnfkJSRUo
Oa9lIj5gQbMdvgUz6U3oIYlwupLDiWj6ClM4QHCIhnqUjahJf1hVa5jAHyssl+JJ
R2ErR/4/3M5f+/BVo3RM5zU/JuRJwpX9zxr0e9OBnI0CqkjSgznrZseyWeXyQqRq
EL+mSW+v8Y137XBvLJV9yS5+dID3K9368qJTgMYJZppAu/OrmqFC0/PEDae9vQsX
/aMRClx2St3aDg21nBRHBGWDsFasq02KI6vk1EKveL7QokTLvI3D1X0xltkaIdWn
Q6TtlDpzca8+TrOKekkX
=gklL
-----END PGP SIGNATURE-----

--TLl9CrVcp85Dswn60sEGE849NFTXPtrC5--
