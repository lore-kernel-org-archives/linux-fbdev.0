From: James Simmons <jsimmons@infradead.org>
Subject: Re: [TRIVIAL PATCH] FBDEV: Small impact patch for fbdev
Date: Tue, 10 Dec 2002 21:59:51 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0212102155280.2617-100000@maxwell.earthlink.net>
References: <1039558622.1054.32.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1039558622.1054.32.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> Here's a diff to correct several small things that escaped through the
> cracks.

Ug. Now that a wider test base is being done and more drivers actually
compile we are going to see more cracks.

> 1.  The YNOMOVE scrollmode for non-accelerated drivers is just very slow
> because of a lot of block moves (leads to slow and jerky scrolling in
> vesafb with ypanning enabled).  Depending on var->accel_flags, set the
> scrollmode to either YREDRAW or YNOMOVE. For drivers with hardware
> acceleration, set var->accel_flags to nonzero for max speed.

Thanks. I have had several emails complementing the speed improvements.
Another speed boost will be a plus.

> 2.  fb_pan_display() always returns an error.  User apps will complain.

Fixed. Actually I used the following code.

int fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
{
        int xoffset = var->xoffset;
        int yoffset = var->yoffset;
        int err;

        if (xoffset < 0 || yoffset < 0 || info->fbops->fb_pan_display ||
            xoffset + info->var.xres > info->var.xres_virtual ||
            yoffset + info->var.yres > info->var.yres_virtual)
                return -EINVAL;
        if ((err = info->fbops->fb_pan_display(var, info)))
                return err;
        info->var.xoffset = var->xoffset;
        info->var.yoffset = var->yoffset;
        if (var->vmode & FB_VMODE_YWRAP)

instead. The reason is I didn't like the idea of xoffset and yoffset being
changed even if the hardware panning function failed. Comments?

> 3.  case FBIO_GETCMAP in fb_ioctl does not return immediately.  User
> apps will complain.

Fixed.

> 4.  vgastate.c is not saving the correct blocks.

Fixed.

> 5.  logo drawing for monochrome displays is just incorrect.(alterations
> were done by eyeballing only, no hardware for testing).

Will test on hgafb driver.
