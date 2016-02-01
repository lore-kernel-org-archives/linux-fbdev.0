From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Mon, 01 Feb 2016 10:07:49 +0000
Subject: Re: [PATCH v2 0/3] fbdev: omap2: panel-dpi: support reset-gpios and vcc regulator
Message-Id: <20160201100749.GT13664@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1450610002-10531-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1450610002-10531-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hello Tomi,

On Sun, Dec 20, 2015 at 12:13:19PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> these patches are what is remaining from my previous series sent
> starting with
> Message-Id: 1449753107-11410-1-git-send-email-uwe@kleine-koenig.org .
>=20
> I split out the changes to
> Documentation/devicetree/bindings/video/panel-dpi.txt in a (single)
> separate patch. Also I changed the behaviour of the reset gpio to never
> assert it because there are too many different needs.
>=20
> Have fun
> Uwe
>=20
> Uwe Kleine-K=F6nig (3):
>   devicetree/bindings: add reset-gpios and vcc-supply for panel-dpi
>   fbdev: omap2: panel-dpi: make (limited) use of a reset gpio
>   fbdev: omap2: panel-dpi: implement support for a vcc regulator

you didn't comment these patches, do you have them still on your radar?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
