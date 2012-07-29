From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 29 Jul 2012 21:14:33 +0000
Subject: Re: [PATCH] video: da8xx-fb: do clock reset of revision 2 LCDC before enabling
Message-Id: <5015A7B9.90200@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1342799471-10729-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1342799471-10729-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 07/20/2012 03:51 PM, Manjunathappa, Prakash wrote:
> As in specification software reset should be applied for several
> cycles before bringing it out of reset. Without this patch
> particularly during suspend and resume clock reset is not guaranteed
> to happen.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>

Applied. But it would be better if you made the patch dependencies
clear, as I didn't consider some of your patches mature enough for this
merge window. Now I had to figure out why my final build failed and
applied the patch below.


Best regards,

Florian Tobias Schandinat

---
commit a0239073fd75489d25575cf3aaf71ab55b416020
Author: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date:   Sun Jul 29 16:47:40 2012 +0000

    da8xx-fb: fix compile issue due to missing include

    Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index ca9943a..7ae9d53 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -32,6 +32,7 @@
 #include <linux/console.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <linux/lcm.h>
 #include <video/da8xx-fb.h>
 #include <asm/div64.h>


> ---
>  drivers/video/da8xx-fb.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 3d2d0d1..4440292 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -262,10 +262,18 @@ static inline void lcd_enable_raster(void)
>  {
>  	u32 reg;
>  
> +	/* Put LCDC in reset for several cycles */
> +	if (lcd_revision = LCD_VERSION_2)
> +		/* Write 1 to reset LCDC */
> +		lcdc_write(LCD_CLK_MAIN_RESET, LCD_CLK_RESET_REG);
> +	mdelay(1);
> +
>  	/* Bring LCDC out of reset */
>  	if (lcd_revision = LCD_VERSION_2)
>  		lcdc_write(0, LCD_CLK_RESET_REG);
> +	mdelay(1);
>  
> +	/* Above reset sequence doesnot reset register context */
>  	reg = lcdc_read(LCD_RASTER_CTRL_REG);
>  	if (!(reg & LCD_RASTER_ENABLE))
>  		lcdc_write(reg | LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
> @@ -279,10 +287,6 @@ static inline void lcd_disable_raster(void)
>  	reg = lcdc_read(LCD_RASTER_CTRL_REG);
>  	if (reg & LCD_RASTER_ENABLE)
>  		lcdc_write(reg & ~LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
> -
> -	if (lcd_revision = LCD_VERSION_2)
> -		/* Write 1 to reset LCDC */
> -		lcdc_write(LCD_CLK_MAIN_RESET, LCD_CLK_RESET_REG);
>  }
>  
>  static void lcd_blit(int load_mode, struct da8xx_fb_par *par)

