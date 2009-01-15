From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [RFC 2.6.28 1/2] fbdev: add ability to set
 damage
Date: Thu, 15 Jan 2009 11:25:02 +0200
Message-ID: <1232011502.900.107.camel@tubuntu>
References: <12319779622958-git-send-email-jayakumar.lkml@gmail.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Tomi.Valkeinen@nokia.com>) id 1LNOTu-00008x-89
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Jan 2009 09:25:42 +0000
Received: from smtp.nokia.com ([192.100.122.230] helo=mgw-mx03.nokia.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LNOTp-0003sQ-JH
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Jan 2009 09:25:42 +0000
In-Reply-To: <12319779622958-git-send-email-jayakumar.lkml@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ext Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Magnus Damm <magnus.damm@gmail.com>, armbru@redhat.com, lethal@linux-sh.org, Geert Uytterhoeven <geert@linux-m68k.org>

Hi,

On Thu, 2009-01-15 at 08:06 +0800, ext Jaya Kumar wrote:
> Hi Geert, Krzysztof, Magnus, fbdev friends,
> 
> I would like to propose this idea about allowing userspace to provide damage
> information to drivers. This is just a first pass implementation. Please let
> me know your thoughts.

omapfb does actually something similar with a custom IOCTL,
OMAPFB_UPDATE_WINDOW. If other fbs need similar functionality, then this
sounds good to me.

However, those kallocs give me some shivers. I don't know how fast
kallocs are, so perhaps I'm worrying about nothing. But is such a
dynamic way to pass damaged area needed? omapfb is on the other end, you
can just give one rectangle with it.

I have often been wondering about this, is it better to update one
bigger area in one pass, or multiple smaller areas. I guess there's no
real answer to it, though =).


> Thanks,
> jaya

Tomi

> 
> This patch adds the ability for userspace applications to provide damage
> information to the underlying driver. This is useful in scenarios where the
> underlying driver can perform transfer optimizations based on knowing
> exactly which framebuffer areas that were updated. This functionality is
> exposed by using a simple x,y,w,h bounding box structure. Userspace is
> expected to perform its damage and then perform the ioctl. The underlying
> driver is free to use this information as it sees fit including ignoring it
> if it chooses to. An example use case will be provided in the case of
> broadsheetfb.c where the damage information is aggregated for deferred use.
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: armbru@redhat.com
> Cc: lethal@linux-sh.org
> Cc: adaplas@gmail.com
> Cc: linux-fbdev-devel@lists.sourceforge.net
> ---
>  drivers/video/fbmem.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fb.h    |   24 +++++++++++++++++++
>  2 files changed, 85 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index 756efeb..f95ec45 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -1006,6 +1006,60 @@ fb_blank(struct fb_info *info, int blank)
>   	return ret;
>  }
>  
> +static int fb_alloc_damage(struct fb_damage **damagep, int len)
> +{
> +	struct fb_damage *damage;
> +
> +	damage = kzalloc(sizeof(struct fb_damage), GFP_KERNEL);
> +	if (!damage)
> +		return -ENOMEM;
> +
> +	damage->len = len;
> +	damage->rects = kzalloc(sizeof(struct fb_damage_rect) * len,
> +				GFP_KERNEL);
> +	if (!damage->rects) {
> +		kfree(damage);
> +		return -ENOMEM;
> +	}
> +
> +	*damagep = damage;
> +	return 0;
> +}
> +
> +static void fb_free_damage(struct fb_damage *damage)
> +{
> +	if (damage)
> +		kfree(damage->rects);
> +	kfree(damage);
> +}
> +
> +static int fb_set_damage(struct fb_info *info, struct fb_damage_user *udamage)
> +{
> +	int ret = -EINVAL;
> +	int size = udamage->len;
> +	struct fb_damage *damage;
> +
> +	if (size > FB_DAMAGE_COUNT_MAX)
> +		goto fail;
> +
> +	ret = fb_alloc_damage(&damage, size);
> +	if (ret)
> +		goto fail;
> +
> +	if (copy_from_user(damage->rects, udamage->rects,
> +				sizeof(struct fb_damage_rect)*size)) {
> +		ret = -EFAULT;
> +		goto fail2;
> +	}
> +
> +	if (info->fbops->fb_set_damage)
> +		return info->fbops->fb_set_damage(info, damage);
> +fail2:
> +	fb_free_damage(damage);
> +fail:
> +	return ret;
> +}
> +
>  static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  			unsigned long arg)
>  {
> @@ -1015,6 +1069,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  	struct fb_con2fbmap con2fb;
>  	struct fb_cmap_user cmap;
>  	struct fb_event event;
> +	struct fb_damage_user udamage;
>  	void __user *argp = (void __user *)arg;
>  	long ret = 0;
>  
> @@ -1116,6 +1171,12 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  		info->flags &= ~FBINFO_MISC_USEREVENT;
>  		release_console_sem();
>  		break;;
> +	case FBIOPUT_DAMAGE:
> +		if (copy_from_user(&udamage, argp, sizeof(udamage)))
> +			ret = -EFAULT;
> +		else
> +			ret = fb_set_damage(info, &udamage);
> +		break;
>  	default:
>  		if (fb->fb_ioctl == NULL)
>  			ret = -ENOTTY;
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 1ee63df..8ee5f6d 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -37,7 +37,10 @@ struct dentry;
>  #define FBIOGET_HWCINFO         0x4616
>  #define FBIOPUT_MODEINFO        0x4617
>  #define FBIOGET_DISPINFO        0x4618
> +/* to allow userspace to provide screen damage information to drivers */
> +#define FBIOPUT_DAMAGE          0x4619
>  
> +#define FB_DAMAGE_COUNT_MAX	32	/* max number of damage rects */
>  
>  #define FB_TYPE_PACKED_PIXELS		0	/* Packed Pixels	*/
>  #define FB_TYPE_PLANES			1	/* Non interleaved planes */
> @@ -357,6 +360,24 @@ struct fb_image {
>  	struct fb_cmap cmap;	/* color map info */
>  };
>  
> +struct fb_damage_rect {
> +	__u16 x;
> +	__u16 y;
> +	__u16 w;
> +	__u16 h;
> +};
> +
> +struct fb_damage {
> +	struct list_head list;
> +	__u32 len;		/* Number of entries */
> +	struct fb_damage_rect *rects; /* array of damage rectangles */
> +};
> +
> +struct fb_damage_user {
> +	__u32 len;		/* Number of entries */
> +	struct fb_damage_rect __user *rects; /* array of damage rectangles */
> +};
> +
>  /*
>   * hardware cursor control
>   */
> @@ -672,6 +693,9 @@ struct fb_ops {
>  	/* get capability given var */
>  	void (*fb_get_caps)(struct fb_info *info, struct fb_blit_caps *caps,
>  			    struct fb_var_screeninfo *var);
> +
> +	/* provide damage information */
> +	int (*fb_set_damage)(struct fb_info *info, struct fb_damage *damage);
>  };
>  
>  #ifdef CONFIG_FB_TILEBLITTING


------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
