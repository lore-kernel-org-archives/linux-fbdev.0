From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 11 Mar 2013 00:56:49 +0000
Subject: Re: [PATCH 1/3] video: backlight: adp5520: fix compiler warning in adp5520_show
Message-Id: <004e01ce1df3$4fc4d080$ef4e7180$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362771069-16345-1-git-send-email-devendra.aaru@gmail.com>
In-Reply-To: <1362771069-16345-1-git-send-email-devendra.aaru@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Saturday, March 09, 2013 4:31 AM, Devendra Naga wrote:
> 
> while compiling with make W=1 (gcc gcc (GCC) 4.7.2 20121109 (Red Hat 4.7.2-8))
> 
> found the following warning
> 
> drivers/video/backlight/adp5520_bl.c: In function ‘adp5520_show’:
> drivers/video/backlight/adp5520_bl.c:146:6: warning: variable ‘error’ set but not used [-Wunused-but-
> set-variable]
> 
> fixed by removing the variable
> 
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> 
> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
> ---
>  drivers/video/backlight/adp5520_bl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlight/adp5520_bl.c
> index a1e41d4..9f8b20b 100644
> --- a/drivers/video/backlight/adp5520_bl.c
> +++ b/drivers/video/backlight/adp5520_bl.c
> @@ -143,11 +143,10 @@ static int adp5520_bl_setup(struct backlight_device *bl)
>  static ssize_t adp5520_show(struct device *dev, char *buf, int reg)
>  {
>  	struct adp5520_bl *data = dev_get_drvdata(dev);
> -	int error;
>  	uint8_t reg_val;
> 
>  	mutex_lock(&data->lock);
> -	error = adp5520_read(data->master, reg, &reg_val);
> +	adp5520_read(data->master, reg, &reg_val);
>  	mutex_unlock(&data->lock);

Hi Devendra Naga,

I also agree with Andrew Morton's opinion.
It would be better to check return value from I2C read/write functions.

Best regards,
Jingoo Han

> 
>  	return sprintf(buf, "%u\n", reg_val);
> --
> 1.8.1.2

