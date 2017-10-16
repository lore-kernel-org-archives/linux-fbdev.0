From: Brian Norris <briannorris@chromium.org>
Date: Mon, 16 Oct 2017 23:57:11 +0000
Subject: Re: [RESEND PATCH v2 2/5] backlight: pwm_bl: Add device link for pwm_bl and pwm
Message-Id: <20171016235710.GA12188@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171016100640.26575-1-jeffy.chen@rock-chips.com>
 <20171016100640.26575-3-jeffy.chen@rock-chips.com>
In-Reply-To: <20171016100640.26575-3-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, rjw@rjwysocki.net, dianders@chromium.org, dri-devel@lists.freedesktop.org, tfiga@chromium.org, broonie@kernel.org, Jingoo Han <jingoohan1@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Daniel Thompson <daniel.thompson@linaro.org>, Lee Jones <lee.jones@linaro.org>

Hi,

On Mon, Oct 16, 2017 at 06:06:37PM +0800, Jeffy Chen wrote:
> When the pwm driver is unbound, the pwm_bl driver would still hold a
> reference to that pwm, and crash the kernel later(if someone trying
> to access that invalid pwm).

This is not the primary problem you're trying to address though, is it? This is
mostly supposed to handle PM, not device removal (though it seems to do some of
both).

But for the removal/unbind case, I wondered why the existing PWM "requested"
status [1] didn't catch the stated problem above, but then I noticed...the
driver core doesn't care if the driver remove() callback fails. So
pwmchip_remove() an return -EBUSY all it wants -- the device core is still
going to unbind you (and free all your devm_*'s). This seems kinda bad.

> Add a device link to avoid this.

This is going to be a *lot* of churn throughout the tree, if we expect
all resource consumers to do this. I think we'd want some kind of
agreement from the PM maintainers and (larger) subsystem owners before
going down this route...

And in the PWM case, pwm_get() already has the device pointer. Why can't
we just instrument it instead?

Brian

P.S. A little off-topic, but this enum is wrong, for use with test_bit():

enum {
        PWMF_REQUESTED = 1 << 0,
        PWMF_EXPORTED = 1 << 1,
};

test_bit() and friends take a bit number, not a bit mask. Fortunately it
doesn't matter much, since the bitmask is just not very dense this way. But
it's misleading and will cause problems if we get a lot new flags.

> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/video/backlight/pwm_bl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 9bd17682655a..a76f147a26e7 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -328,6 +328,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  		goto err_alloc;
>  	}
>  
> +	device_link_add(&pdev->dev, pb->pwm->chip->dev, DL_FLAG_AUTOREMOVE);
> +
>  	dev_dbg(&pdev->dev, "got pwm for backlight\n");
>  
>  	/*
> -- 
> 2.11.0
> 
> 
