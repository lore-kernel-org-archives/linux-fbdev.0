From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: mono, gray and index configs
Date: Thu, 11 Aug 2005 13:49:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0508111344070.1037@numbat.sonytel.be>
References: <9e47339105081020216574ac7e@mail.gmail.com>  <42FAE3F8.8080902@gmail.com>
  <Pine.LNX.4.62.0508111020520.1037@numbat.sonytel.be>
 <b00ca3bd05081104086fa9e639@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3BZC-0004Qh-PG
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Aug 2005 04:49:46 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E3BZC-0003gi-BA
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Aug 2005 04:49:46 -0700
In-Reply-To: <b00ca3bd05081104086fa9e639@mail.gmail.com>
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
To: Antonino Daplas <adaplas@gmail.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@gmail.com>

On Thu, 11 Aug 2005, Antonino Daplas wrote:
> On 8/11/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, 11 Aug 2005, Antonino A. Daplas wrote:
> > > that all the lengths = 1 and offsets = 0.  Currently, we have no way to
> > > specifically request for mono01, mono10, or 1-bit pseudocolor. Just check
> > > for fix->visual afterwards.
> > 
> > For mono01 or mono10, if the visual is pseudocolor, just set the colormap to
> > black/white or white/black.
> 
> I don't know. If I can change the colormap, I would  advertise this as
> 1-bit pseudocolor, not monochrome.  Otherwise, why differentiate
> between mono01 and mono10 if I can control what color is 0 and what
> color is 1.  I think the closest definition of monochrome is 1-bit
> static pseudocolor.  And we just have mono01 and mono10 to advertise
> how hardware treats 0/1 (background/foreground or reverse).

Yes, for advertisement, that's true (cfr. amifb with bpp = 1, which is
pseudocolor).

But when the app needs monochrome, it can ask for 1 bpp. If it returns a mono
visual, fine. If it returns a pseudocolor visual, set the colormap to
black/white.

> I have a few things that are still not clear to me.  If I understand
> it correctly, monochrome means 2 colors regardless of the bit depth. 

Monochrome means 2 colors, which are black and white (or white and black). If
the colors are different, it's (static) pseudocolor.

In fact monochrome is a special case of static pseudocolor.

> So it's possible, for example, to have 8-bit monochrome that has only
> two colors, ie 0x00 and 0xff.   If this was 8-bit static pseudocolor,

Yes, cfr. old HP9000/300 graphics hardware.

> then it has 256 different colors.

Yes.

> (Depending on how correct I am with the interpretation, there might be
> some bugs in fbdev on how it determines the color depth. No one is
> complaining yet though, so greater than 1-bit monochrome is probably
> rare if not nonexistent.)

There definitely are bugs w.r.t. this, especially in the 2.4 logo code ;-)

> > > For directcolor (indexed) vs truecolor, there is currently no way
> > > to specify which visual you want.  You also have to check for fix->visual
> > > afterwards.
> > >
> > > One of the reason I also want this sysfs attribute is because in at
> > > least 1 driver (i810fb), it's possible to choose between truecolor and
> > > directcolor but it uses a hack by checking for the var->nonstd flag.
> > 
> > So the driver should use directcolor instead of truecolor if the hardware
> > supports it. The application can always set a linear colormap if it needs
> > truecolor.
> 
> A few years ago, I discovered that there are several fbdev apps that
> make ssumptions which are not necessarily correct.  For example, if
> bits_per_pixel > 8, the app assumes the format is truecolor. So the
> app produces wrong colors if fbdev is in directcolor mode (because it
> failed to set the cmap).

That's true. Many apps handle only a very limited subset of all capabilities,
and fail miserably if the assumptions they make are not valid.

> So, it is useful to have the capability to choose between truecolor
> and directcolor when dealing with those apps without rebooting or
> recompiling.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
