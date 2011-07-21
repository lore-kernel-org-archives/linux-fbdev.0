From: Kukjin Kim <kgene.kim@samsung.com>
Date: Thu, 21 Jul 2011 07:53:42 +0000
Subject: RE: [PATCH V8 0/5] ARM: EXYNOS4: Add support EXYNOS4 FIMD
Message-Id: <006801cc477b$520fd2e0$f62f78a0$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1311202438-18105-1-git-send-email-jg1.han@samsung.com>
In-Reply-To: <1311202438-18105-1-git-send-email-jg1.han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Jingoo Han' <jg1.han@samsung.com>, 'Paul Mundt' <lethal@linux-sh.org>, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: 'Jonghun Han' <jonghun.han@samsung.com>, 'Ben Dooks' <ben-linux@fluff.org>

Jingoo Han wrote:
> 
> The patches are created against "for-next" branch of Kukjin Kim's tree at:
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> 
> This was originally submitted by Jonghun Han <jonghun.han@samsung.com>
> http://www.spinics.net/lists/arm-kernel/msg101781.html
> 
> This patch adds support FIMD(Fully Interactive Mobile Display) on Exynos4.
> The 4th patch is update for s3c-fb and others are for platform data
> 
> NOTE: The common part for SMDKV310 will be updated later.
> 
> v2: change clock name of exynos4 FIMD: "fimd" -> "lcd"
>      use 'has_clksel' variable in order to distinguish FIMD version
>      add 'lcd_clk' that can be used for only lcd pixel clock
>      add callback 'enable_clk()' to enable parent clock 'sclk_fimd'.
> v3: remove the callback from the platform data structure
> v4: move clk_enable(sfb->lcd_clk) under the if statement
> v5: add clk_enable/disable(sfb->lcd_clk) to
s3c_fb_runtime_suspend/resume().
> v6: rename dev-fimd-24bpp.c to dev-fimd0.c
>      add 'exynos4_fimd0_setup_clock()' to dev-fimd0.c to setup parent
clock.
> v7: remove parent clock setting from machine directory
>      use 'gpio_request_one()' to simply the gpio setting step
> v8: updated minor fixes
> 
> o To Kukjin Kim
> [PATCH V8 1/5] ARM: EXYNOS4: Change clock name for FIMD
> [PATCH V8 2/5] ARM: EXYNOS4: Add resource definition for FIMD
> [PATCH V8 3/5] ARM: EXYNOS4: Add platform device and helper functions for
> FIMD
> [PATCH V8 5/5] ARM: EXYNOS4: Add platform data for EXYNOS4 FIMD and
> LTE480WV  platform-lcd on SMDKC210
> 
Hi Jingoo,

As I replied in your 1st patch, will fix it when I apply this series.
Others, looks ok to me.

As you said, we need to implement handling of common part on each boards
next time :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> o To Paul Mundt
> [PATCH V8 4/5] video: s3c-fb: Add support EXYNOS4

