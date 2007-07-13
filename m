From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [patch 2/4] fbdev: Add
	fb_append_extra_logo()
Date: Fri, 13 Jul 2007 08:15:57 +0800
Message-ID: <1184285757.4566.11.camel@daplas>
References: <20070710122702.765654000@pademelon.sonytel.be>
	<20070710123540.678435000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I98pM-0007YR-AW for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 17:16:08 -0700
Received: from rv-out-0910.google.com ([209.85.198.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I98pK-0003KU-VB
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 17:16:08 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3225rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jul 2007 17:16:06 -0700 (PDT)
In-Reply-To: <20070710123540.678435000@pademelon.sonytel.be>
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geoff Levand <geoffrey.levand@am.sony.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, cbe-oss-dev@ozlabs.org

On Tue, 2007-07-10 at 14:27 +0200, Geert Uytterhoeven wrote:
> plain text document attachment (spe-logo)
> Add fb_append_extra_logo(), to append extra lines of logos below the standard
> Linux logo.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> Acked-By: James Simmons <jsimmons@infradead.org>
> ---
>  drivers/video/fbmem.c      |   50 +++++++++++++++++++++++++++++++++++++++++----
>  include/linux/linux_logo.h |    8 +++++++
>  2 files changed, 54 insertions(+), 4 deletions(-)
> 
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -318,6 +318,13 @@ static struct logo_data {
>  	const struct linux_logo *logo;
>  } fb_logo __read_mostly;
>  
> +#define FB_LOGO_EX_NUM_MAX 10
> +static struct logo_data_extra {
> +	const struct linux_logo *logo;
> +	unsigned int n;
> +} fb_logo_ex[FB_LOGO_EX_NUM_MAX];
> +static unsigned int fb_logo_ex_num;
> +
>  static void fb_rotate_logo_ud(const u8 *in, u8 *out, u32 width, u32 height)
>  {
>  	u32 size = width * height, i;
> @@ -411,10 +418,22 @@ static void fb_do_show_logo(struct fb_in
>  	}
>  }
>  
> +#ifdef CONFIG_FB

The #ifdef is redundant.

> +void fb_append_extra_logo(const struct linux_logo *logo, unsigned int n)
> +{
> +	if (!n || fb_logo_ex_num == FB_LOGO_EX_NUM_MAX)
> +		return;
> +
> +	fb_logo_ex[fb_logo_ex_num].logo = logo;
> +	fb_logo_ex[fb_logo_ex_num].n = n;
> +	fb_logo_ex_num++;
> +}
> +#endif
> +
>  int fb_prepare_logo(struct fb_info *info, int rotate)
>  {
>  	int depth = fb_get_color_depth(&info->var, &info->fix);
> -	int yres;
> +	unsigned int yres, height, i;
>  
>  	memset(&fb_logo, 0, sizeof(struct logo_data));
>  
> @@ -474,7 +493,21 @@ int fb_prepare_logo(struct fb_info *info
>  		fb_logo.depth = 4;
>  	else
>  		fb_logo.depth = 1;		
> -	return fb_logo.logo->height;
> +
> +	/* FIXME: logo_ex supports only truecolor fb. */
> +	if (info->fix.visual != FB_VISUAL_TRUECOLOR)
> +		fb_logo_ex_num = 0;
> +
> +	height = fb_logo.logo->height;
> +	for (i = 0; i < fb_logo_ex_num; i++) {
> +		height += fb_logo_ex[i].logo->height;
> +		if (height > yres) {
> +			height -= fb_logo_ex[i].logo->height;
> +			fb_logo_ex_num = i;
> +			break;
> +		}
> +	}
> +	return height;
>  }
>  
>  static int fb_show_logo_line(struct fb_info *info, int rotate,
> @@ -547,8 +580,17 @@ static int fb_show_logo_line(struct fb_i
>  
>  int fb_show_logo(struct fb_info *info, int rotate)
>  {
> -	return fb_show_logo_line(info, rotate, fb_logo.logo, 0,
> -				 num_online_cpus());
> +	int y, i;
> +
> +	y = fb_show_logo_line(info, rotate, fb_logo.logo, 0,
> +			      num_online_cpus());
> +
> +	for (i = 0; i < fb_logo_ex_num; i++) {
> +		y += fb_show_logo_line(info, rotate,
> +				       fb_logo_ex[i].logo, y, fb_logo_ex[i].n);
> +	}
> +
> +	return y;
>  }
>  #else
>  int fb_prepare_logo(struct fb_info *info, int rotate) { return 0; }
> --- a/include/linux/linux_logo.h
> +++ b/include/linux/linux_logo.h
> @@ -33,5 +33,13 @@ struct linux_logo {
>  };
>  
>  extern const struct linux_logo *fb_find_logo(int depth);
> +#if defined(CONFIG_LOGO) && defined(CONFIG_FB)

The CONFIG_LOGO is also probably redundant, but that's arguable.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
