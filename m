From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: [TRIVIAL PATCH] FBDEV: Small impact patch for fbdev
Date: Wed, 11 Dec 2002 13:20:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <A042D564F44@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, adaplas@pol.net

On 10 Dec 02 at 21:59, James Simmons wrote:

> Fixed. Actually I used the following code.
> 
> int fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
> {
>         int xoffset = var->xoffset;
>         int yoffset = var->yoffset;
>         int err;
> 
>         if (xoffset < 0 || yoffset < 0 || info->fbops->fb_pan_display ||

I'm probably missing something important, but do not you want
                                           !info->fbops->fb_pan_display
instead?
                                                            Petr
                                                                                                       
>             xoffset + info->var.xres > info->var.xres_virtual ||
>             yoffset + info->var.yres > info->var.yres_virtual)
>                 return -EINVAL;
>         if ((err = info->fbops->fb_pan_display(var, info)))
>                 return err;
>         info->var.xoffset = var->xoffset;
>         info->var.yoffset = var->yoffset;
>         if (var->vmode & FB_VMODE_YWRAP)
