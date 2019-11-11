From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 11 Nov 2019 09:30:38 +0000
Subject: Re: [PATCH 38/46] video: backlight: tosa: use gpio lookup table
Message-Id: <20191111093038.GA3218@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-38-arnd@arndb.de>
In-Reply-To: <20191018154201.1276638-38-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, linux-fbdev@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org

On Fri, 18 Oct 2019, Arnd Bergmann wrote:

> The driver should not require a machine specific header. Change
> it to pass the gpio line through a lookup table, and move the
> timing generator definitions into the drivers itself.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> ---
> I'm not overly confident that I got the correct device names
> for the lookup table, it would be good if someone could
> double-check.
> ---
>  arch/arm/mach-pxa/include/mach/tosa.h | 15 --------------
>  arch/arm/mach-pxa/tosa.c              | 22 +++++++++++++++++++++
>  drivers/video/backlight/tosa_bl.c     | 10 +++++-----
>  drivers/video/backlight/tosa_bl.h     |  8 ++++++++
>  drivers/video/backlight/tosa_lcd.c    | 28 ++++++++++++++++++++-------
>  5 files changed, 56 insertions(+), 27 deletions(-)
>  create mode 100644 drivers/video/backlight/tosa_bl.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
