From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 16 Jun 2020 07:06:54 +0000
Subject: Re: [PATCH 2/2] pwm: iqs620a: Use 64-bit division
Message-Id: <20200616070654.GC2608702@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200615141606.2814208-1-thierry.reding@gmail.com>
 <20200615141606.2814208-3-thierry.reding@gmail.com>
In-Reply-To: <20200615141606.2814208-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Guru Das Srinagesh <gurus@codeaurora.org>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020, Thierry Reding wrote:

> The PWM framework is going to change the PWM period and duty cycles to
> be 64-bit unsigned integers. To avoid build errors on platforms that do
> not natively support 64-bit division, use explicity 64-bit division.
> 
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-iqs620a.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
