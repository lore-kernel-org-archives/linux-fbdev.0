From: Sergei Shtylyov <sshtylyov@mvista.com>
Date: Tue, 24 Jul 2012 11:21:33 +0000
Subject: Re: [PATCH v2] da8xx-fb: enable sync lost interrupt
Message-Id: <500E853D.4030504@mvista.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343101413-1820-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1343101413-1820-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello.

On 24-07-2012 7:43, Manjunathappa, Prakash wrote:

> Patch enables sync lost interrupt and interrupt handler already
> takes care to handle it.

> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---
> Since v1:
> Minor nit, replaced spaces with tabs.

>   drivers/video/da8xx-fb.c |    7 +++++--
>   1 files changed, 5 insertions(+), 2 deletions(-)

> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 47118c7..8163832 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
[...]
> @@ -718,6 +719,7 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
>   	u32 reg_int;
>
>   	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
> +		pr_err("LCDC sync lost or underflow error occurred\n");

     You write "or" here. Perhaps it should be || instead of && above?

>   		lcd_disable_raster();
>   		lcdc_write(stat, LCD_MASKED_STAT_REG);
>   		lcd_enable_raster();
> @@ -773,6 +775,7 @@ static irqreturn_t lcdc_irq_handler_rev01(int irq, void *arg)
>   	u32 reg_ras;
>
>   	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
> +		pr_err("LCDC sync lost or underflow error occurred\n");

    Same comment.

WBR, Sergei

