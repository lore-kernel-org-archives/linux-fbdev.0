From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: Re: Re: [macro@ds2.pg.gda.pl: Re: PMAG-A support?]
Date: Tue, 12 Aug 2003 15:59:57 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030812135957.GC10792@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030812063707.GC23104@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.4.21.0308121014200.20533-100000@vervain.sonytel.be> <20030812084009.GH23104@rembrandt.csv.ica.uni-stuttgart.de> <1060696300.26450.40.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19mZhT-00027K-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 12 Aug 2003 07:00:35 -0700
Content-Disposition: inline
In-Reply-To: <1060696300.26450.40.camel@thor.holligenstrasse29.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Karsten Merker <karsten@excalibur.cologne.de>, Martin Schulze <joey@infodrom.org>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Michel D=E4nzer wrote:
[snip]
> > > > The PMAG-AA basically works for me, but it is not too useful without
> > > > working keyboard support. XFree86 preprocesses the xkbd input in or=
der
> > > > to handle PC keyboard's key sequences, this breaks the LK keyboard
> > > > support.
> > >=20
> > > Ugh, so it sill uses RAW instead of MEDIUM_RAW?
> >=20
> > AFAIK all XFree86/Linux flavours want RAW.
>=20
> AFAIK the X server uses MEDIUM_RAW with Option "CustomKeycodes", but
> that might require new keymaps.

Ah, I haven't heard about this option yet. Well, the LK keymaps as
distributed with X seem to want RAW, I'll just try what happens with
CustomKeycodes enabled.


Thiemo


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
