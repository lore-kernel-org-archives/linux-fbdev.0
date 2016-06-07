From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Date: Tue, 07 Jun 2016 06:49:07 +0000
Subject: Re: [PATCH] backlight: pwm_bl: disable PWM when 'duty_cycle' is zero
Message-Id: <20160607084907.14ffdc03@ipc1.ka-ro>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1465209896-10319-1-git-send-email-LW@KARO-electronics.de>
	<5755664D.5070109@ti.com>
In-Reply-To: <5755664D.5070109@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

Hi,

On Mon, 6 Jun 2016 15:02:21 +0300 Tomi Valkeinen wrote:
> Hi,
> 
> On 06/06/16 13:44, Lothar Waßmann wrote:
> > 'brightness' is usually an index into a table of duty_cycle values,
> > where the value at index 0 may well be non-zero
> > (tegra30-apalis-eval.dts and tegra30-colibri-eval-v3.dts are real-life
> > examples).
> > Thus brightness = 0 does not necessarily mean that the PWM output
> > will be inactive.
> > Check for 'duty_cycle = 0' rather than 'brightness = 0' to decide
> > whether to disable the PWM.
> 
> The binding doc does say:
> 
>   - brightness-levels: Array of distinct brightness levels. Typically these
>       are in the range from 0 to 255, but any range starting at 0 will do.
>       The actual brightness level (PWM duty cycle) will be interpolated
>       from these values. 0 means a 0% duty cycle (darkest/off), while the
>       last value in the array represents a 100% duty cycle (brightest).
> 
So, what should I do, when I need a range of levels that doesn't start
at 0? E.g. if the brightness is inverse proportional to the PWM duty
cycle.



Lothar Waßmann
