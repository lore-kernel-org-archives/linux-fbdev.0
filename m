From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 25 Jun 2020 09:43:43 +0000
Subject: Re: [PATCH 6/8] backlight: backlight: Supply description for function args in existing Kerneldocs
Message-Id: <20200625094343.koh2ln4fy6v6h7mo@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
 <20200624145721.2590327-7-lee.jones@linaro.org>
In-Reply-To: <20200624145721.2590327-7-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-fbdev@vger.kernel.org, Andrew Zabolotny <zap@homelink.ru>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, jingoohan1@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jamey Hicks <jamey.hicks@hp.com>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org

On Wed, Jun 24, 2020 at 03:57:19PM +0100, Lee Jones wrote:
> Kerneldoc syntax is used, but not complete.  Descriptions required.
> 
> Prevents warnings like:
> 
>  drivers/video/backlight/backlight.c:329: warning: Function parameter or member 'reason' not described in 'backlight_force_update'
>  drivers/video/backlight/backlight.c:354: warning: Function parameter or member 'props' not described in 'backlight_device_register'
> 
> Cc: <stable@vger.kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Jamey Hicks <jamey.hicks@hp.com>
> Cc: Andrew Zabolotny <zap@homelink.ru>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/backlight.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 92d80aa0c0ef1..744ba58488e01 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -320,6 +320,7 @@ ATTRIBUTE_GROUPS(bl_device);
>   * backlight_force_update - tell the backlight subsystem that hardware state
>   *   has changed
>   * @bd: the backlight device to update
> + * @reason: reason for update
>   *
>   * Updates the internal state of the backlight in response to a hardware event,
>   * and generate a uevent to notify userspace
> @@ -344,6 +345,7 @@ EXPORT_SYMBOL(backlight_force_update);
>   * @devdata: an optional pointer to be stored for private driver use. The
>   *   methods may retrieve it by using bl_get_data(bd).
>   * @ops: the backlight operations structure.
> + * @props: pointer to backlight's properties structure.
>   *
>   * Creates and registers new backlight device. Returns either an
>   * ERR_PTR() or a pointer to the newly allocated device.
> -- 
> 2.25.1
> 
