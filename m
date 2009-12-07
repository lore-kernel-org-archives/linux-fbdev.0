From: Tony Lindgren <tony@atomide.com>
Date: Mon, 07 Dec 2009 21:32:50 +0000
Subject: Re: [PATCH 0/2] [RESEND] Amstrad Delta: add support for LCD
Message-Id: <20091207213250.GI24013@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <200911231857.55566.jkrzyszt@tis.icnet.pl>
 <200912051454.52966.jkrzyszt@tis.icnet.pl>
In-Reply-To: <200912051454.52966.jkrzyszt@tis.icnet.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091205 05:54]:
> Monday 23 November 2009 18:57:51 Janusz Krzysztofik napisa=C5=82(a):
> > Initialy submitted on 2009-11-16
> > (http://www.spinics.net/lists/linux-omap/msg20629.html).
> > Resendig due to fbdev mailing list address changed.
> >
> > The series consists of 2 patches:
> >
> >  [PATCH 1/2] omapfb: lcd_ams_delta: add support for contrast control
> >  [PATCH 2/2] OMAP: ams_delta_defconfig: enable LCD class device support
> >
> > It is intended for 2.6.33, if it's not too late.
>=20
> Hi,
>=20
> Now that Tony has changed the series status from New to Awaiting Upstream=
 in=20
> his patchwork queue[1][2], chances of getting it in throungh linux-omap t=
ree,=20
> like a few other omapfb related patches managed to do lately, seem fallin=
g=20
> down drastically to me if still not answered by anyone involved in omapfb=
=20
> development.
>=20
> Imre,
> Could you please take the patches, or give your ack for Tony to take them=
, or=20
> just point me on the right way to the get them integrated or NAKed, if no=
ne=20
> of the former is?
>=20
> Tomi,
> I am not sure if you are the right person for bothering here, but maybe y=
ou=20
> could give your comments that would help pushing it forward?

I'd prefer Tomi to merge all the drivers/video/omap code rather
than merge it via linux-omap tree. Ideally with an ack from
Imre where possible.

Tony

=20
> Thanks,
> Janusz
>=20
> [1] http://patchwork.kernel.org/patch/62248/
> [2] http://patchwork.kernel.org/patch/62249/
