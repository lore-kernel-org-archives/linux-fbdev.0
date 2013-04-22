From: Marek Vasut <marex@denx.de>
Date: Mon, 22 Apr 2013 14:30:48 +0000
Subject: Re: [PATCH RESEND] video: mxsfb: Fix colors display on lower color depth
Message-Id: <201304221630.48644.marex@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366618310-7068-1-git-send-email-maxime.ripard@free-electrons.com>
 <201304221116.18080.marex@denx.de> <51750EB9.3020301@free-electrons.com>
In-Reply-To: <51750EB9.3020301@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Dear Maxime Ripard,

> Hi Marek,
>=20
> Le 22/04/2013 11:16, Marek Vasut a =E9crit :
> > Dear Maxime Ripard,
> >=20
> >> The current code always registers as a 32 bits display, and uses the
> >> hardware to drop the MSB of each color to abjust to the interface width
> >> used by the panel.
> >>=20
> >> This results on 18 bits (and probably 16 bits display as well) in colo=
rs
> >> being displayed poorly, because the MSB are obviously the most importa=
nt
> >> bits for each color definition.
> >>=20
> >> The default controller behaviour when using an interface width smaller
> >> than the color depth is to drop the LSBs of each color, which makes mo=
re
> >> sense because you lose the least important part of the color definitio=
n.
> >>=20
> >> So, to fix the colors display, just get back to the default controller
> >> behaviour.
> >>=20
> >> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >=20
> > Did you receive my latest email? Check M28EVK (imx28-m28evk.dts), it us=
es
> > 18bit LCD and works without this patch I think.
>=20
> Thanks for the pointer. You mentionned in your other mail that it was
> wired on 24bits but that the screen is actually 18 bits. I went to
> search for the schematics to look at the wirings to see what could
> differ, but I couldn't find any for the M28EVK. Are they publicly
> available?

Yes, [1] page 6 .

[1] http://www.denx-cs.de/doku/sites/default/files/M28EVK_V20_0.pdf

Best regards,
Marek Vasut
