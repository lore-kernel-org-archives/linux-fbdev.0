From: Brian Norris <briannorris@chromium.org>
Date: Tue, 17 Oct 2017 16:51:48 +0000
Subject: Re: [RESEND PATCH v2 2/5] backlight: pwm_bl: Add device link for pwm_bl and pwm
Message-Id: <20171017165146.GA3408@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171016100640.26575-1-jeffy.chen@rock-chips.com>
 <20171016100640.26575-3-jeffy.chen@rock-chips.com>
 <20171016235710.GA12188@google.com>
 <59E5BBC3.2020504@rock-chips.com>
In-Reply-To: <59E5BBC3.2020504@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jeffy <jeffy.chen@rock-chips.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, rjw@rjwysocki.net, dianders@chromium.org, dri-devel@lists.freedesktop.org, tfiga@chromium.org, broonie@kernel.org, Jingoo Han <jingoohan1@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Daniel Thompson <daniel.thompson@linaro.org>, Lee Jones <lee.jones@linaro.org>

Hi,

On Tue, Oct 17, 2017 at 04:13:55PM +0800, Jeffy Chen wrote:
> On 10/17/2017 07:57 AM, Brian Norris wrote:
> >This is going to be a*lot*  of churn throughout the tree, if we expect
> >all resource consumers to do this. I think we'd want some kind of
> >agreement from the PM maintainers and (larger) subsystem owners before
> >going down this route...
> >
> >And in the PWM case, pwm_get() already has the device pointer. Why can't
> >we just instrument it instead?
> 
> according to pwm_bl driver, we may need to take care of pwm_request() too:

That's a legacy API. I wouldn't spend any time on improving it. In fact,
the only other 2 users are:
(a) drivers/input/misc/max8997_haptic.c: abandoned; nobody provides
    pdata for that driver, so pwm_request() can never be called...
(b) arch/arm/mach-s3c24xx/mach-rx1950.c: can be easily converted to
    the lookup table approach (pwm_add_table() + pwm_get()) if needed

>         pb->pwm = devm_pwm_get(&pdev->dev, NULL);
>         if (IS_ERR(pb->pwm) && PTR_ERR(pb->pwm) != -EPROBE_DEFER &&
> !node) {
>                 dev_err(&pdev->dev, "unable to request PWM, trying
> legacy API\n");
>                 pb->legacy = true;
>                 pb->pwm = pwm_request(data->pwm_id, "pwm-backlight");
>         }
> 
> and maybe also *of_pwm_get...
> 
> maybe we can add a dummy pwm chip for those orphan pwms?

What? That seems like a very silly idea. And judging by Thierry's
response to your v4, he doesn't understand it either.

All I was suggesting was that you should try to add the device links in
the fewest places possible. Because if you require all consumers to add
extra boilerplate to resolve some strange corner cases, those corner
cases will likely go unsolved in many cases.

Brian
