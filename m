From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 16 Apr 2018 09:11:06 +0000
Subject: Re: [PATCH 3/3] backlight: pwm_bl: don't use GPIOF_* with gpiod_get_direction
Message-Id: <20180416091106.lg7nesbqvfeehuzq@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180114210711.13863-1-wsa+renesas@sang-engineering.com>
 <20180114210711.13863-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180114210711.13863-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

On Sun, 14 Jan 2018, Wolfram Sang wrote:

> The documentation was wrong, gpiod_get_direction() returns 0/1 instead
> of the GPIOF_* flags. The docs were fixed with commit 94fc73094abe47
> ("gpio: correct docs about return value of gpiod_get_direction"). Now,
> fix this user (until a better, system-wide solution is in place).
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Only build tested!
> 
>  drivers/video/backlight/pwm_bl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied with Daniel and Simon's Acks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
