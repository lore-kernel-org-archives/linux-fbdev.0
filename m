From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [PATCH 6/8] fbcon/fbdev: Remove fbc
Date: Wed, 3 Nov 2004 13:05:52 +0100
Message-ID: <20041103120552.GB30071@vana.vc.cvut.cz>
References: <82235870BEB@vcnet.vc.cvut.cz> <200411030512.16925.adaplas@hotpop.com> <20041103001725.GB24964@vana.vc.cvut.cz> <200411031115.50205.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPJtq-000653-N5
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Nov 2004 04:06:02 -0800
Received: from vana.vc.cvut.cz ([147.32.240.58] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CPJtp-0002s8-Mu
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Nov 2004 04:06:02 -0800
Content-Disposition: inline
In-Reply-To: <200411031115.50205.adaplas@hotpop.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, akpm@osdl.org

On Wed, Nov 03, 2004 at 11:15:48AM +0800, Antonino A. Daplas wrote:
> On Wednesday 03 November 2004 08:17, Petr Vandrovec wrote:
> > On Wed, Nov 03, 2004 at 05:12:15AM +0800, Antonino A. Daplas wrote:
> > > On Tuesday 02 November 2004 19:46, Petr Vandrovec wrote:
> > > > On  2 Nov 04 at 19:46, Antonino A. Daplas wrote:
> > Because hardware driver is supposed to drive hardware.   Plus I do not
> > agree with paradigm that open should do something special unless each open
> > provides completely separate view (like opening /dev/ptmx).  Harddisk also
> > does not spin up when you open /dev/hda and does not stop when you close
> > it. Petr Vandrovec
> 
> Is this patch acceptable?

Looks good.  Thanks for fixing secondary head ;-)
								Petr
 
> Tony
> 
>   Set 'initialized' field in xxxfb_set_par and check this flag after
>   register_framebuffer.  A nonzero value will force the driver
>   to initialize the hardware.
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> ---
> 
>  matroxfb_base.c  |   20 +++++++++-----------
>  matroxfb_base.h  |    1 +
>  matroxfb_crtc2.c |    4 +++-
>  matroxfb_crtc2.h |    1 +
>  4 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff -Nru a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
> --- a/drivers/video/matrox/matroxfb_base.c	2004-11-01 08:32:54 +08:00
> +++ b/drivers/video/matrox/matroxfb_base.c	2004-11-03 11:09:11 +08:00
> @@ -835,6 +835,7 @@
>  			matrox_cfbX_init(PMINFO2);
>  		}
>  	}
> +	ACCESS_FBINFO(initialized) = 1;
>  	return 0;
>  }
>  
> @@ -1876,20 +1877,17 @@
>  	}
>  	printk("fb%d: %s frame buffer device\n",
>  	       ACCESS_FBINFO(fbcon.node), ACCESS_FBINFO(fbcon.fix.id));
> -	/*
> -	 * Tony: If this driver is to be mapped to the console, then
> -	 *       fbcon will automatically do a set_par for us.  The code below
> -	 *       may not be needed. 
> -	 */
>  
>  	/* there is no console on this fb... but we have to initialize hardware
>  	 * until someone tells me what is proper thing to do */
> -	printk(KERN_INFO "fb%d: initializing hardware\n",
> -	       ACCESS_FBINFO(fbcon.node));
> -	/* We have to use FB_ACTIVATE_FORCE, as we had to put vesafb_defined to the fbcon.var
> -	 * already before, so register_framebuffer works correctly. */
> -	vesafb_defined.activate |= FB_ACTIVATE_FORCE;
> -	fb_set_var(&ACCESS_FBINFO(fbcon), &vesafb_defined);
> +	if (!ACCESS_FBINFO(initialized)) {
> +		printk(KERN_INFO "fb%d: initializing hardware\n",
> +		       ACCESS_FBINFO(fbcon.node));
> +		/* We have to use FB_ACTIVATE_FORCE, as we had to put vesafb_defined to the fbcon.var
> +		 * already before, so register_framebuffer works correctly. */
> +		vesafb_defined.activate |= FB_ACTIVATE_FORCE;
> +		fb_set_var(&ACCESS_FBINFO(fbcon), &vesafb_defined);
> +	}
>  
>  	return 0;
>  failVideoIO:;
> diff -Nru a/drivers/video/matrox/matroxfb_base.h b/drivers/video/matrox/matroxfb_base.h
> --- a/drivers/video/matrox/matroxfb_base.h	2004-10-19 20:23:59 +08:00
> +++ b/drivers/video/matrox/matroxfb_base.h	2004-11-03 11:09:11 +08:00
> @@ -372,6 +372,7 @@
>  	struct list_head	next_fb;
>  
>  	int			dead;
> +	int                     initialized;
>  	unsigned int		usecount;
>  
>  	unsigned int		userusecount;
> diff -Nru a/drivers/video/matrox/matroxfb_crtc2.c b/drivers/video/matrox/matroxfb_crtc2.c
> --- a/drivers/video/matrox/matroxfb_crtc2.c	2004-11-01 08:32:54 +08:00
> +++ b/drivers/video/matrox/matroxfb_crtc2.c	2004-11-03 11:09:11 +08:00
> @@ -387,6 +387,7 @@
>  		up_read(&ACCESS_FBINFO(altout).lock);
>  		matroxfb_dh_cfbX_init(m2info);
>  	}
> +	m2info->initialized = 1;
>  	return 0;
>  #undef m2info
>  }
> @@ -633,7 +634,8 @@
>  	if (register_framebuffer(&m2info->fbcon)) {
>  		return -ENXIO;
>  	}
> -	fb_set_var(&m2info->fbcon, &matroxfb_dh_defined);
> +	if (!m2info->initialized)
> +		fb_set_var(&m2info->fbcon, &matroxfb_dh_defined);
>  	down_write(&ACCESS_FBINFO(crtc2.lock));
>  	oldcrtc2 = ACCESS_FBINFO(crtc2.info);
>  	ACCESS_FBINFO(crtc2.info) = m2info;
> diff -Nru a/drivers/video/matrox/matroxfb_crtc2.h b/drivers/video/matrox/matroxfb_crtc2.h
> --- a/drivers/video/matrox/matroxfb_crtc2.h	2004-10-19 20:24:01 +08:00
> +++ b/drivers/video/matrox/matroxfb_crtc2.h	2004-11-03 11:09:11 +08:00
> @@ -9,6 +9,7 @@
>  struct matroxfb_dh_fb_info {
>  	struct fb_info		fbcon;
>  	int			fbcon_registered;
> +	int                     initialized;
>  
>  	struct matrox_fb_info*	primary_dev;
>  
> 
> 
> 


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
