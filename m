From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [BK PATCHS] fbdev updates.
Date: Tue, 22 Oct 2002 19:13:57 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0210221912430.8374-100000@vervain.sonytel.be>
References: <20021018223708.C15827@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1842ci-0004LH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 22 Oct 2002 10:15:20 -0700
In-Reply-To: <20021018223708.C15827@flint.arm.linux.org.uk>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 18 Oct 2002, Russell King wrote:
> On Fri, Oct 18, 2002 at 02:24:48PM -0700, James Simmons wrote:
> > Your right. That is a bug from the old fbgen code. Since few driver used
> > the old fbgen code it never appeared. I suggest we remove can_soft_blank
> > and just test to see if the function pointer exist for fb_blank. If it
> > doesn't then we can resort to other tricks in suggested in the ther email.
> 
> Ok.  What about the case where you're running in true colour / static
> pseudo colour, and can't blank the palette, but do have a fb_blank
> method to handle the direct colour / pseudo colour case?

That's what the return value of the fb_blank() function is for: to indicate
whether it handled the blanking or not. If not, the upper layer has to take
care of it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4699841;7576301;v?http://www.sun.com/javavote
