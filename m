From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 12 Jan 2016 12:44:12 +0000
Subject: Re: [RESEND PATCH 1/2] devicetree: mxsfb: add reset-active property
Message-Id: <5694F51C.7040107@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5KeKpCIvWrmmOJAsR5GNG7i2I2j3KCaNm"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1452594141-26073-1-git-send-email-mans@mansr.com>
In-Reply-To: <1452594141-26073-1-git-send-email-mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
To: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--5KeKpCIvWrmmOJAsR5GNG7i2I2j3KCaNm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 12/01/16 12:22, Mans Rullgard wrote:
> Some boards connect the LCD_RESET pin to a reset input on the
> display panel.  On these boards, this pin must be set to the
> proper level for the display to function.
>=20
> This adds an optional "reset-active" property to the "display"
> subnode such that devicetrees can specify the desired polarity
> of the LCD_RESET pin.
>=20
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  Documentation/devicetree/bindings/display/mxsfb.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/mxsfb.txt b/Docu=
mentation/devicetree/bindings/display/mxsfb.txt
> index 96ec5179c8a0..cb7212a6bdf2 100644
> --- a/Documentation/devicetree/bindings/display/mxsfb.txt
> +++ b/Documentation/devicetree/bindings/display/mxsfb.txt
> @@ -13,6 +13,11 @@ Required properties:
>  - bits-per-pixel : <16> for RGB565, <32> for RGB888/666.
>  - bus-width : number of data lines.  Could be <8>, <16>, <18> or <24>.=

> =20
> +Optional properties:
> +- reset-active : <0>: reset pin is active low
> +                 <1>: reset pin is active high
> +                 omitted: reset pin not used
> +
>  Required sub-node:
>  - display-timings : Refer to binding doc display-timing.txt for detail=
s.

So maybe this is fine for the mxsfb if it doesn't support any kind of
panel drivers, and there's no plan to extend it. Otherwise the LCD_RESET
pin could perhaps be exposed as a GPIO for the panel drivers.

But even so, I think the definition of "reset" is a bit vague.

I know panels for which "reset" is a pulse, you assert it for a short
period. Other panels take reset more like a on/off switch. If I'm not
mistaken, this one is the latter kind.

I don't see any sleeps related to reset in the code. If reset is
asserted when the display is blanked, is it guaranteed that the reset
stays asserted long enough until the display is enabled again?

 Tomi


--5KeKpCIvWrmmOJAsR5GNG7i2I2j3KCaNm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWlPUdAAoJEPo9qoy8lh71L0sP/jxLQiym+W5FpfffaIewsik2
GF0idTsNiQ2C4aPVEl/ABo39LcDo81i2u8YNo02q4hKwAEMVcB3vByrjAjBxPUgW
uYQasa1NeXwLIwxES3qMbas9ABBXE9yAm/r51MlvXWUbwzFj2sZaYIvblFEtJTGU
APdy/kHMhBMcmdy1Mc43gnh6CTs7gRMKhf92n2Whm+R4xji8Bo3sI32ZAEDx2GrW
KY/BInFEupLb7lL51uehe+FriAigtPMZjJoo8Kf7bHTbYkd9JiIPFGEMn+U3xJUw
IRINet3jxZlQHVAkAY3qSVek91odbtBQRrD8pTYs417c9nciytb8FKoPKvsjgyb6
wegJf+tf4A3aDehwrYa2IESiOLmTYGkUe4z/SGox5vBorBTJVfefl5v3L1rb31d8
qd4tAh88Tx9TJzOePg3aM+ZckMe9kfwxE1JHVdfbrgjUpEM9xs2lg53Z4Gk0BnUx
kurch4sBOZqieCyVxeLuL2JeST3GDiDQNWFIJW08X1d63MDBG/ShoX3vFHgHtrHr
KJrX9unVRJl1Zr7i4JUzWNakiDu573hcPs3dYrP10Y3sBp0I0ZX4rVdPgUTQLrBZ
VKBYFF0g1qIAAD784P53h6bxs5cnbTtjNiu1F6SsFRoTAyh0BDx9SX1E2+fmZDFE
MoV7fQTHqUEl5VDCYE+b
=Wq/S
-----END PGP SIGNATURE-----

--5KeKpCIvWrmmOJAsR5GNG7i2I2j3KCaNm--
