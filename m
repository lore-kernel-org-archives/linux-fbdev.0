From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [PATCH 2.5.68] Epson 1355 Rewrite for 2.5
Date: Wed, 7 May 2003 10:54:13 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0305071050400.29816-100000@vervain.sonytel.be>
References: <006801c31473$47bd51d0$7900000a@bergamot>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19DKhx-0004KH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 07 May 2003 01:55:25 -0700
In-Reply-To: <006801c31473$47bd51d0$7900000a@bergamot>
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
To: Christopher Hoover <ch@murgatroid.com>
Cc: 'James Simmons' <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 7 May 2003, Christopher Hoover wrote:
> The cfb generic code works wonderfully well on the EP7212 CPU/EPSON 1355
> because the processor can do the math in 32-bits just fine, it just
> needs to issue 16-bit reads and writes to the framebuffer memory.  Since
> you had that nice FB{READ|WRITE} abstraction in there, it was easy to
> make a small tweak to be able to use my own FB{READ|WRITE} routines that
> break each (aligned) FB{READ|WRITE} into two 16-bit reads/writes.
> That's all that has to happen.  I inlined the speical fb{read|write}
> routines and got good code with decent performance.
> 
> What I'm hearing is that you woud prefer that I include my own routines
> over the pre-processor hackery.  Be warned that it is mostly going to be
> a cut-n-paste job -- even if I wrote the routines totally from scratch I
> would handle 32-bits of pixel(s) at a time.

Personally, I think it wouldn't harm to be make the cfb* routines generic, so
you can set some defines and #include them to tailer them to your card's
needs.

Even on some 64-bit platforms, you may not want to use 64-bit accesses, e.g.
because your graphic's card bus is still only 32-bit.

I can even think of some more sofistication: on older Amigas, the graphics RAM
is 16-bit wide and quite slow, while the CPU is 32-bit. So it may make sense to
always use 32-bit accesses (like is currently done), except for the first and
last unaligned accesses if they are less or equal than 16-bit.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
