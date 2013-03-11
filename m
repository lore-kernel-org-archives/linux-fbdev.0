From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 11 Mar 2013 23:52:18 +0000
Subject: Re: [PATCH v2] video: backlight: adp5520: fix compiler warning in adp5520_show
Message-Id: <008c01ce1eb3$775a50f0$660ef2d0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363044454-25111-1-git-send-email-devendra.aaru@gmail.com>
In-Reply-To: <1363044454-25111-1-git-send-email-devendra.aaru@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Tuesday, March 12, 2013 8:28 AM, Devendra Naga wrote:
> 
> while compiling with make W=1 (gcc gcc (GCC) 4.7.2 20121109 (Red Hat 4.7.2-8))
> found the following warning
> 
> drivers/video/backlight/adp5520_bl.c: In function ‘adp5520_show’:
> drivers/video/backlight/adp5520_bl.c:146:6: warning: variable ‘error’ set but not used [-Wunused-but-
> set-variable]
> 
> fixed by checking the return value of the variable
> 
> Cc: Jingoo Han <jg1.han@samsung.com>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
> ---
>  drivers/video/backlight/adp5520_bl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlight/adp5520_bl.c
> index a1e41d4..d923f23 100644
> --- a/drivers/video/backlight/adp5520_bl.c
> +++ b/drivers/video/backlight/adp5520_bl.c
> @@ -143,13 +143,16 @@ static int adp5520_bl_setup(struct backlight_device *bl)
>  static ssize_t adp5520_show(struct device *dev, char *buf, int reg)
>  {
>  	struct adp5520_bl *data = dev_get_drvdata(dev);
> -	int error;
> +	int ret;
>  	uint8_t reg_val;
> 
>  	mutex_lock(&data->lock);
> -	error = adp5520_read(data->master, reg, &reg_val);
> +	ret = adp5520_read(data->master, reg, &reg_val);
>  	mutex_unlock(&data->lock);
> 
> +	if (ret < 0)
> +		return ret;
> +
>  	return sprintf(buf, "%u\n", reg_val);
>  }
> 
> --
> 1.8.1.2

