From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: cfb* routines and high mem
Date: Mon, 22 Sep 2003 09:23:50 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0309220923020.4957-100000@vervain.sonytel.be>
References: <20030922053954.47449.qmail@web14914.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1L35-000087-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 00:23:55 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A1L32-0001oC-OR
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 00:23:53 -0700
In-Reply-To: <20030922053954.47449.qmail@web14914.mail.yahoo.com>
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

On Sun, 21 Sep 2003, Jon Smirl wrote:
> After grepping around for a while it looks like the only user of the cfb*
> routines is the console code. There doesn't appear to be a way to get to these

And the logo code...

> from user space but I may have missed one.
>
> If this is true, then the cfb* code could be moved down into the console
> directory and be built into that driver. The frame buffer drivers would just
> return NULL for the function pointers if they don't implement an accelerated
> routine. Doing this would help isolate high mem access code into fbconsole.

What about unaccelerated frame buffer drivers for non-cfb hardware?

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
