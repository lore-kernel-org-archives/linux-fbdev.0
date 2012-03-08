From: James Simmons <jsimmons@infradead.org>
Date: Thu, 08 Mar 2012 16:57:21 +0000
Subject: Re: [PATCH] drm: exynos: Fix fb_videomode <-> drm_mode_modeinfo conversion
Message-Id: <alpine.LFD.2.02.1203081656160.1975@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331206495-3853-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1331206495-3853-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>, dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>


> The fb_videomode structure stores the front porch and back porch in the
> right_margin and left_margin fields respectively. right_margin should
> thus be computed with hsync_start - hdisplay, and left_margin with
> htotal - hsync_end. The same holds for the vertical direction.
> 
>        Active               Front           Sync            Back
>        Region               Porch                           Porch
> <-------------------><----------------><-------------><---------------->
> 
>   //////////////////|
>  ////////////////// |
> //////////////////  |..................               ..................
>                                        _______________
> 
> <------ xres -------><- right_margin -><- hsync_len -><- left_margin -->
> 
> <---- hdisplay ----->
> <------------ hsync_start ------------>
> <--------------------- hsync_end -------------------->
> <--------------------------------- htotal ----------------------------->
> 
> Fix the fb_videomode <-> drm_mode_modeinfo conversion functions
> accordingly.
> 

Wow I see this has remegered. Some time last year I posted a patch that 
had these routines in a generic format for people to use. I can repost 
them again if people are interested.

