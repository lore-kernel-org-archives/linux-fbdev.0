From: Guru Das Srinagesh <gurus@codeaurora.org>
Date: Thu, 16 Apr 2020 17:55:27 +0000
Subject: Re: [PATCH v12 09/11] backlight: pwm_bl: Use 64-bit division function
Message-Id: <20200416175527.GA21388@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1586414867.git.gurus@codeaurora.org>
 <e2139a83008e9f301889f9384487c55de475a6a2.1586414867.git.gurus@codeaurora.org>
 <20200416094420.GB2167633@dell>
In-Reply-To: <20200416094420.GB2167633@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, David Collins <collinsd@codeaurora.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, linux-fbdev@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>

On Thu, Apr 16, 2020 at 10:44:20AM +0100, Lee Jones wrote:
> On Wed, 08 Apr 2020, Guru Das Srinagesh wrote:
> 
> > Since the PWM framework is switching struct pwm_state.period's datatype
> > to u64, prepare for this transition by using div_u64 to handle a 64-bit
> > dividend instead of a straight division operation.
> > 
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: linux-pwm@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-fbdev@vger.kernel.org
> > 
> > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  drivers/video/backlight/pwm_bl.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> I see that this is part of a large set, but the remainder of the
> patches have been hidden from me.

Sorry about that, the full series is here: [1].

> Does this mean I can apply this patch on its own?

I'll defer to Uwe on this point as I am not sure of the implications of
taking in this single patch and not the entire series.

Thank you.

Guru Das.

[1] https://www.spinics.net/lists/linux-pwm/msg12131.html
