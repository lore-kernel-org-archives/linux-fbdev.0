From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Date: Mon, 7 Mar 2005 21:24:00 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0503072119420.6636@poirot.grange>
References: <XFMail.20050307194424.jim.hague@acm.org>
Mime-Version: 1.0
In-Reply-To: <XFMail.20050307194424.jim.hague@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jim Hague <jim.hague@acm.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hello, Jim

On Mon, 7 Mar 2005, Jim Hague wrote:

> On 05-Mar-2005 Guennadi Liakhovetski wrote:
> > Worked on 2.6.10-rc2. With 2.6.11 during boot upon switching to fb, text 
> > becomes orange, penguins look sick (not sharp). X starts and runs normal 
> > (doesn't use fb), switching to vt not possible any more. Disabling 
> > fb-console in kernel config fixes VTs. Reverting pm2fb.c fixes the 
> > problem.
> 
> I've just tried a stock 2.6.11 fresh from the tarball, and I see some of what
> you are seeing.
> 
> I don't see any problems with text colour or images. Text is white, Tux is 100%
> normal. This on a single processor K6/2-450 with a Creative Graphics Blaster
> Exxtreme, BTW.
> 
> However, I do see the problem switching back to a vt from X. In fact it does
> work, except that the video is blanked. This is a bug in pm2fb.c exposed by
> recent changes to fbcon. Please try this fix (works for me) and let me know if
> it restores normal service for you too.

Thanks for the patch. Yes, it does fix switching between X and VT. As for 
colours / graphics, disabling CONFIG_FB_PM2_FIFO_DISCONNECT fixes that 
too, but it worked under 2.6.10-rc2 with that option on too. What does it 
do and why I cannot use it under 2.6.11 any more? The help text to this 
option is not very enlightening...

Thanks
Guennadi

> 
> --- drivers/video/pm2fb.c.orig  2005-03-07 15:35:28.000000000 +0000
> +++ drivers/video/pm2fb.c       2005-03-07 18:34:13.000000000 +0000
> @@ -747,7 +747,7 @@
>         }
>         if ((info->var.vmode & FB_VMODE_MASK)==FB_VMODE_DOUBLE)
>                 video |= PM2F_LINE_DOUBLE;
> -       if (info->var.activate==FB_ACTIVATE_NOW)
> +       if ((info->var.activate & FB_ACTIVATE_MASK)==FB_ACTIVATE_NOW)
>                 video |= PM2F_VIDEO_ENABLE;
>         par->video = video;
> 
> Returning to your problems with text colour and images, can you try
> with CONFIG_FB_PM2_FIFO_DISCONNECT=n and see if that makes a difference.
> 
> Thanks.
> 
> -- 
> Jim Hague - jim.hague@acm.org          Never trust a computer you can't lift.
> 

---
Guennadi Liakhovetski
