From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] initialize fb_info->lock mutex in
	the framebuffer_alloc()
Date: Mon, 4 May 2009 08:47:03 +0200
Message-ID: <10f740e80905032347u6164d16tece3a9afac41e972@mail.gmail.com>
References: <20090503233008.bf4b9f57.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert.uytterhoeven@gmail.com>) id 1M0rxD-0003Dp-Lx
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 06:47:07 +0000
Received: from mail-ew0-f217.google.com ([209.85.219.217])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M0rxB-0007x9-2p for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 06:47:07 +0000
Received: by ewy17 with SMTP id 17so3677727ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 03 May 2009 23:47:03 -0700 (PDT)
In-Reply-To: <20090503233008.bf4b9f57.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sun, May 3, 2009 at 23:30, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
>
> The fb_info->lock mutex should be initialized inside
> the framebuffer_alloc() function. Otherwise, someone
> may call a fb layer function which indirectly uses uninitialized
> mutex.
> Move initialization of the mutex from the register_framebuffer()
> to framebuffer_alloc().
>
> This may cause problems for drivers which do not use
> the framebuffer_alloc() to allocate the fb_info structure.
> Convert the two last drivers to use the framebuffer_alloc().

> diff -urp linux-orig/drivers/video/igafb.c linux-2.6.30/drivers/video/igafb.c
> diff -urp linux-orig/drivers/video/offb.c linux-2.6.30/drivers/video/offb.c

Are these really the only 2 remaining ones? What about amifb and atafb
(from the top
of my head)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
