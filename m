From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 12 Aug 2019 08:05:06 +0000
Subject: Re: [PATCH] backlight: lms283gf05: Fix a typo in the description passed to 'devm_gpio_request_one()'
Message-Id: <20190812080506.GH4594@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190724213828.16916-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20190724213828.16916-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: daniel.thompson@linaro.org, b.zolnierkie@samsung.com, jingoohan1@gmail.com, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

On Wed, 24 Jul 2019, Christophe JAILLET wrote:

> The description passed to 'devm_gpio_request_one()' should be related to
> LMS283GF05, not LMS285GF05.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/video/backlight/lms283gf05.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
