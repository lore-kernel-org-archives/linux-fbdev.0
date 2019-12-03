From: Jani Nikula <jani.nikula@intel.com>
Date: Tue, 03 Dec 2019 09:16:00 +0000
Subject: Re: [PATCH v2 07/14] video: omapfb: use const pointer for fb_ops
Message-Id: <877e3dkbvz.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
 <dfa4376e219ffeef9175993eaff91b5fe7ecccab.1575022735.git.jani.nikula@intel.com>
In-Reply-To: <dfa4376e219ffeef9175993eaff91b5fe7ecccab.1575022735.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, linux-omap@vger.kernel.org

On Fri, 29 Nov 2019, Jani Nikula <jani.nikula@intel.com> wrote:
> Use const for fb_ops to let us make the info->fbops pointer const in the
> future.
>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Pushed up to and including this patch to drm-misc-next, thanks for the
reviews and acks.

I may have missed some pointer chasing uses of info->fbops, reported by
0day. I'll need to double check those before proceeding with the next
patch.

BR,
Jani.

> ---
>  drivers/video/fbdev/omap/omapfb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
> index 702cca59bda1..e8a304f84ea8 100644
> --- a/drivers/video/fbdev/omap/omapfb_main.c
> +++ b/drivers/video/fbdev/omap/omapfb_main.c
> @@ -1052,7 +1052,7 @@ static int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd,
>  {
>  	struct omapfb_plane_struct *plane = fbi->par;
>  	struct omapfb_device	*fbdev = plane->fbdev;
> -	struct fb_ops		*ops = fbi->fbops;
> +	const struct fb_ops *ops = fbi->fbops;
>  	union {
>  		struct omapfb_update_window	update_window;
>  		struct omapfb_plane_info	plane_info;

-- 
Jani Nikula, Intel Open Source Graphics Center
