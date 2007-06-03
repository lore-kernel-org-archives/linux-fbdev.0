From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 09/24] offb: The pseudo_palette is
 only 16 elements long
Date: Sun, 3 Jun 2007 10:28:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0706031028400.9351@anakin>
References: <46613F48.40906@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HulSO-0003bP-VQ for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Jun 2007 01:29:01 -0700
Received: from europa.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HulSO-0004g4-JC
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Jun 2007 01:29:00 -0700
In-Reply-To: <46613F48.40906@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>

On Sat, 2 Jun 2007, Antonino A. Daplas wrote:
> The pseudo_palette is only 16 elements long.
> 
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> ---
> 
>  drivers/video/offb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/offb.c b/drivers/video/offb.c
> index 885b428..452433d 100644
> --- a/drivers/video/offb.c
> +++ b/drivers/video/offb.c
> @@ -271,7 +271,7 @@ static void __init offb_init_fb(const ch
>  		return;
>  	}
>  
> -	size = sizeof(struct fb_info) + sizeof(u32) * 17;
> +	size = sizeof(struct fb_info) + sizeof(u32) * 16;
>  
>  	info = kmalloc(size, GFP_ATOMIC);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
