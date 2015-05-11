From: "Kim, Milo" <milo.kim@ti.com>
Date: Mon, 11 May 2015 22:48:03 +0000
Subject: Re: [PATCH] backlight/lp855x: Don't clear level on suspend/blank
Message-Id: <555131A3.1080402@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1431376325-25741-1-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1431376325-25741-1-git-send-email-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Sean,

On 5/12/2015 5:32 AM, Sean Paul wrote:
> Don't clear the backlight level when we're going into suspend or
> blanking. Instead, just temporarily set the level to 0 so we retain
> the value when we resume.

Could you describe what the problem is? I wrote same code in other 
backlight drivers. So maybe I need to look into them as well.

> ---
>   drivers/video/backlight/lp855x_bl.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
> index 08ae72f..74daf7c 100644
> --- a/drivers/video/backlight/lp855x_bl.c
> +++ b/drivers/video/backlight/lp855x_bl.c
> @@ -257,21 +257,15 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
>   static int lp855x_bl_update_status(struct backlight_device *bl)
>   {
>   	struct lp855x *lp = bl_get_data(bl);
> +	int brightness = bl->props.brightness;
>
>   	if (bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
> -		bl->props.brightness = 0;
> +		brightness = 0;

After that, this driver can't show exact brightness value when the 
application tries to read 'brightness' through the sysfs.
The backlight is off but read value of 'brightness' is non-zero.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/video/backlight/backlight.c?id=refs/tags/v4.1-rc3#n159

Best regards,
Milo
