From: Tomasz Figa <t.figa@samsung.com>
Date: Tue, 14 May 2013 14:16:38 +0000
Subject: Re: [PATCH 1/2] video: exynos_dp: Add parsing of gpios pins to exynos-dp driver
Message-Id: <1528008.HgBKZQmFTy@amdc1227>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1368536152-13370-1-git-send-email-vikas.sajjan@linaro.org>
 <1368536152-13370-2-git-send-email-vikas.sajjan@linaro.org>
In-Reply-To: <1368536152-13370-2-git-send-email-vikas.sajjan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vikas Sajjan <vikas.sajjan@linaro.org>
Cc: jg1.han@samsung.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, devicetree-discuss@lists.ozlabs.org, patches@linaro.org, linaro-kernel@lists.linaro.org, rpurdie@rpsys.net, FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org

Hi Vikas,

On Tuesday 14 of May 2013 18:25:51 Vikas Sajjan wrote:
>  Adds GPIO parsing functionality for "LCD backlight" and "LCD enable"
>  GPIO pins of exynos dp controller.
> 
> Signed-off-by: Vikas Sajjan <vikas.sajjan@linaro.org>
> ---
>  drivers/video/exynos/exynos_dp_core.c |   45
> +++++++++++++++++++++++++++++++++ 1 file changed, 45 insertions(+)
> 

I don't think that Exynos DP driver is right place for such code. Backlight 
and LCD drivers are responsible for backlight and LCD power control using 
backlight and LCD subsystems.

IMHO the correct solution would be to either extend existing backlight/lcd 
drivers found in drivers/video/backlight to support direct GPIO control and 
parse GPIO pins from device tree or create new gpio_bl and gpio_lcd drivers.

CCing Richard, Florian and linux-fbdev.

Best regards,
Tomasz

