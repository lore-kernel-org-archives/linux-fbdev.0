From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Framebuffer fbtest issues
Date: Thu, 27 Nov 2003 11:04:34 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0311271103000.19234-100000@waterleaf.sonytel.be>
References: <3FC571FE.7000900@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1APJ0p-0007yh-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Nov 2003 02:04:39 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1APJ0o-0006Vc-Ut
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Nov 2003 02:04:39 -0800
In-Reply-To: <3FC571FE.7000900@undead.cc>
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

On Wed, 26 Nov 2003, John Zielinski wrote:
> Hetz Ben Hamo wrote:
> >On some machines, running the fbtest might take a bit of pause and then the demos
> >will run, so you might want to launch the fbtest with: ./fbtest -d -v
> 
> I got that pause when running it as well.  Seems that the memcpy from 
> video memory is what causes this.  Do you (or anyone else on the list) 
> know why reading video memory takes so long?  I have a Radeon 9200 on an 
> ASUS A7V133 motherboard.

How much memory does the Radeon 9200 have? Probably at least 64 MiB. Usually
reading from video memory across PCI/AGP is slow, that's why usually it's
faster for fbcon to scroll by redrawing all characters instead of copying video
data.

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
