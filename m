From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 3/3] drm/i915: allocate framebuffer cmap
Date: Mon, 2 Nov 2009 14:33:52 +0000 (GMT)
Message-ID: <alpine.LFD.2.00.0911021431360.30135@casper.infradead.org>
References: <4AEE8CDD.10600@ladisch.de> <4AEE8D6F.60209@ladisch.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755285AbZKBOeB@vger.kernel.org>
In-Reply-To: <4AEE8D6F.60209@ladisch.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Dave Airlie <airlied@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org



> Without an allocated colormap, FBIOGETCMAP fails.  This would make
> programs restore an all-black colormap ("links -g") or fail to work
> altogether ("mplayer -vo fbdev2").
> 
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
> ---
> Untested.
> 
> --- linux-2.6/drivers/gpu/drm/i915/intel_fb.c
> +++ linux-2.6/drivers/gpu/drm/i915/intel_fb.c
> @@ -227,6 +227,10 @@ static int intelfb_create(struct drm_dev
>  
>  	fb->fbdev = info;
>  
> +	ret = fb_alloc_cmap(&info->cmap, 256, 0);
> +	if (ret)
> +		goto out_unpin;
> +
>  	par->intel_fb = intel_fb;
>  
>  	/* To allow resizeing without swapping buffers */

It would be better to place that code in drm_fb_helper_single_fb_probe.
Also instead of 256 I would recommend using crtc->gamma_size.
