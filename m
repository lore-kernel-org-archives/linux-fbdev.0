From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fbdev: colormap fixes
Date: Thu, 28 Jul 2005 17:56:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0507281755350.24391@numbat.sonytel.be>
References: <200507280031.j6S0V3L3016861@hera.kernel.org> 
 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be>
 <9e473391050728074573e40038@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyAky-00076V-Do
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 08:57:12 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DyAkx-0006IA-0q
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 08:57:12 -0700
In-Reply-To: <9e473391050728074573e40038@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 28 Jul 2005, Jon Smirl wrote:
> Can you review this fix for the issues below? I fixed things to
> automatically adjust the number of entries to whatever fits in
> PAGE_SIZE.

Looks OK, but...

> @@ -317,18 +317,18 @@ static ssize_t show_cmap(struct class_de
>  	   !fb_info->cmap.green)
>  		return -EINVAL;
>  
> -	if (PAGE_SIZE < 4096)
> +	if (fb_info->cmap.len > PAGE_SIZE / 16)
>  		return -EINVAL;

... perhaps you want to just return the first PAGE_SIZE/16 entries, instead of
failing?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
