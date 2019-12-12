From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Thu, 12 Dec 2019 09:02:26 +0000
Subject: Re: [PATCH v3 10/12] media: constify fb ops across all drivers
Message-Id: <966b9db7-b6c2-d3a2-0842-574186418860@xs4all.nl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575390740.git.jani.nikula@intel.com>
 <71794337f8611271f2c1fdb3882119a58e743a87.1575390741.git.jani.nikula@intel.com>
In-Reply-To: <71794337f8611271f2c1fdb3882119a58e743a87.1575390741.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, Andy Walls <awalls@md.metrocast.net>, linux-media@vger.kernel.org

On 12/3/19 5:38 PM, Jani Nikula wrote:
> Now that the fbops member of struct fb_info is const, we can start
> making the ops const as well.
> 
> Remove the redundant fbops assignments while at it.
> 
> v2:
> - actually add const in vivid
> - fix typo (Christophe de Dinechin)
> 
> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> Cc: Andy Walls <awalls@md.metrocast.net>
> Cc: linux-media@vger.kernel.org
> Cc: ivtv-devel@ivtvdriver.org
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Thanks!

	Hans

> ---
>  drivers/media/pci/ivtv/ivtvfb.c          | 3 +--
>  drivers/media/platform/vivid/vivid-osd.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/pci/ivtv/ivtvfb.c b/drivers/media/pci/ivtv/ivtvfb.c
> index 95a56cce9b65..f2922b554b09 100644
> --- a/drivers/media/pci/ivtv/ivtvfb.c
> +++ b/drivers/media/pci/ivtv/ivtvfb.c
> @@ -925,7 +925,7 @@ static int ivtvfb_blank(int blank_mode, struct fb_info *info)
>  	return 0;
>  }
>  
> -static struct fb_ops ivtvfb_ops = {
> +static const struct fb_ops ivtvfb_ops = {
>  	.owner = THIS_MODULE,
>  	.fb_write       = ivtvfb_write,
>  	.fb_check_var   = ivtvfb_check_var,
> @@ -1049,7 +1049,6 @@ static int ivtvfb_init_vidmode(struct ivtv *itv)
>  
>  	oi->ivtvfb_info.node = -1;
>  	oi->ivtvfb_info.flags = FBINFO_FLAG_DEFAULT;
> -	oi->ivtvfb_info.fbops = &ivtvfb_ops;
>  	oi->ivtvfb_info.par = itv;
>  	oi->ivtvfb_info.var = oi->ivtvfb_defined;
>  	oi->ivtvfb_info.fix = oi->ivtvfb_fix;
> diff --git a/drivers/media/platform/vivid/vivid-osd.c b/drivers/media/platform/vivid/vivid-osd.c
> index f2e789bdf4a6..fbaec8acc161 100644
> --- a/drivers/media/platform/vivid/vivid-osd.c
> +++ b/drivers/media/platform/vivid/vivid-osd.c
> @@ -244,7 +244,7 @@ static int vivid_fb_blank(int blank_mode, struct fb_info *info)
>  	return 0;
>  }
>  
> -static struct fb_ops vivid_fb_ops = {
> +static const struct fb_ops vivid_fb_ops = {
>  	.owner = THIS_MODULE,
>  	.fb_check_var   = vivid_fb_check_var,
>  	.fb_set_par     = vivid_fb_set_par,
> @@ -311,7 +311,6 @@ static int vivid_fb_init_vidmode(struct vivid_dev *dev)
>  
>  	dev->fb_info.node = -1;
>  	dev->fb_info.flags = FBINFO_FLAG_DEFAULT;
> -	dev->fb_info.fbops = &vivid_fb_ops;
>  	dev->fb_info.par = dev;
>  	dev->fb_info.var = dev->fb_defined;
>  	dev->fb_info.fix = dev->fb_fix;
> 
