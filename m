From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Thu, 19 Jul 2012 01:40:03 +0000
Subject: Re: [PATCH 7/9] fbdev: sh_mobile_lcdc: Support horizontal panning
Message-Id: <50076573.1020901@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1342658362-19491-8-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1342658362-19491-8-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Laurent,

On 2012/07/19 9:39, Laurent Pinchart wrote:
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/video/sh_mobile_lcdcfb.c |   22 ++++++++++++++++------
>  1 files changed, 16 insertions(+), 6 deletions(-)
> 
> -	if (ovl->format->fourcc = V4L2_PIX_FMT_NV12 ||
> -	    ovl->format->fourcc = V4L2_PIX_FMT_NV21)
> +	switch (ovl->format->fourcc) {
> +	case V4L2_PIX_FMT_NV16:
> +	case V4L2_PIX_FMT_NV61:
> +		info->fix.xpanstep = 2;
> +	case V4L2_PIX_FMT_NV12:
> +	case V4L2_PIX_FMT_NV21:
>  		info->fix.ypanstep = 2;
> +	}

>  
> -	if (ch->format->fourcc = V4L2_PIX_FMT_NV12 ||
> -	    ch->format->fourcc = V4L2_PIX_FMT_NV21)
> +	switch (ch->format->fourcc) {
> +	case V4L2_PIX_FMT_NV16:
> +	case V4L2_PIX_FMT_NV61:
> +		info->fix.xpanstep = 2;
> +	case V4L2_PIX_FMT_NV12:
> +	case V4L2_PIX_FMT_NV21:
>  		info->fix.ypanstep = 2;
> +	}
>  

I think that the panstep settings are backwards.  The pansteps should be
NV16: x = 2, y = 1; NV12: x = 2, y = 2.

Cheers,

-- 
Damian Hobson-Garcia
IGEL Co.,Ltd
http://www.igel.co.jp


