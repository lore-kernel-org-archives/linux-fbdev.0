From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [macro@ds2.pg.gda.pl: Re: PMAG-A support?]
Date: Tue, 12 Aug 2003 16:04:16 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0308121602420.20533-100000@vervain.sonytel.be>
References: <20030812135957.GC10792@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19mZmJ-00037r-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 12 Aug 2003 07:05:35 -0700
In-Reply-To: <20030812135957.GC10792@rembrandt.csv.ica.uni-stuttgart.de>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Karsten Merker <karsten@excalibur.cologne.de>, Martin Schulze <joey@infodrom.org>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 12 Aug 2003, Thiemo Seufer wrote:
> Michel D=E4nzer wrote:
> [snip]
> > > > > The PMAG-AA basically works for me, but it is not too useful wi=
thout
> > > > > working keyboard support. XFree86 preprocesses the xkbd input i=
n order
> > > > > to handle PC keyboard's key sequences, this breaks the LK keybo=
ard
> > > > > support.
> > > >=20
> > > > Ugh, so it sill uses RAW instead of MEDIUM_RAW?
> > >=20
> > > AFAIK all XFree86/Linux flavours want RAW.
> >=20
> > AFAIK the X server uses MEDIUM_RAW with Option "CustomKeycodes", but
> > that might require new keymaps.
>=20
> Ah, I haven't heard about this option yet. Well, the LK keymaps as

It was added in 1995 to support various m68k boxes :-)

> distributed with X seem to want RAW, I'll just try what happens with
> CustomKeycodes enabled.

So far everyone who tried MEDIUM_RAW mode on PC said it worked fine, and =
that
he wanted to make it the default mode, but apparently that never happened=
 ;-(

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org

In personal conversations with technical people, I call myself a hacker. =
But
when I'm talking to journalists I just say "programmer" or something like=
 that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
