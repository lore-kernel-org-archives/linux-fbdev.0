From: Adam Jackson <ajax@redhat.com>
Date: Tue, 26 Mar 2019 16:03:03 +0000
Subject: Re: [PATCH 02/11] drm/fbdevdrm: Add fbdevdrm device
Message-Id: <0d2e7dccd35523dd652a3d4af4b031f8d9ab8efd.camel@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326091744.11542-3-tzimmermann@suse.de>
In-Reply-To: <20190326091744.11542-3-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie, daniel@ffwll.ch, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Tue, 2019-03-26 at 10:17 +0100, Thomas Zimmermann wrote:

> +static bool is_generic_driver(const struct fb_info *fb_info)
> +{
> +	/* DRM porting note: We don't want to bind to vga16fb, vesafb, or any
> +	 * other generic fbdev driver. Usually, these drivers have limited
> +	 * capabilitis. We only continue if the fix structure indicates a
> +	 * hardware-specific drivers . This test will also sort out drivers
> +	 * registered via DRM's fbdev emulation. If you're porting an fbdev
> +	 * driver to DRM, you can remove this test. The module's PCI device
> +	 * ids will contain this information.
> +	 */
> +	return !fb_info->fix.accel &&
> +	       !!strcmp(fb_info->fix.id, "S3 Virge/DX");
> +}

This seems odd. s3fb sets fix.accel to NULL unconditionally AFAICT, not
sure why you're testing for that explicitly.

I do have a question though: why _not_ support generic fbdev drivers?
If I had that, and the ability to disable creation of /dev/fb*, I could
expose a consistent video device enumeration to userspace. As it stands
I have no reasonable way of knowing which fbdev and drm devices are
pointed at the same hardware. If there were only drm devices...

- ajax
