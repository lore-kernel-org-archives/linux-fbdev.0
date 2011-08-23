From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Tue, 23 Aug 2011 09:25:33 +0000
Subject: Re: [RFC PATCH v2] Resurrect Intel740 driver: i740fb
Message-Id: <1314091533.21860.289.camel@thor.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201108212242.12717.linux@rainbow-software.org>
	 <20110821233648.6d120143@lxorguk.ukuu.org.uk>
	 <201108231103.30591.linux@rainbow-software.org>
In-Reply-To: <201108231103.30591.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

On Die, 2011-08-23 at 11:03 +0200, Ondrej Zary wrote:=20
> On Monday 22 August 2011, Alan Cox wrote:
> > > - 24bpp modes still don't work in fbtest but it looks like fbtest bug!
> > >
> > > Is there any better way to test fb drivers than fbtest?
> >
> > X11 fbdev driver ?
>=20
> Thanks, completely forgot about that. It works fine even in 24bpp.

Beware that Xorg defaults to 32 bpp for depth 24; did you verify in
Xorg.0.log that it was really using 24 bpp?


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
