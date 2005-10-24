From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: color map vs. pseudo-palette vs. RAMDAC
 registers
Date: Mon, 24 Oct 2005 13:19:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0510241316190.16503@numbat.sonytel.be>
References: <200510240948.50185.rolf.offermanns@gmx.net>
 <Pine.LNX.4.62.0510240954290.16285@numbat.sonytel.be> <200510241301.17275.rolf@offermanns.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EU0MU-0004kX-L7
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 24 Oct 2005 04:19:30 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EU0MR-00012z-Od
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 24 Oct 2005 04:19:30 -0700
In-Reply-To: <200510241301.17275.rolf@offermanns.de>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rolf Offermanns <rolf@offermanns.de>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 24 Oct 2005, Rolf Offermanns wrote:
> On Monday 24 October 2005 09:57, Geert Uytterhoeven wrote:
> > > -------------------------------------------------------------------------
> > >---- Truecolor:
> > >      *    does not use RAMDAC (usually has 3 of them).
> > >      *    var->{color}.offset contains start of bitfield
> > >      *    var->{color}.length contains length of bitfield
> > >      *    cmap is programmed to (red << red.offset) |
> > > 				(green << green.offset) |
> > >     				(blue << blue.offset) |
> > > 				(transp << transp.offset)
> > >      *    RAMDAC does not exist
> > > -------------------------------------------------------------------------
> > >---- Now I am lost:
> > > -> does not use RAMDAC.
> > > I understand this. It states the same in my chip reference. But what
> > > means "usually has 3 of them" in this context?
> >
> > Red, green, and blue.
> OK. But this is for H/W with DirectColor support where each color has its own 
> CLUT, right?

No, `RAM' part of the RAMDAC is used for both pseudocolor and directcolor.

> Thanks for these explanations Gerd. Shall I provide a patch for the skeletonfb 
> driver comments?

Please do so, thx!

> The one thing, I still do not understand is:
> What are color maps used for in the different visuals? In pseudo mode they are 
> not used at all. In TrueColor mode there should be no need to map anything?
> I checked the documentation again, but there must be something I have 
> overread.

Colormaps are definitely used in pseudocolor mode, since they specify how to
map the index in the pixel value to the actual color.

In truecolor mode colormaps are indeed not used.

In directcolor mode colormaps specify how the red, green, and blue (and alpha)
indices in the pixel values are mapped to actual values for the color
components.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
