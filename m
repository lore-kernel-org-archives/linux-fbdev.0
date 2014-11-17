From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 17 Nov 2014 12:47:21 +0000
Subject: Re: [PATCH 2/2] dt-bindings: simplefb-sunxi: Add sunxi simplefb extensions
Message-Id: <20141117124721.GQ6414@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FbmEh7Ek6NM6xKh/"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416224086-5698-1-git-send-email-hdegoede@redhat.com>
 <1416224086-5698-3-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1416224086-5698-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--FbmEh7Ek6NM6xKh/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2014 at 12:34:46PM +0100, Hans de Goede wrote:
> If pre-filled framebuffer nodes are used, the firmware may need extra
> properties to find the right node. This documents the properties to use
> for this on sunxi platforms.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../bindings/video/simple-framebuffer-sunxi.txt    | 33 ++++++++++++++++=
++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/simple-frameb=
uffer-sunxi.txt
>=20
> diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer-s=
unxi.txt b/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi=
=2Etxt
> new file mode 100644
> index 0000000..84ca264
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
> @@ -0,0 +1,33 @@
> +Sunxi specific Simple Framebuffer bindings
> +
> +This binding documents sunxi specific extensions to the simple-framebuff=
er
> +bindings. The sunxi simplefb u-boot code relies on the devicetree contai=
ning
> +pre-populated simplefb nodes.
> +
> +These extensions are intended so that u-boot can select the right node b=
ased
> +on which pipeline and output is being used. As such they are solely inte=
nded
> +for firmware / bootloader use, and the OS should ignore them.
> +
> +Required properties:
> +- compatible: "sunxi,framebuffer"
> +- sunxi,pipeline:
> +  <0> for the de_be0 -> lcdc0 -> output pipeline
> +  <1> for the de_be1 -> lcdc1 -> output pipeline
> +- sunxi,output: One of: "hdmi", "lcd", "vga", and "composite" =20
> +
> +Example:
> +
> +chosen {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	ranges;
> +
> +	framebuffer@0 {
> +		compatible =3D "sunxi,framebuffer", "simple-framebuffer";
> +		sunxi,pipeline =3D <0>;
> +		sunxi,output =3D "hdmi";
> +		clocks =3D <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
> +			 <&ahb_gates 44>;

If we're going that way, then maybe having to specify clock-names
would be better in order to know which clock is what?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--FbmEh7Ek6NM6xKh/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUae5YAAoJEBx+YmzsjxAg1aAP+gOv+CZKDXW01doGBxtkOa3C
TDEyGn4JXhy8eIS7ITY5m1G3/Cg+fHOdsNMMf/ntUhCUFxVAKTJqvTWR2ObJJmDM
lDExIjn4cDkYxxltdgtPV46g79xcK/2iJKfkQ2rhR7taRqQZR09PkqkU3cfApE4g
KTdpsD0dp31uynKpnr/qI9t6eUdwYb4EsDtK4W1t6Kk6wW35eDYbdLjdNsL8Qwb8
rKqHSIbSwn+1CdHvImlgEEfgMhO8VXXTYESgAt8x9z4Vd2igfUuki9CwRQpq6oM0
UaYjZeaDHree2eNC6d/3x9ruuRpzFQsd9dwb2grptv6u/jVe3ml9lVfelBxm0gUF
xKGG+SD+aqPuPOhb6E9CvaWpKqXxPiDWIkBcOtm9I7k0roq3tGt4a0gtNeJNRSZl
evrioHpnKPE5dfdFuaf0ZWTdlZAb3Fw7ysYxNyadts3BUyQqkEvJS9Ei9nzflTPU
PzHRoXId6VlhBJqcFcprex9GiddTrrspC0H2AKc/vmgiR/XBMC8PGgrZrCzsoFgY
wOGkO1dpyVJkMGW9GgRg4cF2vwUf07qEvvGj+2bUqkKdJvtuDFkScVAevZUaDlk2
J8K5raBaAos7rke39ufRVqVF1asQFmRlBEQ1Ti22ELDn0jswkrFhn1QlE30E8CS8
rwn8hDBQDc5f63++VP/y
=lncM
-----END PGP SIGNATURE-----

--FbmEh7Ek6NM6xKh/--
