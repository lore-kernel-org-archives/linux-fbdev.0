From: Guru Das Srinagesh <gurus@codeaurora.org>
Date: Tue, 10 Mar 2020 18:12:42 +0000
Subject: Re: [PATCH v7 12/13] backlight: pwm_bl: Use 64-bit division macros for period and duty cycle
Message-Id: <20200310181242.GA31738@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1583782035.git.gurus@codeaurora.org>
 <bf6d8f6190d266f8992bd5451b12c9f3962fd18e.1583782035.git.gurus@codeaurora.org>
 <20200310143432.cfjlqac5x6oinshj@holly.lan>
In-Reply-To: <20200310143432.cfjlqac5x6oinshj@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, Lee Jones <lee.jones@linaro.org>

On Tue, Mar 10, 2020 at 02:34:32PM +0000, Daniel Thompson wrote:
> This patch looks like it is a tiny change to get the pwm_backlight to
> perform 64-bit division. Most of the above text is completely irrelevant
> to the change contained in this patch. No need to justify the change in
> the PWM structures here since that can go in the patch that changes
> those structures.  Just describe what this patch does, perhaps something
> like the following:
> 
>     The PWM API will shortly switch the state.period and
>     state.duty_cycle fields to 64-bit values. Make pwm_bl
>     ready for this transition by adopting 64-bit division
>     macros.

Will update the commit text accordingly.

> Also please copy the backlight maintainers into the covering letter. It
> is useful to place patches like this into context.

Will do.

Thank you.

Guru Das.
