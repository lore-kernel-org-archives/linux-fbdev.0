From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Framebuffer Port guide for 2.4->2.6?
Date: Thu, 4 Nov 2004 09:46:45 +0800
Message-ID: <200411040946.45502.adaplas@hotpop.com>
References: <41892D53.1060007@cablespeed.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPWlM-00040A-Jw
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Nov 2004 17:50:08 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CPWlL-0007sc-C0
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Nov 2004 17:50:08 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id E8CC011A931C
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  4 Nov 2004 01:49:44 +0000 (UTC)
In-Reply-To: <41892D53.1060007@cablespeed.com>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Kelly Price <tygris@cablespeed.com>

On Thursday 04 November 2004 03:11, Kelly Price wrote:
> Is there a port guide for framebuffer drivers going from 2.4 to 2.6?
> I'm trying to port the CT65548 Frambuffer driver over to 2.6.
>
> http://members.elysium.pl/ytm/html/linux.html is where the 2.4 version
> is at.
>
>

Can you just add the chip support to the chipsfb driver which currently
supports CT 65550, or are the chipsets too different that they deserve
different drivers?

Anyway there are a scarcity of documentation about the framebuffer system,
especially in 2.6.  So here's a start:

In general, you need to allocate:

struct fb_info - structure that acts as a glue between the console, userspace
and driver

void *fb_info.par = xxxfb_par - struct that is private to the driver:

The above are the only data that the driver needs to access in order to
function correctly.

Your xxxfb_init() function must be module_init().  No need to alter other
files except the Makefile and Kconfig.

In general start your xxxfb_init() function with this:

if (fb_get_options("chipsfb", NULL))
	return -ENODEV

Or if the driver needs to parse options with xxxfb_setup(), then

	char *option = NULL;

	if (fb_get_options("chipsfb", &option))
		return -ENODEV;
	xxxfb_setup(option);

int __init xxxfb_init(void) {
	struct xxxfb_par *par;
	struct fb_info *info;

	... call fb_get_options() here;

	... allocate the driver structures
	info = framebuffer_alloc(sizeof(struct xxxfb_par));
	... check for errors
	par = info->par;

	... do your stuff here, allocation of resources, etc;
	xxx

	... then fill up the fb_info structure, very important:
	info->fbops = xxxfb_ops;
	info->var = xxxfb_var; /* the mode the driver will boot into */
	info->fix = xxxfb_fix; /* the fix struct the driver will boot into */
	info->screen_base = xxx; /* the virtual address of the framebuffer */
	fb_alloc_cmap(&info->cmap, 256, 0); /* 256 is a generally safe value*/
	info->flags = FBINFO_DEFAULT | other options; /* not very important */

	... finally register the framebuffer
	register_framebuffer(info);
	
	... and exit
	return 0;
}

struct fb_ops xxxfb_ops;

1. In 2.4, the drawing function are in struct display->dispsw = fbcon_cfb* or
ct48b_accel.  This is gone now, instead, the following hooks in struct fb_ops
are used instead:

fb_imageblit (required)
fb_copyarea (required)
fb_fillrect (required)
fb_cursor (required)

The generic versions are:

cfb_imageblit - used by the putc, putcs methods and logo drawing
cfb_copyarea - used by the bmove method
cfb_fillrect - used by the clear, clear_margins methods
soft_cursor - the cursor method

They will work correctly as long as the driver is in packed-pixel mode at
whatever bpp. soft_cursor will always work.

Test your driver with the generic functions, then you can write your own
hardware implementation.

2. The 2.4 version set_var is split into 2: 

fb_check_var (optional);
fb_set_par (optional);

2.a In fb_check_var, the driver will be passed with a var structure and all
the driver needs to do is check the contents and can do the following:

  a. alter the contents of the var to fit the hardware capability
  b. return -EINVAL if any of the fields in var does not fit the hardware

The first is the preferred response.

2.b In fb_set_par, the driver will actually modify the hardware according to
the contents of info->var _only_.  This is important.

3. fb_setcolreg (optional)

Not very different from the 2.4 version except that info->pseudo_palette
needs to be filled up if in directcolor or truecolor mode.  Also, if using
the generic cfb_* drawing functions, the pseudo_palette is always (u32 *).
The pseudo_palette must be a minimum of 16 entries. The pseudo_palette is
the same as 2.4' s display->dispsw_data.

4. fb_pan_display(optional)
optional function, not too different from the 2.4 version.

5. fb_sync (optional unless the driver has hardware accelerated drawing)
wait for engine idle (blit idle usually)   

6. fb_blank, fb_ioctl, fb_mmap are optional.

Note that the get_fix, get_var, set_var, getcolreg hooks in 2.4 are
gone in 2.6.

If you have further questions, just write to this list.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
