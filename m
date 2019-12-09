From: Jani Nikula <jani.nikula@intel.com>
Date: Mon, 09 Dec 2019 13:59:53 +0000
Subject: Re: [Intel-gfx] [PATCH v3 09/12] HID: picoLCD: constify fb ops
Message-Id: <87wob54n1i.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575390740.git.jani.nikula@intel.com>
 <f415010cd52cce7d8a1250d4eca582ec64e67956.1575390741.git.jani.nikula@intel.com>
In-Reply-To: <f415010cd52cce7d8a1250d4eca582ec64e67956.1575390741.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>, Bruno =?utf-8?Q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>, linux-input@vger.kernel.org

On Tue, 03 Dec 2019, Jani Nikula <jani.nikula@intel.com> wrote:
> Now that the fbops member of struct fb_info is const, we can start
> making the ops const as well.
>
> v2: fix	typo (Christophe de Dinechin)
>
> Cc: Bruno Prémont <bonbons@linux-vserver.org>
> Cc: linux-input@vger.kernel.org
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Acked-by: Bruno Prémont <bonbons@linux-vserver.org>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Pushed to drm-misc-next, with Jiri's ack from the other thread [1],
thanks for the reviews and acks.

BR,
Jani.

[1] http://lore.kernel.org/r/nycvar.YFH.7.76.1912080106260.4603@cbobk.fhfr.pm


> ---
>  drivers/hid/hid-picolcd_fb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
> index e162a668fb7e..a549c42e8c90 100644
> --- a/drivers/hid/hid-picolcd_fb.c
> +++ b/drivers/hid/hid-picolcd_fb.c
> @@ -417,8 +417,7 @@ static int picolcd_set_par(struct fb_info *info)
>  	return 0;
>  }
>  
> -/* Note this can't be const because of struct fb_info definition */
> -static struct fb_ops picolcdfb_ops = {
> +static const struct fb_ops picolcdfb_ops = {
>  	.owner        = THIS_MODULE,
>  	.fb_destroy   = picolcd_fb_destroy,
>  	.fb_read      = fb_sys_read,

-- 
Jani Nikula, Intel Open Source Graphics Center
