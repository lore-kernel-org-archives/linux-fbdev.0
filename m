From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 08 May 2013 06:56:08 +0000
Subject: Re: [PATCHv2 0/2] Add support for the Solomon SSD1306 OLED Controller
Message-Id: <5189F708.1040508@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2UHIBKMBRQCJNGKIEDBFT"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366624555-5616-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1366624555-5616-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org

------enig2UHIBKMBRQCJNGKIEDBFT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 22/04/13 12:55, Maxime Ripard wrote:
> Hi,
>=20
> This patchset adds the needed bits to the ssd1307fb driver to support t=
he
> very similar Solomon SSD1306 controller.
>=20
> Since the SSD1307 has been replaced by the SSD1306 in the latest CFA-10=
036
> production samples, we also need to change the device tree accordingly.=

>=20
> Thanks,
> Maxime
>=20
> Changes from v1:
>   - Fix style errors
>=20
> Maxime Ripard (2):
>   video: ssd1307fb: Add support for SSD1306 OLED controller
>   ARM: dts: cfa10036: Change the OLED display to SSD1306
>=20
>  .../devicetree/bindings/video/ssd1307fb.txt        |   10 +-
>  arch/arm/boot/dts/imx28-cfa10036.dts               |   14 +-
>  arch/arm/boot/dts/imx28-cfa10049.dts               |    4 +-
>  drivers/video/ssd1307fb.c                          |  273 ++++++++++++=
+++-----
>  4 files changed, 216 insertions(+), 85 deletions(-)

I've taken the first patch, "video: ssd1307fb: Add support for SSD1306
OLED controller" into fbdev 3.11 branch. The dts changes should
preferably go through arch tree.

 Tomi




------enig2UHIBKMBRQCJNGKIEDBFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRifcIAAoJEPo9qoy8lh716KkP/0OaGEMb4e95siV1Lug0YyEi
dPMaKnEL3kIpCpvmMRGjAf/crJZKpE3QQUt5Rb2UgCKEBw4tFVF6Z2TJAJozqG5b
UlGfAlfLVC3Kled49jcVZwUvc2AETioNBozrtY+3tHAqdJA2nZvCjr/Xh0aJs3SS
zBybogYnaat8MCyHAw0taydCKHEV7tjcnXjQrCbihisJQdPb1X6YLK0R8WOpNfnI
vYyMErDzoJIwqcE+NbNW2P6ikLk02Ah9B0WROfjPcJtD04Sw7lVmwxqKPA0ISzZ5
6bUfnrx4JUIjJQNaml2CswmZAXIeoMznxcpIVkelUQhLI/ItI6OBatws//pl7Rl4
/8Og6DgFl4YPg/COVM+8YdbkHDPenoHYjMHxZqz0lRuByy5lQcUcdP0rnj4rtjvb
q2d0obHqRuRy63by69LLtYNZPZcQ+bvEoOmyATJ/mVBz9qKK0edAkD+jIt+iLumV
Pyl49XIouJ70ExPdSjddmK8o7JQvqOMItFOPGTC/ED4egqYI1cemEWU4YoUnEau1
N7gT+3soF4w7rIvI1cJmJMifsHRahA7corsu0eAGsSBaWL+UZLCiBTrtJFzHdoqc
dLfCOUDfZ636PGCK9qoUI1hwpYh7KiN0JVk2p4HV61tOweVIW8/KhMRkXS/3WV+I
eUyMjW9rz5jYlzKQQFYO
=SL0d
-----END PGP SIGNATURE-----

------enig2UHIBKMBRQCJNGKIEDBFT--
