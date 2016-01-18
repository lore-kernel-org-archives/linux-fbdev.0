From: Julian Scheel <julian@jusst.de>
Date: Mon, 18 Jan 2016 20:20:10 +0000
Subject: Re: [PATCH] fbdev: ssd1307fb: Fix chargepump setting
Message-Id: <569D48FA.8080307@jusst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447337257-31232-1-git-send-email-julian@jusst.de>
In-Reply-To: <1447337257-31232-1-git-send-email-julian@jusst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 15.11.15 14:36, Julian Scheel wrote:
> The charge pump setting must have bit D4 set all time according to the SSD1306
> App Note. Instead of doing an logical and off shifted setting bit with 0x14 it
> must be an logical or with 0x10 to ensure D4 is set.
>
> Signed-off-by: Julian Scheel <julian@jusst.de>
> ---
>   drivers/video/fbdev/ssd1307fb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
> index 1611215..5965a9b 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -389,7 +389,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
>   		return ret;
>
>   	ret = ssd1307fb_write_cmd(par->client,
> -		(par->device_info->need_chargepump & 0x1 << 2) & 0x14);
> +		0x10 | ((par->device_info->need_chargepump & 0x01) << 2));
>   	if (ret < 0)
>   		return ret;
>
>

+ Adding Jean-Christophe and Tomi in CC as maintainers and Thomas as the 
one who did last major changes to the driver.

Any objections on this patch?

Regards,
Julian
