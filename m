From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 19 Jun 2018 17:30:50 +0000
Subject: Re: [PATCH] video: fbdev: simplefb: Stop including <linux/clk-provider.h>
Message-Id: <23991cf4-d926-246d-2362-a28d490eb246@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180619172221.20252-1-geert+renesas@glider.be>
In-Reply-To: <20180619172221.20252-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi,

On 19-06-18 19:22, Geert Uytterhoeven wrote:
> Simplefb is not a clock provider, but it uses of_clk_get_parent_count(),
> so it can just include <linux/of_clk.h> instead.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

LGTM:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/video/fbdev/simplefb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index a3c44ecf4523e8ed..9a9d748b07f2777d 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -27,8 +27,8 @@
>   #include <linux/platform_data/simplefb.h>
>   #include <linux/platform_device.h>
>   #include <linux/clk.h>
> -#include <linux/clk-provider.h>
>   #include <linux/of.h>
> +#include <linux/of_clk.h>
>   #include <linux/of_platform.h>
>   #include <linux/parser.h>
>   #include <linux/regulator/consumer.h>
> 
