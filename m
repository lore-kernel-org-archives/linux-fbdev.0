From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Move declaration of fb_class to
 <linux/fb.h>
Date: Thu, 24 May 2007 15:05:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705241500080.2223@pentafluge.infradead.org>
References: <Pine.LNX.4.62.0705241448450.6824@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HrDwm-0006Ec-77 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 24 May 2007 07:05:44 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HrDwl-00043T-P6
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 24 May 2007 07:05:44 -0700
In-Reply-To: <Pine.LNX.4.62.0705241448450.6824@pademelon.sonytel.be>
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Antonino Daplas <adaplas@gmail.com>


On Thu, 24 May 2007, Geert Uytterhoeven wrote:

> Move the forward declaration of fb_class from drivers/video/console/fbcon.h to
> <linux/fb.h>, together with the other forward declarations related to
> drivers/video/fbmem.c.
> 
> This kills the following sparse warning:
> | drivers/video/fbmem.c:1363:14: warning: symbol 'fb_class' was not declared. Should it be static?
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
>  drivers/video/console/fbcon.h |    1 -
>  include/linux/fb.h            |    1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/video/console/fbcon.h
> +++ b/drivers/video/console/fbcon.h
> @@ -176,7 +176,6 @@ extern void fbcon_set_tileops(struct vc_
>  #endif
>  extern void fbcon_set_bitops(struct fbcon_ops *ops);
>  extern int  soft_cursor(struct fb_info *info, struct fb_cursor *cursor);
> -extern struct class *fb_class;
>  
>  #define FBCON_ATTRIBUTE_UNDERLINE 1
>  #define FBCON_ATTRIBUTE_REVERSE   2
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -942,6 +942,7 @@ extern int fb_new_modelist(struct fb_inf
>  
>  extern struct fb_info *registered_fb[FB_MAX];
>  extern int num_registered_fb;
> +extern struct class *fb_class;
>  
>  static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch,
>  					   u8 *src, u32 s_pitch, u32 height)

I haven't looked at the sysfs handling until now. What a mess!!! Fbcon is 
using class_device instead of a regular device. It needs a cleanup. Last 
time I sent a sysfs patch it was ignored which didn't give me much 
motivation to resend it. I will resend it with improvements to fbcon if 
tony doesn't blow it off this time.


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
