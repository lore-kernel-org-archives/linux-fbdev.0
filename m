From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 07 Mar 2016 18:35:19 +0000
Subject: Re: [PATCH 2/5] Subject: goldfish: Enable ACPI-based enumeration for goldfish framebuffer
Message-Id: <56DDC9E7.8040609@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vSMT206xPPkaL4fX8cL0jkuFWTt00A8ww"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160226183940.2731.42083.stgit@localhost.localdomain>
 <20160226184157.2731.30846.stgit@localhost.localdomain>
In-Reply-To: <20160226184157.2731.30846.stgit@localhost.localdomain>
To: Alan <alan@linux.intel.com>, linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, linux-acpi@vger.kernel.org

--vSMT206xPPkaL4fX8cL0jkuFWTt00A8ww
Content-Type: multipart/mixed; boundary="MbIi88Mmom9KJvFWw6jHglhkpPxRipBD5"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Alan <alan@linux.intel.com>, linux-fbdev@vger.kernel.org,
 plagnioj@jcrosoft.com, linux-acpi@vger.kernel.org
Message-ID: <56DDC9E7.8040609@ti.com>
Subject: Re: [PATCH 2/5] Subject: goldfish: Enable ACPI-based enumeration for
 goldfish framebuffer
References: <20160226183940.2731.42083.stgit@localhost.localdomain>
 <20160226184157.2731.30846.stgit@localhost.localdomain>
In-Reply-To: <20160226184157.2731.30846.stgit@localhost.localdomain>

--MbIi88Mmom9KJvFWw6jHglhkpPxRipBD5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26/02/16 20:41, Alan wrote:
> From: Yu Ning <yu.ning@intel.com>
>=20
> Enable ACPI bindings for the Goldfish framebuffer device.
>=20
> Signed-off-by: Yu Ning <yu.ning@intel.com>
> Signed-off-by: Jin Qian <jinqian@android.com>
> Signed-off-by: Alan <alan@linux.intel.com>
> ---
>  drivers/video/fbdev/goldfishfb.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/gol=
dfishfb.c
> index f0e651b..58b33e4 100644
> --- a/drivers/video/fbdev/goldfishfb.c
> +++ b/drivers/video/fbdev/goldfishfb.c
> @@ -26,6 +26,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/ioport.h>
>  #include <linux/platform_device.h>
> +#include <linux/acpi.h>
> =20
>  enum {
>  	FB_GET_WIDTH        =3D 0x00,
> @@ -310,6 +311,12 @@ static const struct of_device_id goldfish_fb_of_ma=
tch[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, goldfish_fb_of_match);
> =20
> +static const struct acpi_device_id goldfish_fb_acpi_match[] =3D {
> +	{ "GFSH0004", 0 },

I'm not familiar with ACPI, so I need to ask... Where does the ID come
from? Is it safe to use that one, and there's no chance for a clash with
some other device in the future?

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, goldfish_fb_acpi_match);
> +
>  static struct platform_driver goldfish_fb_driver =3D {
>  	.probe		=3D goldfish_fb_probe,
>  	.remove		=3D goldfish_fb_remove,
> @@ -317,6 +324,7 @@ static struct platform_driver goldfish_fb_driver =3D=
 {
>  		.name =3D "goldfish_fb",
>  		.owner =3D THIS_MODULE,
>  		.of_match_table =3D goldfish_fb_of_match,
> +		.acpi_match_table =3D ACPI_PTR(goldfish_fb_acpi_match),

So does the emulator sometimes use devicetree and sometimes ACPI to
match the device?

 Tomi


--MbIi88Mmom9KJvFWw6jHglhkpPxRipBD5--

--vSMT206xPPkaL4fX8cL0jkuFWTt00A8ww
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW3cnnAAoJEPo9qoy8lh71eX8P/2OWpugb8kzOwu67MoyNfTvX
1sgqMi4bd1Eh3oYOOiupBa/9IKGJ6kzy5pPJ5Bz3hDn1EKCW330focGjxGRYo1Tm
Q1+pqfGGovaWiE9OyKRhoSXVY/GxWhZlzK94YnIk9Nn55GcUG6LgO7dgwjEplXuE
nFH/jzJ3Oi/fyNd42VXlQnPTBXPXb1Id494fvcr7zPf3XDz6BhdurIjMX+EEm/Gp
ajCU8u/dr+6JECc2N1MmFJUpxNkvfIWOwr7sAe0xIx/wafut7g1lCaL8fQGmyUhP
NlB06TswLrM0cLBW74E3P+E3E/Gu6zX4ozHHYAw1VvU/qQ/VEfogDlpUuVaLbxnF
RgGkXCeWe09ZEuRa/Ip0AeCg2ODzVMkNqmfZvJ7htLTkK1JPz5QYjLX7p9HPwU1p
W7rK4c+omeJ/b+xixI7L8sitoVw2XpJpopaAwHjYIGAkjEG7PlFKMCnEC7Jbwlk6
+cvuG/J6bcoaHh9hxfNwM11A/IfmQvFgM3e8PIbtaaOV+DBQsbYHOKOeLU4Dor7x
iqUlfVsd6xk9URW8bzniyHpRROmOFf6OWcFZXCyK5ImPKu++ckoHlmCDl6UkzANN
40XqIP3CiBiFBeQDSh98ADv+9sqX8CrDf6sscBFrLLvxydwtssl5DNAiEsV8/o+o
aDYqeV2ZbsfazVzHuj+a
=jBpQ
-----END PGP SIGNATURE-----

--vSMT206xPPkaL4fX8cL0jkuFWTt00A8ww--
