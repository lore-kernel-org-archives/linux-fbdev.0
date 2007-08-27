From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 11/20] cirrusfb: checkpatch.pl
	cleanup
Date: Mon, 27 Aug 2007 09:15:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708270913170.19656@anakin>
References: <46D18888.10902@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPYop-0005Ol-QU for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Aug 2007 00:15:27 -0700
Received: from adicia.telenet-ops.be ([195.130.132.56])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IPYon-0000iv-Br
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Aug 2007 00:15:27 -0700
In-Reply-To: <46D18888.10902@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>

On Sun, 26 Aug 2007, Antonino A. Daplas wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch fixes over 850 errors and warnings pointed
> out by the checkpatch.pl script.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>
> ---
> 
>  drivers/video/cirrusfb.c | 1788 +++++++++++++++++++++++++---------------------
>  1 files changed, 983 insertions(+), 805 deletions(-)
> 
> diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
> index 8269d70..4c97c1d 100644
> --- a/drivers/video/cirrusfb.c
> +++ b/drivers/video/cirrusfb.c
> @@ -59,7 +59,7 @@ #include <asm/amigahw.h>
>  #endif
>  #ifdef CONFIG_PPC_PREP
>  #include <asm/machdep.h>
> -#define isPReP (machine_is(prep))
> +#define isPReP(machine_is(prep))
>  #else
>  #define isPReP 0
>  #endif

This chunk is bogus. Probably there should be a tab instead of a space to
silence checkpatch, or checkpatch should become smarter...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
