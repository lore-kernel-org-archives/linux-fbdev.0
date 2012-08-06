From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 06 Aug 2012 15:26:22 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdc: Fix vertical panning step
Message-Id: <2592496.cxtrKkfb7X@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343306215-20868-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1343306215-20868-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Morimoto-san,

On Sunday 29 July 2012 18:25:59 Kuninori Morimoto wrote:
> > diff --git a/drivers/video/sh_mobile_lcdcfb.c
> > b/drivers/video/sh_mobile_lcdcfb.c index 8cb653b..699487c 100644
> > --- a/drivers/video/sh_mobile_lcdcfb.c
> > +++ b/drivers/video/sh_mobile_lcdcfb.c
> > @@ -1716,11 +1716,11 @@ sh_mobile_lcdc_overlay_fb_init(struct
> > sh_mobile_lcdc_overlay *ovl)> 
> >  		info->fix.visual = FB_VISUAL_TRUECOLOR;
> >  	
> >  	switch (ovl->format->fourcc) {
> > 
> > -	case V4L2_PIX_FMT_NV16:
> > -	case V4L2_PIX_FMT_NV61:
> > -		info->fix.ypanstep = 2;
> >  	case V4L2_PIX_FMT_NV12:
> >  	case V4L2_PIX_FMT_NV21:
> > +		info->fix.ypanstep = 2;
> > +	case V4L2_PIX_FMT_NV16:
> > +	case V4L2_PIX_FMT_NV61:
> >  		info->fix.xpanstep = 2;
> >  	}
> > 
> > @@ -2215,11 +2215,11 @@ sh_mobile_lcdc_channel_fb_init(struct
> > sh_mobile_lcdc_chan *ch,
> >  		info->fix.visual = FB_VISUAL_TRUECOLOR;
> >  	
> >  	switch (ch->format->fourcc) {
> > -	case V4L2_PIX_FMT_NV16:
> > -	case V4L2_PIX_FMT_NV61:
> > -		info->fix.ypanstep = 2;
> >  	case V4L2_PIX_FMT_NV12:
> >  	case V4L2_PIX_FMT_NV21:
> > +		info->fix.ypanstep = 2;
> > +	case V4L2_PIX_FMT_NV16:
> > +	case V4L2_PIX_FMT_NV61:
> >  		info->fix.xpanstep = 2;
> >  	}
> 
> If possible, could you please add comment /* fall through */ ?
> current code is a little bit confusing

I'm afraid the code has already been pushed to v3.6-rc1 :-S

-- 
Regards,

Laurent Pinchart

