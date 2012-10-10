From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 10 Oct 2012 12:35:32 +0000
Subject: Re: [PATCH] video/mx3fb: set .owner to prevent module unloading while being used
Message-Id: <50756B94.4000901@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349428807-26373-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1349428807-26373-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On 10/05/2012 09:20 AM, Uwe Kleine-König wrote:
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied.


Thanks,

Florian Tobias Schandinat


> ---
>  drivers/video/mx3fb.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
> index d738108..ce1d452 100644
> --- a/drivers/video/mx3fb.c
> +++ b/drivers/video/mx3fb.c
> @@ -1568,7 +1568,8 @@ static int mx3fb_remove(struct platform_device *dev)
>  
>  static struct platform_driver mx3fb_driver = {
>  	.driver = {
> -		   .name = MX3FB_NAME,
> +		.name = MX3FB_NAME,
> +		.owner = THIS_MODULE,
>  	},
>  	.probe = mx3fb_probe,
>  	.remove = mx3fb_remove,

