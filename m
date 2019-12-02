From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Mon, 02 Dec 2019 08:40:47 +0000
Subject: Re: [PATCH v2 11/14] HID: picoLCD: constify fb ops
Message-Id: <20191202094047.34525a7d@aether.lan.sysophe.eu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
 <8678a9a3566279c881bb4db944850eef35d0a4bb.1575022735.git.jani.nikula@intel.com>
In-Reply-To: <8678a9a3566279c881bb4db944850eef35d0a4bb.1575022735.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org

Hi Jani,

On Fri, 29 Nov 2019 12:29:41 Jani Nikula <jani.nikula@intel.com> wrote:
> Now that the fbops member of struct fb_info is const, we can start
> making the ops const as well.
>
> v2: fix	typo (Christophe de Dinechin)

Fine with me.
I don't think going through drm-misc would trigger any conflict, but
adding Jiri to CC for the case there was any preference.

Acked-by: Bruno Prémont <bonbons@linux-vserver.org>

> Cc: Bruno Prémont <bonbons@linux-vserver.org>
> Cc: linux-input@vger.kernel.org
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
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
