From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Thu, 17 Oct 2019 10:11:16 +0000
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight toggle
Message-Id: <20191017101116.3d5okxmto5coecad@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <c89925bd-857d-874f-b74f-c5700d4c9fbd@ysoft.com>
In-Reply-To: <c89925bd-857d-874f-b74f-c5700d4c9fbd@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Adam Ford <aford173@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Jingoo Han <jingoohan1@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>

On Thu, Oct 17, 2019 at 11:48:08AM +0200, Michal Vokáč wrote:
> On 17. 10. 19 10:10, Uwe Kleine-König wrote:
> > A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
> > pwm_get_state() return the last implemented state")) changed the
> > semantic of pwm_get_state() and disclosed an (as it seems) common
> > problem in lowlevel PWM drivers. By not relying on the period and duty
> > cycle being retrievable from a disabled PWM this type of problem is
> > worked around.
> > 
> > Apart from this issue only calling the pwm_get_state/pwm_apply_state
> > combo once is also more effective.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> > 
> > There are now two reports about 01ccf903edd6 breaking a backlight. As
> > far as I understand the problem this is a combination of the backend pwm
> > driver yielding surprising results and the pwm-bl driver doing things
> > more complicated than necessary.
> > 
> > So I guess this patch works around these problems. Still it would be
> > interesting to find out the details in the imx driver that triggers the
> > problem. So Adam, can you please instrument the pwm-imx27 driver to
> > print *state at the beginning of pwm_imx27_apply() and the end of
> > pwm_imx27_get_state() and provide the results?
> > 
> > Note I only compile tested this change.
> 
> Hi Uwe,
> I was just about to respond to the "pwm_bl on i.MX6Q broken on 5.4-RC1+"
> thread that I have a similar problem when you submitted this patch.
> 
> So here are my few cents:
> 
> My setup is as follows:
>  - imx6dl-yapp4-draco with i.MX6Solo
>  - backlight is controlled with inverted PWM signal
>  - max brightness level = 32, default brightness level set to 32 in DT.
> 
> 1. Almost correct backlight behavior before 01ccf903edd6 ("pwm: Let
>    pwm_get_state() return the last implemented state):
> 
>  - System boots to userspace and backlight is enabled all the time from
>    power up.
> 
>    $ dmesg | grep state
>    [    1.763381] get state end: -1811360608, enabled: 0

What is -1811360608? When I wrote "print *state" above, I thought about
something like:

	pr_info("%s: period: %u, duty: %u, polarity: %d, enabled: %d",
		__func__, state->period, state->duty_cycle, state->polarity, state->enabled);

A quick look into drivers/pwm/pwm-imx27.c shows that this is another
driver that yields duty_cycle = 0 when the hardware is off.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
