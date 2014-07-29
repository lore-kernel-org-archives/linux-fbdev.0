From: Bryan Wu <cooloney@gmail.com>
Date: Tue, 29 Jul 2014 23:25:43 +0000
Subject: Re: [PATCH -next] backlight: ipaq_micro: Fix sparse non static symbol warning
Message-Id: <CAK5ve-K6WpvN++xdKsHw=-BipV-mYh1PP63G78K=ExynBD9VGQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Jul 29, 2014 at 4:20 PM,  <weiyj_lk@163.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Fixes the following sparse warnings:
>
> drivers/video/backlight/ipaq_micro_bl.c:73:24: warning:
>  symbol 'micro_backlight_device_driver' was not declared. Should it be static?
>

I've merged a similar fix for led-ipaq-micro. So this one looks good to me:

Acked-by: Bryan Wu <cooloney@gmail.com>

> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/video/backlight/ipaq_micro_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/backlight/ipaq_micro_bl.c b/drivers/video/backlight/ipaq_micro_bl.c
> index feab29c..347dc11 100644
> --- a/drivers/video/backlight/ipaq_micro_bl.c
> +++ b/drivers/video/backlight/ipaq_micro_bl.c
> @@ -70,7 +70,7 @@ static int micro_backlight_probe(struct platform_device *pdev)
>         return 0;
>  }
>
> -struct platform_driver micro_backlight_device_driver = {
> +static struct platform_driver micro_backlight_device_driver = {
>         .driver = {
>                 .name    = "ipaq-micro-backlight",
>         },
>
