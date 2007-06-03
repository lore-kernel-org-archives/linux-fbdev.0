From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 06/24] fm2fb: The pseudo_palette is
	only 16 elements long
Date: Sun, 3 Jun 2007 10:27:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0706031026540.9351@anakin>
References: <46613F1C.50606@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HulQx-0003Ui-AY for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Jun 2007 01:27:31 -0700
Received: from europa.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HulQu-0001u5-LO
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Jun 2007 01:27:31 -0700
In-Reply-To: <46613F1C.50606@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2 Jun 2007, Antonino A. Daplas wrote:
> The pseudo_palette is only 16 elements long.
> 
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> ---
> 
>  drivers/video/fm2fb.c |   16 +++++++++-------
>  1 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/video/fm2fb.c b/drivers/video/fm2fb.c
> index 70ff55b..6c91c61 100644
> --- a/drivers/video/fm2fb.c
> +++ b/drivers/video/fm2fb.c
> @@ -195,13 +195,15 @@ static int fm2fb_blank(int blank, struct
>  static int fm2fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
>                           u_int transp, struct fb_info *info)
>  {
> -	if (regno > info->cmap.len)
> -		return 1;
> -	red >>= 8;
> -	green >>= 8;
> -	blue >>= 8;
> +	if (regno < 16) {
> +		red >>= 8;
> +		green >>= 8;
> +		blue >>= 8;
> +
> +		((u32*)(info->pseudo_palette))[regno] = (red << 16) |
> +			(green << 8) | blue;
> +	}
>  
> -	((u32*)(info->pseudo_palette))[regno] = (red << 16) | (green << 8) | blue;
>  	return 0;
>  }
>  
> @@ -237,7 +239,7 @@ static int __devinit fm2fb_probe(struct 
>  	if (!zorro_request_device(z,"fm2fb"))
>  		return -ENXIO;
>  
> -	info = framebuffer_alloc(256 * sizeof(u32), &z->dev);
> +	info = framebuffer_alloc(16 * sizeof(u32), &z->dev);
>  	if (!info) {
>  		zorro_release_device(z);
>  		return -ENOMEM;
> 
> 
> 

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
