From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: cfb* routines and high mem
Date: Wed, 24 Sep 2003 12:21:15 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0309241212450.5610-100000@vervain.sonytel.be>
References: <20030922164845.42403.qmail@web14914.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A26mh-0000OF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 24 Sep 2003 03:22:11 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A26mg-00005T-Mk
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Sep 2003 03:22:10 -0700
In-Reply-To: <20030922164845.42403.qmail@web14914.mail.yahoo.com>
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

On Mon, 22 Sep 2003, Jon Smirl wrote:
> We have to do something about the ioremap of large framebuffers in 2.6. Right
> now in 2.6, if you have 1GB or more RAM most framebuffers will fail to load.
> With the price of memory falling 1GB will become common during the life of 2.6.
> 
> The failure is caused by the individual framebuffer drivers ioremap'ing the
> framebuffer into kernel address space. With 1GB memory or more it is almost a
> certainty that there is not enough kernel address space available.  Even my
> 16MB cards fail to load.

What's the maximum amount of address space you can remap? If even 16 MiB fails,
there's a serious problem, not only for fbdev, since you can easily imagine
some other hardware/application that needs to ioremap() 16 MiB.

To me it sounds more like a problem to be solved in the ia32-specific mm-code,
since it's caused by ia32-limitations and mm-decisions in the ia32-specific
code.

Yes, the 32-bit era is (finally) almost over!

BTW, as a comparison: on m68k we could easily have a 4Gi/4Gi kernel/user split
if we ever want that, since unlikely ia32, m68k has moves (move from/to address
space) to access the user address space from kernel space.

Gr{oetje,eeting}s,

						Geert (elitist m68k hacker ;-)

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
