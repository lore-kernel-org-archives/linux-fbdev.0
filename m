From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 15 Sep 2014 08:52:58 +0000
Subject: Re: [PATCH 03/16] video: Add DT binding documentation for VGA connector
Message-Id: <5416A8EA.1070402@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="H4VhjwoeT4PGpv3718xbDV0DSVD73oOGA"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1409157673-4154-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1409157673-4154-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1409157673-4154-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org

--H4VhjwoeT4PGpv3718xbDV0DSVD73oOGA
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 27/08/14 19:41, Laurent Pinchart wrote:
> The VGA connector is described by a single input port and an optional
> DDC bus.
>=20
> Cc: devicetree@vger.kernel.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.=
com>
> ---
>  .../devicetree/bindings/video/vga-connector.txt    | 28 ++++++++++++++=
++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/vga-connect=
or.txt
>=20
> diff --git a/Documentation/devicetree/bindings/video/vga-connector.txt =
b/Documentation/devicetree/bindings/video/vga-connector.txt
> new file mode 100644
> index 0000000..9a45ec1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/vga-connector.txt
> @@ -0,0 +1,28 @@
> +VGA Connector
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Required properties:
> +- compatible: "vga-connector"
> +
> +Optional properties:
> +- label: a symbolic name for the connector
> +- ddc-i2c-bus: phandle to the I2C bus that is connected to VGA DDC
> +
> +Required nodes:
> +- Video port for VGA input
> +
> +Example
> +-------
> +
> +vga0: connector@0 {
> +	compatible =3D "vga-connector";
> +	label =3D "vga";
> +
> +	ddc-i2c-bus =3D <&i2c3>;
> +
> +	port {
> +		vga_connector_in: endpoint {
> +			remote-endpoint =3D <&adv7123_out>;
> +		};
> +	};
> +};
>=20

Looks good to me.

 Tomi



--H4VhjwoeT4PGpv3718xbDV0DSVD73oOGA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUFqjwAAoJEPo9qoy8lh71/VcP/jo7YNg0B1MyfKaUNQCiftsm
pFQUlLkiC6tticqYOlYnlcNcLSctyYfV4gmUD/9wOpXAXJynP0SZaqRyDg0ckCTj
Syhrd+ILrCUmLwtCNY9lKisWtAatu6MgTI/sm5SBzQS2TIYAfEslXnePVVy/bsA+
bYXpTbuaJhaBkERQ3tWtJjjUtr3IJVPSOcviZhU6rcHWVgxUCwuardJ8vlGmreq8
5+tyKprnDu47Aq6D7zkmZpDcyybLCfpEei0s7sBdvEX1UcCUkIQ6D3RWks18zIjs
YCzGdDQHES4zCYWgeuM91hX7WD4xEQrt53326WjbdOWjgeIPcDC6KyiD27QqTrtX
mRE2yvb8iHtGA94igm7z1nFK5vVKvC8eWXSfHPs0XYguhEQsoauNDwLt2u2xsasP
gLWqx54uYDV2oLu7iNJii4e6HA5gxyIcUBzUhG0GODqTUiwZJV5xO2zbHo640EM5
y47+Nv0sIKIjH7Fs6Ht7YFSdxHLPq9fcixMJYGB0BDcPgFz66xHx2IFWRLgrtAxj
f+kS5Ws0xzp9xp/3dBjPPQwvmXhgHSwqaWj3aUDDUQwFkytJXUJKfU4QIT97yoVv
yDvJ1w/4h8wuidW3Sjr8q/XiwNunJ+dQwjJw6O7ksMhIfqCq9jxoecnsXUyMwlWX
b6uVcjvRSAoIwZklP/B/
=/fjI
-----END PGP SIGNATURE-----

--H4VhjwoeT4PGpv3718xbDV0DSVD73oOGA--
