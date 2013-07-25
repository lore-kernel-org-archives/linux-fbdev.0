From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 25 Jul 2013 23:14:32 +0000
Subject: Re: [PATCH v3] video: xilinxfb: Fix compilation warning
Message-Id: <000e01ce898c$b865f740$2931e5c0$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <b8701d73538d37495b41ef465440a6d5f3018870.1374759923.git.michal.simek@xilinx.com>
In-Reply-To: <b8701d73538d37495b41ef465440a6d5f3018870.1374759923.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Michal Simek' <michal.simek@xilinx.com>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>
Cc: 'Michal Simek' <monstr@monstr.eu>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Geert Uytterhoeven' <geert@linux-m68k.org>, Jingoo Han <jg1.han@samsung.com>

On Thursday, July 25, 2013 10:45 PM, Michal Simek wrote:
> 
> regs_phys is phys_addr_t (u32 or u64).
> Lets use %pa printk format specifier.
> 
> Fixes compilation warning introduced by:
> video: xilinxfb: Use drvdata->regs_phys instead of physaddr
> (sha1: c88fafef0135e1e1c3e23c3e32ccbeeabc587f81)
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

It looks good.

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
> Changes in v3:
> - Fix commit message reported by Geert
> 
> Changes in v2:
> - Use %pa instead of casting
> 
> ppc44x_defconfig
> Fixes regressions in v3.11-rc2
> 
> ---
>  drivers/video/xilinxfb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
> index f3d4a69..6629b29 100644
> --- a/drivers/video/xilinxfb.c
> +++ b/drivers/video/xilinxfb.c
> @@ -341,8 +341,8 @@ static int xilinxfb_assign(struct platform_device *pdev,
> 
>  	if (drvdata->flags & BUS_ACCESS_FLAG) {
>  		/* Put a banner in the log (for DEBUG) */
> -		dev_dbg(dev, "regs: phys=%x, virt=%p\n", drvdata->regs_phys,
> -					drvdata->regs);
> +		dev_dbg(dev, "regs: phys=%pa, virt=%p\n",
> +			&drvdata->regs_phys, drvdata->regs);
>  	}
>  	/* Put a banner in the log (for DEBUG) */
>  	dev_dbg(dev, "fb: phys=%llx, virt=%p, size=%x\n",
> --
> 1.8.2.3
>

