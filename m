From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: still ..Confused about atyfb and M1
Date: Wed, 4 Feb 2004 16:35:52 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0402041634100.22483@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0401302147390.22830-100000@phoenix.infradead.org>
 <401FF39B.7090406@bitworks.com> <Pine.GSO.4.58.0402041003560.20790@waterleaf.sonytel.be>
 <40210CEA.5080102@bitworks.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoPBc-0001oW-Rc
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Feb 2004 07:43:32 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AoPBa-0001Ah-6g
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Feb 2004 07:43:30 -0800
In-Reply-To: <40210CEA.5080102@bitworks.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: Richard Smith <rsmith@bitworks.com>
Cc: James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Kern <alex.kern@gmx.de>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 4 Feb 2004, Richard Smith wrote:
> > On Tue, 3 Feb 2004, Richard Smith wrote:
> >
> >>new untested hardware booting a half-ass videobios running an unknown
> >>driver.  Gee... wonder why it dosen't work? *grin*
>
>  >Geert Uytterhoeven wrote:
>
> > Indeed, atyfb needs BIOS (or OpenFirmware) initialization. It has
> >
> How much?  Are things like the ammount and type of RAM autodetected or
> just read from registers that the BIOS is supposed to set?

Atyfb reads them from the registers.

> > My Vaio Z600TEK (Z505 in US/JP) has a M1. It works with atyfb in rece=
nt 2.4,
> > but it took Dani=EBl Mantione quite a bit of work to make it work on =
this
> > particular machine...
>
> What device ID is your M1?

1002:4c4d

> Any idea what he had to do?  Most of DM's code seems to deal with

IIRC, programming an extra shadow register.

> makeing it work properly with a LCD.  Right now I just have a CRT hooke=
d
> up.  LCD will comes later.
>
> > Let's say atyfb in 2.4 works on most M1s these days.
>
> So which one should I work with? 2.4 or 2.6 with fbdiff?

I think 2.4 is the safest. I don't know whether James' tree already conta=
ins
all Mobility support from 2.4.

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
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
