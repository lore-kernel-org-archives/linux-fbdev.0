From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] interlaced packed pixels
Date: Fri, 4 Apr 2003 14:22:03 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0304041418000.1720-100000@vervain.sonytel.be>
References: <1049454984.2138.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 191QDd-0006EO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 04 Apr 2003 04:22:53 -0800
In-Reply-To: <1049454984.2138.2.camel@dhcp22.swansea.linux.org.uk>
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
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Op vrijdag 4 April 2003, schreef Alan Cox:
> On Gwe, 2003-04-04 at 12:17, Geert Uytterhoeven wrote:
     ^^^                                          ^^^^^
The Welsh setup isn't 100% finished yet ;-)

> > I'd like to introduce a new frame buffer type to accommodate packed p=
ixel frame
> > buffers that store the even and odd fields separately. This is typica=
lly used
> > in graphics hardware for TV output (e.g. set-top boxes).
>=20
> While we are at it can we also get an FB_TYPE_MJPEG ?

What's the exact format description for MJPEG? YUV 4:*:*?
Shouldn't that be a FB_VISUAL_MJPEG?

Groetjes,

						Geert

--
Geert Uytterhoeven -- Er is heel wat Linux na ia32 -- geert@linux-m68k.or=
g

Tijdens persoonlijke conversaties met technisch-geori=EBnteerde mensen no=
em ik
mezelf een hacker. Maar als ik met een journalist praat zeg ik gewoon
`programmeur' of iets in die aard.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
