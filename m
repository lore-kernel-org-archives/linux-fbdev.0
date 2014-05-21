From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Wed, 21 May 2014 23:30:12 +0000
Subject: Re: [PATCH resend 1/4] nouveau: Don't check acpi_video_backlight_support() before registering backli
Message-Id: <2450872.0pLqjZcv9y@vostro.rjw.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1400679596-19663-1-git-send-email-hdegoede@redhat.com> <1400679596-19663-2-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1400679596-19663-2-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Wednesday, May 21, 2014 03:39:53 PM Hans de Goede wrote:
> acpi_video_backlight_support() is supposed to be called by other (vendor
> specific) firmware backlight controls, not by native / raw backlight controls
> like nv_backlight.
> 
> Userspace will normally prefer firmware interfaces over raw interfaces, so
> if acpi_video backlight support is present it will use that even if
> nv_backlight is registered as well.
> 
> Except when video.use_native_backlight is present on the kernel cmdline
> (or enabled through a dmi based quirk). As the name indicates the goal here
> is to make only the raw interface available to userspace so that it will use
> that (it only does this when it sees a win8 compliant bios).
> 
> This is done by:
> 1) Not registering any acpi_video# backlight devices; and
> 2) Making acpi_video_backlight_support() return true so that other firmware
> drivers, ie acer_wmi, thinkpad_acpi, dell_laptop, etc. Don't register their
> own vender specific interfaces.
> 
> Currently nouveau breaks this setup, as when acpi_video_backlight_support()
> returns true, it does not register itself, resulting in no backlight control
> at all.
> 
> This is esp. going to be a problem with 3.16 which will default to
> video.use_native_backlight=1, and thus nouveau based laptops with a win8 bios
> will get no backlight control at all.
> 
> This also likely explains why the previous attempt to make
> video.use_native_backlight=1 the default was not a success, as without this
> patch having a default of video.use_native_backlight=1 will cause regressions.
> 
> Note this effectively reverts commit 5bead799
> 
> Also see: https://bugzilla.redhat.com/show_bug.cgi?id93171
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

It would be good to have an ACK from the nouveau people for this one.

> ---
>  drivers/gpu/drm/nouveau/nouveau_backlight.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> index 630f6e8..2c1e4aa 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> @@ -31,7 +31,6 @@
>   */
>  
>  #include <linux/backlight.h>
> -#include <linux/acpi.h>
>  
>  #include "nouveau_drm.h"
>  #include "nouveau_reg.h"
> @@ -222,14 +221,6 @@ nouveau_backlight_init(struct drm_device *dev)
>  	struct nouveau_device *device = nv_device(drm->device);
>  	struct drm_connector *connector;
>  
> -#ifdef CONFIG_ACPI
> -	if (acpi_video_backlight_support()) {
> -		NV_INFO(drm, "ACPI backlight interface available, "
> -			     "not registering our own\n");
> -		return 0;
> -	}
> -#endif
> -
>  	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
>  		if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS &&
>  		    connector->connector_type != DRM_MODE_CONNECTOR_eDP)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
