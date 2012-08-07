From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 07 Aug 2012 00:24:37 +0000
Subject: Re: [PATCH] video: s3c-fb: Fix compile error/warning if CONFIG_OF is not selected
Message-Id: <000a01cd7433$07555780$16000680$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344261462-14183-1-git-send-email-dongjin.kim@agreeyamobility.net>
 <1344261462-14183-5-git-send-email-dongjin.kim@agreeyamobility.net>
In-Reply-To: <1344261462-14183-5-git-send-email-dongjin.kim@agreeyamobility.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Dongjin Kim' <tobetter@gmail.com>
Cc: 'Dongjin Kim' <dongjin.kim@agreeyamobility.net>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Monday, August 06, 2012 10:58 PM Dongjin Kim wrote:
> 
> Change-Id: I5d7ff6f0070a10225d5b064b362d3d8f214787fd
> Signed-off-by: Dongjin Kim <dongjin.kim@agreeyamobility.net>
> ---
>  drivers/video/s3c-fb.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index 8c8adb5..268be0c 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -1527,13 +1527,11 @@ static int s3c_fb_dt_parse_gpios(struct device *dev, struct s3c_fb *sfb,
> 
>  static void s3c_fb_dt_free_gpios(struct s3c_fb *sfb)
>  {
> -	return 0;
>  }
> 
> -static int s3c_fb_dt_parse_pdata(struct device *dev,
> -					struct s3c_fb_platdata **pdata)
> +static struct s3c_fb_platdata *s3c_fb_dt_parse_pdata(struct device *dev)
>  {
> -	return 0;
> +	return NULL;
>  }
>  #endif /* CONFIG_OF */


Um, DT is not yet merged to s3c-fb driver.
s3c_fb_dt_parse_pdata() and s3c_fb_dt_free_gpios() are not available.

So, this patch is unnecessary.

Best regards,
Jingoo Han


> 
> --
> 1.7.9.5

