From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Large framebuffers and HIGHMEM systems
Date: Wed, 10 Sep 2003 10:40:12 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0309101039170.1390-100000@vervain.sonytel.be>
References: <20030909212824.95374.qmail@web14916.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19x0Wr-0000kF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 01:40:45 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19x0Wq-0000tn-L2
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Sep 2003 01:40:44 -0700
In-Reply-To: <20030909212824.95374.qmail@web14916.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 9 Sep 2003, Jon Smirl wrote:
> Fbdev needs to come up with a general solution for mapping large framebuffers
> on systems with over 1GB memory. For example my system does not have 64MB of
> free address space below 1GB, this causes my framebuffer drivers to fail when
> loading. With RAM prices at $200 for 1GB memory 1GB systems will be common
> during the 2.6 timeframe.

> I would also suggest modifying all current fb drivers to print a message about
> adding reserve=xxxxx at boot if their ioremap() of the fb fails. This will at
> least point people at an immediate work around.

Or modify ioremap() to print the message? This problem is not only limited to
frame buffer devices, but to every driver that needs to ioremap() large
regions, right?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
