From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Running frame buffer programs using a VGA
 console?
Date: Sat, 29 Nov 2003 21:48:26 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0311292147300.22995-100000@waterleaf.sonytel.be>
References: <3FC7D983.2020804@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AQC12-0002md-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 29 Nov 2003 12:48:32 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AQC11-00077V-Eu
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 Nov 2003 12:48:31 -0800
In-Reply-To: <3FC7D983.2020804@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 28 Nov 2003, John Zielinski wrote:
> Geert Uytterhoeven wrote:
> >... and fbtest should work. You cannot switch between graphcis and text mode,
> >though, since there's no console attached to your frame buffer device.
> >
> Huh?  Now I'm confused.  Do you mean that I can't go between text and 
> graphics using fbset or some other such utility or do you mean that 
> fbtest can't go between text and graphics modes?  Because it's the 
> latter that's happening by the looks of things.  It's not going into 
> graphics mode to do the test.

I meant that you can't use the KDSETMODE ioctl if there's no console attached
to the frame buffer device.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
