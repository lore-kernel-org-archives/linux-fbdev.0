From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: radeonfb on pegasos powerpc motherboard and
 X endianess problem
Date: Fri, 6 Jun 2003 08:00:53 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0306060759020.864-100000@vervain.sonytel.be>
References: <1054813350.701.38.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19OAId-0002r7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 05 Jun 2003 23:02:03 -0700
In-Reply-To: <1054813350.701.38.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 5 Jun 2003, Benjamin Herrenschmidt wrote:
> On Thu, 2003-06-05 at 10:19, Sven Luther wrote:
> > > >   3) When running X without the UseFBDev option, the colors are good,
> > > >   but i get garbage when i return to the console. Not exactly garbage,
> > > >   at first it is ok, but when i enter a line or somehow pan the screen,
> > > >   the corruption start. Doing a vt switch and back redraws a clean
> > > >   screen.
> > > 
> > > Known problem. This is actually a bit nasty. X doesn't fully restore the
> > > engine state (and it's in fact quite difficult to know in which state
> > > it should restore it) and there's no hook in the fbdev layer for
> > > restoring things like that when switching from KD_GRAPHICS back to
> > > KD_TEXT. I'm thinking about adding such a hook in 2.5. Usually, a VT
> > > switch will trigger a restore of the engine state, at least it will
> > > with my version of the driver.
> > 
> > Mmm, so is this a problem in the X server or in the fbdev driver ? I
> > understand that you will fix this in the fbdev since you have a more
> > difficult time doing it in the X driver, but this does mean that the X
> > driver will do a partial save/restore, and that fbdev will then do a
> > full save/restore ? Seems overkill to me. We can either fix it in the
> > fbdev driver (which will know which registers the fbdev needs to backup)
> > or in the X driver (which will know about which register x needs to
> > backup).
> 
> Not exactly. I'm not sure X can restore the engine state exactly
> (maybe it can, but imho, it's a bit overkill). I tend to think that
> the fbdev shall do it as it's very much easier. On one side, X would
> have to backup & restore an insane amount of registers, on the other
> side, fbdev can just re-init the engine to the state it wants in a few
> dozen lines of code.

Yes, re-initting the engine is the correct way. IIRC, atyfb does this when text
mode acceleration is re-enabled in fb_var_screeninfo.accel_flags. I.e. when X
leaves graphics mode and switches VT.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
