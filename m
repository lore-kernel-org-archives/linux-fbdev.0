From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 20 Feb 2017 12:52:54 +0000
Subject: Re: [PATCH] fbdev: ssd1307fb: include linux/gpio/consumer.h
Message-Id: <1839834.0emLzaqV2B@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170217144238epcas4p1bb3d59ce932e9ce12e4078268538933e@epcas4p1.samsung.com>
 <20170217144226.2250882-1-arnd@arndb.de>
In-Reply-To: <20170217144226.2250882-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jyri Sarha <jsarha@ti.com>, LABBE Corentin <clabbe.montjoie@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Friday, February 17, 2017 03:41:42 PM Arnd Bergmann wrote:
> Changing this driver to the gpiod API requires the use of the
> new-style header, depending on the configuration:
> 
> drivers/video/fbdev/ssd1307fb.c: In function 'ssd1307fb_probe':
> drivers/video/fbdev/ssd1307fb.c:569:15: error: implicit declaration of function 'devm_gpiod_get_optional';did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
> drivers/video/fbdev/ssd1307fb.c:570:11: error: 'GPIOD_OUT_LOW' undeclared (first use in this function)
> 
> Fixes: 72db33355c14 ("fbdev: ssd1307fb: Start to use gpiod API for reset gpio")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks for fixing this.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

