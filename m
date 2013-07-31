From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 31 Jul 2013 10:19:01 +0000
Subject: Re: [PATCH v2 18/24] video: da8xx-fb: minimal dt support
Message-Id: <51F8E495.8020101@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MINmOhcjI60Wb8QGePiK9hUJ1lORDITMN"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375208791-15781-19-git-send-email-detheridge@ti.com>
In-Reply-To: <1375208791-15781-19-git-send-email-detheridge@ti.com>
To: linux-fbdev@vger.kernel.org

--MINmOhcjI60Wb8QGePiK9hUJ1lORDITMN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/07/13 21:26, Darren Etheridge wrote:
> From: Afzal Mohammed <afzal@ti.com>
>=20
> Driver is provided a means to have the probe triggered by DT.
>=20
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Darren Etheridge <detheridge@ti.com>
> ---
>  .../devicetree/bindings/video/fb-da8xx.txt         |   16 ++++++++++++=
++++
>  drivers/video/da8xx-fb.c                           |    7 +++++++
>  2 files changed, 23 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/video/fb-da8xx.tx=
t
>=20
> diff --git a/Documentation/devicetree/bindings/video/fb-da8xx.txt b/Doc=
umentation/devicetree/bindings/video/fb-da8xx.txt
> new file mode 100644
> index 0000000..581e014
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/fb-da8xx.txt
> @@ -0,0 +1,16 @@
> +TI LCD Controller on DA830/DA850/AM335x SoC's
> +
> +Required properties:
> +- compatible:
> +	DA830 - "ti,da830-lcdc"
> +	AM335x SoC's - "ti,am3352-lcdc", "ti,da830-lcdc"

I'm not totally sure about this, but how I understand the compatible
property, the above reads as: "this device is ti,am3352-lcdc and it's
fully compatible with ti,da830-lcdc". I.e. if the kernel has a driver
for da830-lcdc, it should work with AM335x also (without any of the new
features in AM335x, obviously). Which I believe is not the case, as the
point of this series is to add the AM335x support.

Or should the current da830-lcdc work with AM335x also, but it just
didn't because there were bugs in da830-lcdc?

 Tomi



--MINmOhcjI60Wb8QGePiK9hUJ1lORDITMN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR+OSVAAoJEPo9qoy8lh71TroP/3JCEe3QH8zD9Wh8RaYiF0gz
DgUIS7KyyQC52+97EuzdeCbjkEDNHxYGahJVzygPsqTLgBHBkaqbsUTn/0HDQUKn
OcaWOB7z3eZzQhlLuT6iLBXpV3CaJQkUIgMdixMD956G+eSkUdu52lyTIIVhDtQF
4Ae4FyplkJuYUOEXJ7Z8+buOHHj972f/7ZT9+dUgNrrpwv/yo0XkPfNp+9WjB+pb
0CE92fRu4zNT2FvYiXLiEPIJjAeE6yuRV77W77Vx0w4yy3zVaJaDTrcwWv49PCpx
TwZgfDPwwOEyNMspnWfm8lhD8ea2FWynKQtwZokGz6HDNSBD24cYrrfRmTlnOFcI
lmHzlXbIgGcruaPaW491F0myop1BiW7z+VueIududIdMYNXc1b0e1UOZ3ZTigsit
1WuubPqLpLY75t9sI0FbO72HOIGDxn+EQBYJmf9niS5VlTXTXFJF5N1tcOkG4GqN
kpgbyepDGa2Krt2SQGHuYgbBabOLOPBNR0XsYG25dgh3FU49AX6Oi6Ufhzw0fhe+
GdSR3yH5+05VTauu34WNiNnggUq2AqKbx/9Gn0oInWGF17jrEZbck61m2IGEI4b9
Vqvynlx3SYHB7KPctkXPDtKxI5AFnAzFCtwJJXXqJDdQvYXYM0KZWtdC96XYp+gD
HkLUZU/mmKoD8wpRzx3C
=k/qw
-----END PGP SIGNATURE-----

--MINmOhcjI60Wb8QGePiK9hUJ1lORDITMN--
