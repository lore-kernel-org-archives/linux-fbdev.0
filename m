From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: kernel: matrox fb - missing files,
 doesn't compile
Date: Sun, 22 Dec 2002 09:42:53 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0212220941450.11631-100000@vervain.sonytel.be>
References: <1039912121.1008.59.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Q1iO-0000sr-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 22 Dec 2002 00:44:04 -0800
In-Reply-To: <1039912121.1008.59.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, Ariel <aslinux@dsgml.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 15 Dec 2002, Antonino Daplas wrote:
> On Fri, 2002-12-13 at 15:09, Petr Vandrovec wrote:
> > Current interface just supports only cfb, and only very bad for my needs.
> > And because of matroxfb supports also other modes (such as native text
> > mode, or loading font into accelerator), bye-bye. For now I recommend you 
> > either to not upgrade, or use vesafb. Besides that accel_putcs() does not 
> > call fb_sync when using font width which is not multiple of 8, and that 
> Can you explain why an fb_sync is needed for every character?
> 
> > with fonts greater than 16*16 pixels (I believe that such fonts are still 
> > supported...) it will corrupt memory...
> 
> I agree.  To be more specific, buffer overruns will occur if (xres *
> fontheight/8 > 8192).  The pixmap needs to be dynamically allocated and
> resized somewhere in the fbcon layer (ideally in accel_setup(), but this
> was removed).  For those concerned about this problem, you can try this
> patch as a temporary measure until fbcon is fixed. It should not cause
> to much slowdown:

What about making putcs() check for overflows? I.e. large putcs() will just be
split in multiple image blit calls.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
