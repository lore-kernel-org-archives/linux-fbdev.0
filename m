From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 25 Nov 2014 12:32:26 +0000
Subject: Re: [PATCH v3 2/2] dt-bindings: simplefb-sunxi: Add sunxi simplefb extensions
Message-Id: <547476DA.2030004@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7wfsofw2kCWsX875qbUk5smI4hNj8sm2E"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416309051-26784-1-git-send-email-hdegoede@redhat.com>
 <1416309051-26784-3-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1416309051-26784-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org

--7wfsofw2kCWsX875qbUk5smI4hNj8sm2E
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 18/11/14 13:10, Hans de Goede wrote:
> If pre-filled framebuffer nodes are used, the firmware may need extra
> properties to find the right node. This documents the properties to use=

> for this on sunxi platforms.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Grant Likely <grant.likely@linaro.org>
> ---
>  .../bindings/video/simple-framebuffer-sunxi.txt    | 33 ++++++++++++++=
++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/simple-fram=
ebuffer-sunxi.txt
>=20
> diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer=
-sunxi.txt b/Documentation/devicetree/bindings/video/simple-framebuffer-s=
unxi.txt
> new file mode 100644
> index 0000000..c46ba64
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.=
txt
> @@ -0,0 +1,33 @@
> +Sunxi specific Simple Framebuffer bindings
> +
> +This binding documents sunxi specific extensions to the simple-framebu=
ffer
> +bindings. The sunxi simplefb u-boot code relies on the devicetree cont=
aining
> +pre-populated simplefb nodes.
> +
> +These extensions are intended so that u-boot can select the right node=
 based
> +on which pipeline is being used. As such they are solely intended for
> +firmware / bootloader use, and the OS should ignore them.
> +
> +Required properties:
> +- compatible: "allwinner,simple-framebuffer"
> +- allwinner,pipeline, one of:

Sorry my ignorance, but what's sunxi and what's allwinner? Both names
are mixed here.

 Tomi



--7wfsofw2kCWsX875qbUk5smI4hNj8sm2E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUdHbaAAoJEPo9qoy8lh715j8P/0W1HSVZqHUjGSixiFLePszX
qQZ/O1VIe9sUbNAuUYSa2B6/OjDV/no/gcIDljDIQ1E2ze/m9AFeTOfTBbHkNnvm
EmL6YezuRARJ016EF3J+MwGea+HSMGUPU65ioQL+sqg4gDY1G4NCSCUL8VrLtkG8
FQuBcJZkFjHph0MJCkJt1YgcmMen9tSlcjMVuawqXY0hr7kUFAaFZzVeEWIKDnTr
EGoMxQGVziNCXNUU4eATsIQWBK3fUnaBaSDYXbiuloYH4qIvTkj2HnUxHjlveCAK
tmolbLJf5pcvWkTQMkFVfJxAAldZPTERkZY3lgDuDZBLqv4+WDnkDYXUtnOQ3Jbc
v5nHp0rjVqUlML9E4TwG2PdQaVh09uI0oNK4t1pqNcesZIuBh4s/nL844mGKkoqI
6Ql62VfwVWDEe6S7SdFkRSC+aD3WC5NZwcT//0NliSK/fPo+npQfApzGXISey2Oc
dlMWHKt9UX3X+NnUGOohhS8WXyli/3AkCZc6UJ+QqF5zwL3J99auVjSnvcjnwxLi
ijnaKaKZtQDGVO1kTyqItMliTve5I11XfpIpubV0RAbTxjFmhZYxWq4O4zorIQPS
07+fPXD+Gbzd+j8udKqMDj4Gp6vLBqNSU1vpnWoHakSbkiaHxAO08B+dTBH7dTBg
B5CPOLEOPRGafTOQ2qIZ
=jqxW
-----END PGP SIGNATURE-----

--7wfsofw2kCWsX875qbUk5smI4hNj8sm2E--
