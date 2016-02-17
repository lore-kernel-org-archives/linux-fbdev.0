From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 17 Feb 2016 09:11:18 +0000
Subject: Re: [PATCH 07/11] Documentation/DT: add Versatile display bindings
Message-Id: <56C43936.2060808@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sfj4C2M0Q2JKXUvmEKapDQ8ReMsOe00jD"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-8-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1454594660-7532-8-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org

--Sfj4C2M0Q2JKXUvmEKapDQ8ReMsOe00jD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 04/02/16 16:04, Linus Walleij wrote:
> This adds bindings for the LCD displays that can be found connected
> to the ARM Versatile reference design, interface boards IB1 and
> IB2.
>=20
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/display/panel/epson,l2f50113t00.txt        | 7=
 +++++++
>  .../devicetree/bindings/display/panel/sanyo,alr252rgt.txt          | 7=
 +++++++
>  .../devicetree/bindings/display/panel/sanyo,tm38qv67a02a.txt       | 7=
 +++++++
>  .../devicetree/bindings/display/panel/sharp,lq084v1dg21.txt        | 7=
 +++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt              | 1=
 +
>  5 files changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/eps=
on,l2f50113t00.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/san=
yo,alr252rgt.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/san=
yo,tm38qv67a02a.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/sha=
rp,lq084v1dg21.txt
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/epson,l2f5=
0113t00.txt b/Documentation/devicetree/bindings/display/panel/epson,l2f50=
113t00.txt
> new file mode 100644
> index 000000000000..58eca804dbe8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/epson,l2f50113t00=
=2Etxt
> @@ -0,0 +1,7 @@
> +Epson Mobile display
> +
> +Required properties:
> +- compatible: should be "epson,l2f50113t00"
> +
> +This binding is compatible with the panel-dpi binding, which is specif=
ied
> +in panel-dpi.txt in this directory.

Do we really want to add new binding doc files for all panels, even if
they just point to a more generic binding? We may end up with quite a
lot of these, each only saying "look at the panel-dpi.txt".

 Tomi


--Sfj4C2M0Q2JKXUvmEKapDQ8ReMsOe00jD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxDk3AAoJEPo9qoy8lh71N5YP/35zXzJSZShGL8xttVd3x/7M
rr64VVDmZlxAA5GtaJdMcI52FNj1ILNwy66Y1ChFKP7Sim141Z2+q1uhec3VcGHB
CpGDhGJ3RDr1fI4FsraxyP8ynjnsO4JUqEj2PlSlFp+nibxFs63Y0ck0iSmLuCq2
FIdK8wz0bWZmwSFdv3Mmm9tACM1B+83eYKADoNVE4aVG6qv3viOr4GhI5WKPZISN
tdURRvh7ab/im3yCfiIgKkXaqNge+4NwO7jB6Jf6Pm7+DV1LZshYahT3vbTsvYuy
MGi2TkUxkTso9eHmPhIKCwiqkUyOoHPbhiLuEjiihUObvVM3nx6yL99DVAN8ijEm
+U5c0CJIlM8RpJbOcNlHyAS4OXCqbu81Cb7ZhdkCc85k0X//a6wxUlFOcbzf+D9X
8hoNBlij4XIS+Ic0c/jETM1zfQ0VH2C+KyEmSifkzMVmF3JWDHyHG4FRRAiP/73D
t6jXm4fsRcMfCxk7BdRV2BZtXZLk7XWCVqwRyserTDJZcod2mWwMaIaWeltIugU1
SRZB2yQyWndc+LTrE/dCSKgB8d4nYy47nNStLT4wz5vDYW9CS73tYKTYulZmQGUN
K16Jd8u9xJrpdFlRYaf/zBOFsw14ONwO/CJHiF3dlCdGn6510RDhgwjhaehTtUPv
hWlNOmZZLiDM7YozROag
=uux5
-----END PGP SIGNATURE-----

--Sfj4C2M0Q2JKXUvmEKapDQ8ReMsOe00jD--
