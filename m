From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 Oct 2019 20:30:07 +0000
Subject: Re: [PATCH v2 05/15] drm/fbconv: Add DRM <-> fbdev pixel-format conversion
Message-Id: <20191014203007.GA4373@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
 <20191014140416.28517-6-tzimmermann@suse.de>
In-Reply-To: <20191014140416.28517-6-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, airlied@linux.ie, gregkh@linuxfoundation.org, michel@daenzer.net, corbet@lwn.net, malat@debian.org, dri-devel@lists.freedesktop.org, sean@poorly.run

Hi Thomas.

On Mon, Oct 14, 2019 at 04:04:06PM +0200, Thomas Zimmermann wrote:
> DRM uses FOURCC constants to describe pixel formats, fbdev uses a
> per-component bitfield structure. The functions in this patch convert
> between the two.
> 

A few nits below.


> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_fbconv_helper.c | 435 ++++++++++++++++++++++++++++
>  include/drm/drm_fbconv_helper.h     |  23 ++
>  2 files changed, 458 insertions(+)
>  create mode 100644 include/drm/drm_fbconv_helper.h
> 
> diff --git a/drivers/gpu/drm/drm_fbconv_helper.c b/drivers/gpu/drm/drm_fbconv_helper.c
> index 0cb46d2c98c3..af45358a156a 100644
> --- a/drivers/gpu/drm/drm_fbconv_helper.c
> +++ b/drivers/gpu/drm/drm_fbconv_helper.c
> @@ -1 +1,436 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <asm/byteorder.h>
> +
> +#include <linux/fb.h>

<asm/*> after <linux/*>
So we in this way pick the more general include file first.

> +
> +struct format_map {
> +	bool (*is_format)(const struct fb_var_screeninfo *fb_var);
> +	uint32_t format;
> +};
We are in the kernel - where I think u32 is preferred over the longer
uint32_t.
If I grep in drm/* then they seems be be equally popular, so feel free
to ignore this comment.


> +static void set_fb_bitfield(struct fb_bitfield *bits, __u32 offset,
> +			    __u32 length)

This is not uapi - so u32 is preferred.

Both comments apply to the whole file.

I did not see that this was wired into the kernel-doc in Documentation/
but maybe I just missed it.

With my comments considered you can add:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

All code looks sane, but as I have not grasped the bigger picture
this can hardly be a review.

	Sam
