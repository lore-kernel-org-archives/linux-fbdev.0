From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 21 Sep 2012 14:04:01 +0000
Subject: Re: [PATCH 1/2] video: Add support for the Solomon SSD1307 OLED Controller
Message-Id: <505C73D1.7030800@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348158800-23039-1-git-send-email-maxime.ripard@free-electrons.com>
 <1348158800-23039-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1348158800-23039-2-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Florian,


Le 20/09/2012 18:33, Maxime Ripard a =E9crit :
> This patch adds support for the Solomon SSD1307 OLED
> controller found on the Crystalfontz CFA10036 board.
>=20
> This controller can drive a display with a resolution up
> to 128x39 and can operate over I2C or SPI.
>=20
> The current driver has only been tested on the CFA-10036,
> that is using this controller over I2C to driver a 96x16
> OLED screen.
>=20
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Brian Lilly <brian@crystalfontz.com>

Would you consider merging this patch or review it?
It has been around for quite some time now and has not received any
comments for at least the 2 last versions, so I guess there is not much
left holding it back (unless, of course, if you have some comments to
address), and I really would like to have it in 3.7.

Thanks,

Maxime



--=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
