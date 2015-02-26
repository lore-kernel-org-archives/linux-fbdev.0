From: Ajay kumar <ajaynumb@gmail.com>
Date: Thu, 26 Feb 2015 05:59:04 +0000
Subject: Re: [PATCH 2/2] backlight: pwm: Add backlight-boot-off property
Message-Id: <CAEC9eQP-jFJpneinkjD_VDKi83+SiBE2rcwf2vm2ZmbHV-vdOQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424920366-7626-1-git-send-email-hl@rock-chips.com>
	<1424921954-8621-1-git-send-email-hl@rock-chips.com>
In-Reply-To: <1424921954-8621-1-git-send-email-hl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: huang lin <hl@rock-chips.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-rockchip@lists.infradead.org

Hi Huang,

On Thu, Feb 26, 2015 at 9:09 AM, huang lin <hl@rock-chips.com> wrote:
> Add backlight-boot-off property, so we can keeping the
> backlight disabled at boot until it is enabled implicitly
> by a panel driver, or explicitly by userspace
>
> Signed-off-by: huang lin <hl@rock-chips.com>
>
> ---
>
>  drivers/video/backlight/pwm_bl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 3a145a6..dece351 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -319,6 +319,10 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>         }
>
>         bl->props.brightness = data->dft_brightness;
> +
> +       if (of_find_property(pdev->dev.of_node, "backlight-boot-off", NULL))
> +               bl->props.power = FB_BLANK_POWERDOWN;
> +

You need to check this. Originally, Thierry proposed it.
http://permalink.gmane.org/gmane.linux.drivers.devicetree/84604

>         backlight_update_status(bl);
>
>         platform_set_drvdata(pdev, bl);
> --
> 1.9.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
