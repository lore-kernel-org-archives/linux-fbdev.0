From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Running frame buffer programs using a VGA
 console?
Date: Fri, 28 Nov 2003 09:34:46 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0311280933080.21469-100000@waterleaf.sonytel.be>
References: <3FC6ADC4.4090002@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1APe5U-0002Ra-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Nov 2003 00:34:52 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1APe5T-00048x-EF
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Nov 2003 00:34:51 -0800
In-Reply-To: <3FC6ADC4.4090002@undead.cc>
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

On Thu, 27 Nov 2003, John Zielinski wrote:
> Geert Uytterhoeven wrote:
> >On Thu, 27 Nov 2003, John Zielinski wrote:
> >>Silly question.  Is it actually possible to run a fb program like fbtest 
> >>if your console is the VGA console?  I tried it but the fb driver 
> >>doesn't seem to switch modes.
> >
> >No, you cannot. You need an active frame buffer device driver.
> 
> I have the low level radeon fb driver in the kernel and it initializes 
> like usual, but I turned off the frame buffer console option.   I was 

So you have an active frame buffer device (you can check this using `cat
/proc/fb')....

> wondering if the frame buffer programs can run like this.  If not then I 
> won't have to worry about that kind of configuration when working on fb 
> programs.

... and fbtest should work. You cannot switch between graphcis and text mode,
though, since there's no console attached to your frame buffer device.

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
