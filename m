From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: still ..Confused about atyfb and M1
Date: Wed, 4 Feb 2004 10:06:48 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0402041003560.20790@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0401302147390.22830-100000@phoenix.infradead.org>
 <401FF39B.7090406@bitworks.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoJ00-0005cI-Lh
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Feb 2004 01:07:08 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AoJ00-0003qO-52
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Feb 2004 01:07:08 -0800
In-Reply-To: <401FF39B.7090406@bitworks.com>
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

On Tue, 3 Feb 2004, Richard Smith wrote:
> My hope was that the chip was up far enough that the framebuffer driver
> code would bring it to life.  But that didn't happen so thats why I
> wan't to know what the driver is supposed to be able to do.  So I have
> new untested hardware booting a half-ass videobios running an unknown
> driver.  Gee... wonder why it dosen't work? *grin*

Indeed, atyfb needs BIOS (or OpenFirmware) initialization. It has
initialization code for RAGE XL, though.

> And no.  I don't have a known good system as you can't buy video cards
> with an M1 on them. :( (At least I haven't found one yet)  Anybody know
> what laptop brands/models have an M1 in them?  That would be handy.
>
> Obviously if the M1 is already supported by atyfb then ATI authorized
> that info to be released already and I don't have to worry quite so muc=
h
> about submitting patches to that code.

My Vaio Z600TEK (Z505 in US/JP) has a M1. It works with atyfb in recent 2=
.4,
but it took Dani=EBl Mantione quite a bit of work to make it work on this
particular machine...

Let's say atyfb in 2.4 works on most M1s these days.

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
