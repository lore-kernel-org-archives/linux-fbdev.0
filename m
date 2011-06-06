From: Hubert Feurstein <h.feurstein@gmail.com>
Date: Mon, 06 Jun 2011 13:24:09 +0000
Subject: Re: [PATCH] atmel_lcdfb: fix usage of wrong registers in suspend/resume
Message-Id: <BANLkTi=+HnxpEsgA=GCxyTGe2NV_KBXTiA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307350251-5767-1-git-send-email-h.feurstein@gmail.com>
In-Reply-To: <1307350251-5767-1-git-send-email-h.feurstein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Or it must be this way:
---
diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 4484c72..c2ceae4 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -1085,7 +1085,7 @@ static int atmel_lcdfb_suspend(struct
platform_device *pdev, pm_message_t mesg)
 	 */
 	lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0UL);

-	sinfo->saved_lcdcon =3D lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_VAL);
+	sinfo->saved_lcdcon =3D lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_CTR);
 	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, 0);
 	if (sinfo->atmel_lcdfb_power_control)
 		sinfo->atmel_lcdfb_power_control(0);
--
So which solution was originally intended?

Best regards
Hubert

2011/6/6 Hubert Feurstein <h.feurstein@gmail.com>:
> I assume the intention was to set the contrast value to 0 and not
> the contrast control register (in atmel_lcdfb_suspend). And in
> atmel_lcdfb_resume the contrast value should be restored.
>
> Signed-off-by: Hubert Feurstein <h.feurstein@gmail.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
> =A0drivers/video/atmel_lcdfb.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index 4484c72..2ed7ec1 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -1086,7 +1086,7 @@ static int atmel_lcdfb_suspend(struct platform_devi=
ce *pdev, pm_message_t mesg)
> =A0 =A0 =A0 =A0lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0UL);
>
> =A0 =A0 =A0 =A0sinfo->saved_lcdcon =3D lcdc_readl(sinfo, ATMEL_LCDC_CONTR=
AST_VAL);
> - =A0 =A0 =A0 lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, 0);
> + =A0 =A0 =A0 lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_VAL, 0);
> =A0 =A0 =A0 =A0if (sinfo->atmel_lcdfb_power_control)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sinfo->atmel_lcdfb_power_control(0);
>
> @@ -1105,7 +1105,7 @@ static int atmel_lcdfb_resume(struct platform_devic=
e *pdev)
> =A0 =A0 =A0 =A0atmel_lcdfb_start(sinfo);
> =A0 =A0 =A0 =A0if (sinfo->atmel_lcdfb_power_control)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sinfo->atmel_lcdfb_power_control(1);
> - =A0 =A0 =A0 lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, sinfo->saved_lc=
dcon);
> + =A0 =A0 =A0 lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_VAL, sinfo->saved_lc=
dcon);
>
> =A0 =A0 =A0 =A0/* Enable FIFO & DMA errors */
> =A0 =A0 =A0 =A0lcdc_writel(sinfo, ATMEL_LCDC_IER, ATMEL_LCDC_UFLWI
> --
> 1.7.1
>
>
