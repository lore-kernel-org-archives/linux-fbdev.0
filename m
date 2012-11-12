From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 12 Nov 2012 14:14:02 +0000
Subject: Re: [PATCHv6 0/2] Add support for the OLED in the CFA10036
Message-Id: <50A1042A.2090405@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351674774-2891-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1351674774-2891-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Ping?

Le 31/10/2012 10:12, Maxime Ripard a =E9crit :
> Hi everyone,
>=20
> This patchset adds support for the solomon SSD1307 OLED controller present
> in the CFA-10036 board.
>=20
> It first adds the framebuffer driver for this controller, and then the
> needed bits to enable it in the cfa10036 dts.
>=20
> Considering that the driver has been around since almost three months now=
, and
> I have not received any comments on the framebuffer part, I'd very much l=
ike it
> to be included in 3.8 if possible.
>=20
> Thanks,
> Maxime
>=20
> Changes from v5:
>   * Fixed bogus reset code
>=20
> Maxime Ripard (2):
>   video: Add support for the Solomon SSD1307 OLED Controller
>   ARM: dts: mxs: add oled support for the cfa-10036
>=20
>  .../devicetree/bindings/video/ssd1307fb.txt        |   24 ++
>  arch/arm/boot/dts/imx28-cfa10036.dts               |   19 +
>  drivers/video/Kconfig                              |   13 +
>  drivers/video/Makefile                             |    1 +
>  drivers/video/ssd1307fb.c                          |  407 ++++++++++++++=
++++++
>  5 files changed, 464 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/ssd1307fb.txt
>  create mode 100644 drivers/video/ssd1307fb.c
>=20


--=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
