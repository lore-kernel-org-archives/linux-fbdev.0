From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 27 Sep 2013 00:14:24 +0000
Subject: Re: [PATCH 1/1] backlight: lm3630a_bl: Fix incorrect variable type
Message-Id: <00f901cebb16$85e27ad0$91a77070$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380196776-27909-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380196776-27909-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thursday, September 26, 2013 9:00 PM, Sachin Kamat wrote:
> 
> 'lm3630a_read' returns a negative error code upon failure. This
> will never get detected by unsigned 'rval'. Make it signed.

Hi Sachin Kamat,

The same patch was already sent by Dan Carpenter two days ago.
Also, it was merged to mm tree by Andrew Morton with my Acked-by.
Thank you for caring. :-)

Best regards,
Jingoo Han

> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Daniel Jeong <gshark.jeong@gmail.com>
> ---
>  drivers/video/backlight/lm3630a_bl.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index c63f918..65392f9 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -105,7 +105,7 @@ static int lm3630a_chip_init(struct lm3630a_chip *pchip)
>  /* interrupt handling */
>  static void lm3630a_delayed_func(struct work_struct *work)
>  {
> -	unsigned int rval;
> +	int rval;
>  	struct lm3630a_chip *pchip;
> 
>  	pchip = container_of(work, struct lm3630a_chip, work.work);
> --
> 1.7.9.5

