From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: fbmem: is bootup logo broken for monochrome
	LCD ?
Date: Tue, 14 Nov 2006 10:44:43 +0100
Message-ID: <cda58cb80611140144q79718798p40f2762955c1d91@mail.gmail.com>
References: <45535C08.5020607@innova-card.com>
	<Pine.LNX.4.64.0611122138030.9472@pentafluge.infradead.org>
	<cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com>
	<Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org>
	<cda58cb80611131027h5052bf80va06003c23b844fe@mail.gmail.com>
	<Pine.LNX.4.64.0611131850410.2366@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GjuqY-0001We-A3 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 01:44:50 -0800
Received: from nf-out-0910.google.com ([64.233.182.186])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GjuqW-0004t9-Mh
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 01:44:50 -0800
Received: by nf-out-0910.google.com with SMTP id c31so380897nfb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 14 Nov 2006 01:44:44 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0611131850410.2366@pentafluge.infradead.org>
Content-Disposition: inline
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
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 11/13/06, James Simmons <jsimmons@infradead.org> wrote:
>
> Let me know if it works now.
>

OK I can apply it now.

>
> diff -urN -X linus-2.6/Documentation/dontdiff linus-2.6/drivers/video/cfbimgblt.c fbdev-2.6/drivers/video/cfbimgblt.c
> --- linus-2.6/drivers/video/cfbimgblt.c 2006-11-07 05:38:36.000000000 -0500
> +++ fbdev-2.6/drivers/video/cfbimgblt.c 2006-11-12 10:29:49.000000000 -0500

[snip]

> +static inline void slow_imageblit(const struct fb_image *image,
> +                                 struct fb_info *p, u8 __iomem *dst,
> +                                 u32 start_index, u32 pitch_index)

I still have my problem there: for example if image data are
0, 0, 0x54, 0, ...

then slow_imageblit() will write into the frame buffer, the following bytes:
0, 0, 0x2a, 0, ...

instead of the initial ones:
0, 0, 0x54, 0, ...

Bits of each bytes are reversed. I already tried to explain my
problem, please look at

http://marc.theaimsgroup.com/?l=linux-kernel&m=116315548626875&w=2

>
> diff -urN -X linus-2.6/Documentation/dontdiff linus-2.6/drivers/video/fbmem.c fbdev-2.6/drivers/video/fbmem.c

[snip]

> @@ -480,14 +436,13 @@
>  int fb_show_logo(struct fb_info *info, int rotate)
>  {
>         u32 *palette = NULL, *saved_pseudo_palette = NULL;
> -       unsigned char *logo_new = NULL, *logo_rotate = NULL;
>         struct fb_image image;
>
>         /* Return if the frame buffer is not mapped or suspended */
>         if (fb_logo.logo == NULL || info->state != FBINFO_STATE_RUNNING)
>                 return 0;
>
> -       image.depth = 8;
> +       image.depth = fb_logo.depth;
>         image.data = fb_logo.logo->data;
>
>         if (fb_logo.needs_cmapreset)
> @@ -508,17 +463,13 @@
>                 info->pseudo_palette = palette;
>         }
>
> -       if (fb_logo.depth <= 4) {
> -               logo_new = kmalloc(fb_logo.logo->width * fb_logo.logo->height,
> -                                  GFP_KERNEL);
> -               if (logo_new == NULL) {
> -                       kfree(palette);
> -                       if (saved_pseudo_palette)
> -                               info->pseudo_palette = saved_pseudo_palette;
> -                       return 0;
> +       if (fb_logo.depth == 1) {
> +               if (info->fix.visual == FB_VISUAL_MONO01) {
> +                       u32 fg = image.fg_color;
> +
> +                       image.fg_color = image.bg_color;
> +                       image.bg_color = fg;

I had to fix this part to make the bootup logo worked. image.fg_color
is not uninitialised at this point. I had to change this part as
follow:

	if (fb_logo.depth == 1) {
		image.fg_color = (info->fix.visual == FB_VISUAL_MONO01) ? 1: 0;
		image.bg_color = !image.fg_color;
	}

Otherwise this part of your patch (the one which fix the logo display)
seems ok for my naive look. It would be nice if this part could be
sent in a single patch to Andrew. I already tried to fix it but your
patch looks better.

Thanks
-- 
               Franck

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
