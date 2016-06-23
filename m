From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Jun 2016 08:50:04 +0000
Subject: Re: [PATCH] fbdev: atyfb: fix array overflow
Message-Id: <CAMuHMdUrrsVe_H0DwaRoJepYcMm50Yb4d500dia4Ou8kEaBioA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160622123822.1262383-1-arnd@arndb.de>
In-Reply-To: <20160622123822.1262383-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Ingo Molnar <mingo@kernel.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Borislav Petkov <bp@suse.de>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Arnd,

On Wed, Jun 22, 2016 at 2:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> When building with CONFIG_UBSAN_SANITIZE_ALL on ARM, I get this
> gcc warning for atyfb:
>
> drivers/video/fbdev/aty/atyfb_base.c: In function 'aty_bl_update_status':
> drivers/video/fbdev/aty/atyfb_base.c:167:33: warning: array subscript is above array bounds [-Warray-bounds]
> drivers/video/fbdev/aty/atyfb_base.c:152:26: warning: array subscript is above array bounds [-Warray-bounds]
>
> Apparently the warning is correct and there is indeed an overflow,
> which was never caught. I could only reproduce this on ARM and
> have opened a bug against the compiler for the lack of warning.
>
> This patch makes the array larger, so we cover all possible
> registers in the LCD controller without an overflow.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://bugs.linaro.org/show_bug.cgi?id#49
> ---
>  drivers/video/fbdev/aty/atyfb_base.c | 2 +-
>  include/video/mach64.h               | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
> index 001d3d871800..36ffba152eab 100644
> --- a/drivers/video/fbdev/aty/atyfb_base.c
> +++ b/drivers/video/fbdev/aty/atyfb_base.c
> @@ -134,7 +134,7 @@
>
>  #if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || \
>  defined (CONFIG_FB_ATY_GENERIC_LCD) || defined(CONFIG_FB_ATY_BACKLIGHT)
> -static const u32 lt_lcd_regs[] = {
> +static const u32 lt_lcd_regs[LCD_REG_NUM] = {
>         CNFG_PANEL_LG,
>         LCD_GEN_CNTL_LG,
>         DSTN_CONTROL_LG,
> diff --git a/include/video/mach64.h b/include/video/mach64.h
> index 89e91c0cb737..9f74e9e0aeb8 100644
> --- a/include/video/mach64.h
> +++ b/include/video/mach64.h
> @@ -1299,6 +1299,7 @@
>  #define APC_LUT_KL             0x38
>  #define APC_LUT_MN             0x39
>  #define APC_LUT_OP             0x3A
> +#define LCD_REG_NUM            0x3B /* total number */
>
>  /* Values in LCD_GEN_CTRL */
>  #define CRT_ON                          0x00000001ul

This doesn't look like the right fix to me.

Before, aty_st_lcd(LCD_MISC_CNTL, reg, par) in aty_bl_update_status()
wrote into an arbitrary register.
With your fix, it will write to register 0, which is IMHO also not OK.

I think aty_st_lcd() and aty_ld_lcd() should check whether the index is
out of range, perhaps even with a WARN_ON()?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
