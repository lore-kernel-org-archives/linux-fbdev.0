From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 13 Jul 2018 07:35:25 +0000
Subject: Re: [PATCH] backlight: adp8860: Mark expected switch fall-through
Message-Id: <20180713073525.GS4641@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180709215156.GA8782@embeddedor.com>
In-Reply-To: <20180709215156.GA8782@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 09 Jul 2018, Gustavo A. R. Silva wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/video/backlight/adp8860_bl.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
