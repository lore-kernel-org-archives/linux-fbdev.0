From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fbdev timings
Date: Mon, 15 Sep 2003 09:43:54 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0309150943050.3191-100000@vervain.sonytel.be>
References: <20030915073029.GA13799@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yo1f-0007Rx-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 00:43:59 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yo1e-0007BB-Hf
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 00:43:58 -0700
In-Reply-To: <20030915073029.GA13799@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 15 Sep 2003, Otto Solares wrote:
> PS. i know 2 questions is a bad habit :) but here goes
> the other: how can i access fbdev features like
> acceleration from userspace? or i'm supposed to map
> the MMIO registers and do my own voodoo?

Clear the FB_ACCELF_TEXT bit in fb_var_screeninfo.accel_flags, mmap the MMIO
registers and do your own voodoo.

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
