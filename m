From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: 2.6.7 still garbage upon start
Date: Fri, 18 Jun 2004 15:18:45 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406181516460.11779@waterleaf.sonytel.be>
References: <40D21E31.5070904@winischhofer.net> <200406180945.06335.adaplas@hotpop.com>
 <40D29FCD.7020602@winischhofer.net> <Pine.GSO.4.58.0406181013340.11779@waterleaf.sonytel.be>
 <40D2E96A.9000605@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbJGa-00025D-E8
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 06:18:48 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbJGZ-000771-Rg
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 06:18:48 -0700
In-Reply-To: <40D2E96A.9000605@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, Antonino Daplas <adaplas@pol.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 18 Jun 2004, John Zielinski wrote:
> Geert Uytterhoeven wrote:
> >Solution: before initializing and switching to a fbdev, save the contents of
> >the VGA text memory to the `shadow screen', so the fbdev can clear the frame
> >buffer memory, and fbcon can recover the current VC contents.
> >
> >However, it makes things more complex and adds a vgacon dependency to some
> >code, since you want it to behave differently if people don't compile in
> >vgacon.
> >
> That was the old solution.  I found the root cause of the problem.
> There is no code in the vt subsystem to prevent output going to a
> console driver after it has been deinitialized.  The vga console does
> save the VGA memory to it's shadow screen when it's deinitialized but
> any printk's after that screw things up as it starts to output again to
> the screen.  Now the shadow screen and the real screen doesn't match
> anymore.

Hence vgacon should be replaced by dummycon when it's deinitialized.

> >Final solution: VGA is obsolete ;-)
>
> I wish.  Hopefully the new EFI firmware on x86 platforms will initialize
> the video card into it's native graphics configuration so we can start
> dropping this excess VGA baggage we've been carrying for the last
> several years.  Of course there's always linuxbios as well.  :)  What's
> the story with VGA on other platforms?

(According to what I learned from the EFI talk at OLS last year) It's worse:
you have to talk to the EFI bytecode to draw text on UGA, no direct access to
the frame buffer ;-(

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
