From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 24 Jul 2013 06:00:44 +0000
Subject: Re: [PATCH] video: xilinxfb: Fix compilation warning
Message-Id: <007401ce8833$22ce0600$686a1200$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <ed64cda456be840147ae1f04bec6a99733f41c24.1374643896.git.michal.simek@xilinx.com>
In-Reply-To: <ed64cda456be840147ae1f04bec6a99733f41c24.1374643896.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Michal Simek' <michal.simek@xilinx.com>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>
Cc: 'Michal Simek' <monstr@monstr.eu>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Stepan Moskovchenko' <stepanm@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>

On Wednesday, July 24, 2013 2:32 PM, Michal Simek wrote:
> 
> regs_phys is phys_addr_t (u32 or u64).
> Lets retype it to u64.
> 
> Fixes compilation warning introduced by:
> video: xilinxfb: Use drvdata->regs_phys instead of physaddr
> (sha1: c88fafef0135e1e1c3e23c3e32ccbeeabc587f81)

CC'ed Stepan Moskovchenko


phys_addr_t is defined as below:

#ifdef CONFIG_PHYS_ADDR_T_64BIT
typedef u64 phys_addr_t;
#else
typedef u32 phys_addr_t;
#endif

According to 'Documentation/printk-formats.txt',
Physical addresses:
       %pa     0x01234567 or 0x0123456789abcdef
       For printing a phys_addr_t type (and its derivatives, such as
       resource_size_t) which can vary based on build options, regardless of
       the width of the CPU data path. Passed by reference.

Thus, '%pa' option looks proper, instead of casting (unsigned long long).

		dev_dbg(dev, "regs: phys=%pa, virt=%p\n", drvdata->regs_phys,
					drvdata->regs);


Best regards,
Jingoo Han


> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> ppc44x_defconfig
> Fixes regressions in v3.11-rc2
> 
> ---
>  drivers/video/xilinxfb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
> index f3d4a69..79175a6 100644
> --- a/drivers/video/xilinxfb.c
> +++ b/drivers/video/xilinxfb.c
> @@ -341,8 +341,8 @@ static int xilinxfb_assign(struct platform_device *pdev,
> 
>  	if (drvdata->flags & BUS_ACCESS_FLAG) {
>  		/* Put a banner in the log (for DEBUG) */
> -		dev_dbg(dev, "regs: phys=%x, virt=%p\n", drvdata->regs_phys,
> -					drvdata->regs);
> +		dev_dbg(dev, "regs: phys=%llx, virt=%p\n",
> +			(unsigned long long)drvdata->regs_phys, drvdata->regs);
>  	}
>  	/* Put a banner in the log (for DEBUG) */
>  	dev_dbg(dev, "fb: phys=%llx, virt=%p, size=%x\n",
> --
> 1.8.2.3
> 

