From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] add palette register check
Date: Wed, 18 Nov 2009 23:20:00 +0100
Message-ID: <10f740e80911181420k4e405e69s992cf0da682a086f@mail.gmail.com>
References: <20091024171823.27896031.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert.uytterhoeven@gmail.com>) id 1NAssp-0007cV-Ba
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Nov 2009 22:20:15 +0000
Received: from mail-fx0-f222.google.com ([209.85.220.222])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NAssh-0002JH-Hp for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Nov 2009 22:20:15 +0000
Received: by fxm22 with SMTP id 22so1942974fxm.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 18 Nov 2009 14:20:01 -0800 (PST)
In-Reply-To: <20091024171823.27896031.krzysztof.h1@poczta.fm>
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

On Sat, Oct 24, 2009 at 16:18, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
>
> Add check if palette register number is in correct range
> for few drivers which miss it. The regno value comes
> indirectly from user space.
>
> Two drivers has converted check from BUG_ON() macro
> to just return an error (non-zero value).
>
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
>
> ---
>
> diff --git a/drivers/video/atafb.c b/drivers/video/atafb.c
> index 8cd279b..2682938 100644
> --- a/drivers/video/atafb.c
> +++ b/drivers/video/atafb.c

Thanks, I'll take the atafb part through the m68k tree.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
