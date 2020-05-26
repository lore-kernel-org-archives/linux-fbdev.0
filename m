From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 26 May 2020 07:00:44 +0000
Subject: Re: [PATCH v13 09/11] backlight: pwm_bl: Use 64-bit division function
Message-Id: <20200526070044.GB3628@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1587523702.git.gurus@codeaurora.org>
 <429c18e1e1461d7cd3ccb93f9093a6719744f6b0.1587523702.git.gurus@codeaurora.org>
In-Reply-To: <429c18e1e1461d7cd3ccb93f9093a6719744f6b0.1587523702.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, David Collins <collinsd@codeaurora.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, linux-fbdev@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>

On Tue, 21 Apr 2020, Guru Das Srinagesh wrote:

> Since the PWM framework is switching struct pwm_state.period's datatype
> to u64, prepare for this transition by using div_u64 to handle a 64-bit
> dividend instead of a straight division operation.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-pwm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
