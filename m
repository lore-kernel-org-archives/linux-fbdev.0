From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 03 Dec 2019 17:09:35 +0000
Subject: Re: [PATCH v3 07/12] video: fbdev: intelfb: use const pointer for fb_ops
Message-Id: <20191203170935.GI624164@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575390740.git.jani.nikula@intel.com>
 <171c573bc2977a6ec374753ac7bb03a3523ca2b7.1575390740.git.jani.nikula@intel.com>
In-Reply-To: <171c573bc2977a6ec374753ac7bb03a3523ca2b7.1575390740.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org

On Tue, Dec 03, 2019 at 06:38:49PM +0200, Jani Nikula wrote:
> Use const for fb_ops to let us make the fbops struct const in the
> future.
> 
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  drivers/video/fbdev/intelfb/intelfb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/intelfb/intelfb.h b/drivers/video/fbdev/intelfb/intelfb.h
> index b54db05f028d..5de703902a21 100644
> --- a/drivers/video/fbdev/intelfb/intelfb.h
> +++ b/drivers/video/fbdev/intelfb/intelfb.h
> @@ -273,7 +273,7 @@ struct intelfb_vsync {
>  
>  struct intelfb_info {
>  	struct fb_info *info;
> -	struct fb_ops  *fbops;
> +	const struct fb_ops *fbops;

I think aside from a lone assignment in intelfb_pci_register this is
entirely unused. But I also think resistance is futile so

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  	struct pci_dev *pdev;
>  
>  	struct intelfb_hwstate save_state;
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
