From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 24 Jul 2013 08:08:48 +0000
Subject: Re: [PATCH] video: xilinxfb: Fix compilation warning
Message-Id: <003a01ce8845$06df46e0$149dd4a0$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <ed64cda456be840147ae1f04bec6a99733f41c24.1374643896.git.michal.simek@xilinx.com>
 <007401ce8833$22ce0600$686a1200$@samsung.com> <51EF7FBD.8070103@monstr.eu>
 <51EF8530.90809@monstr.eu>
In-Reply-To: <51EF8530.90809@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Simek <monstr@monstr.eu>
Cc: 'Michal Simek' <michal.simek@xilinx.com>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Stepan Moskovchenko' <stepanm@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>

On Wednesday, July 24, 2013 4:42 PM, Michal Simek wrote:
> On 07/24/2013 09:18 AM, Michal Simek wrote:
> > On 07/24/2013 08:00 AM, Jingoo Han wrote:
> >> On Wednesday, July 24, 2013 2:32 PM, Michal Simek wrote:
> >>>
> >>> regs_phys is phys_addr_t (u32 or u64).
> >>> Lets retype it to u64.
> >>>
> >>> Fixes compilation warning introduced by:
> >>> video: xilinxfb: Use drvdata->regs_phys instead of physaddr
> >>> (sha1: c88fafef0135e1e1c3e23c3e32ccbeeabc587f81)
> >>
> >> CC'ed Stepan Moskovchenko
> >>
> >>
> >> phys_addr_t is defined as below:
> >>
> >> #ifdef CONFIG_PHYS_ADDR_T_64BIT
> >> typedef u64 phys_addr_t;
> >> #else
> >> typedef u32 phys_addr_t;
> >> #endif
> >>
> >> According to 'Documentation/printk-formats.txt',
> >> Physical addresses:
> >>        %pa     0x01234567 or 0x0123456789abcdef
> >>        For printing a phys_addr_t type (and its derivatives, such as
> >>        resource_size_t) which can vary based on build options, regardless of
> >>        the width of the CPU data path. Passed by reference.
> >>
> >> Thus, '%pa' option looks proper, instead of casting (unsigned long long).
> >>
> >> 		dev_dbg(dev, "regs: phys=%pa, virt=%p\n", drvdata->regs_phys,
> >> 					drvdata->regs);
> >>
> >
> > Ah. Wasn't aware about that.
> > Will retest.
> 
> On ppc44x_defconfig
> 
> $ powerpc-unknown-linux-gnu-gcc --version
> powerpc-unknown-linux-gnu-gcc (crosstool-NG-svn_unknown@20110406.104745) 4.3.2
> 
> This fix
> diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
> index 79175a6..a9a1167 100644
> --- a/drivers/video/xilinxfb.c
> +++ b/drivers/video/xilinxfb.c
> @@ -341,12 +341,12 @@ static int xilinxfb_assign(struct platform_device *pdev,
> 
>         if (drvdata->flags & BUS_ACCESS_FLAG) {
>                 /* Put a banner in the log (for DEBUG) */
> -               dev_dbg(dev, "regs: phys=%llx, virt=%p\n",
> -                       (unsigned long long)drvdata->regs_phys, drvdata->regs);
> +               dev_dbg(dev, "regs: phys=%pa, virt=%p\n",
> +                       drvdata->regs_phys, drvdata->regs);
>         }
>         /* Put a banner in the log (for DEBUG) */
> -       dev_dbg(dev, "fb: phys=%llx, virt=%p, size=%x\n",
> -               (unsigned long long)drvdata->fb_phys, drvdata->fb_virt, fbsize);
> +       dev_dbg(dev, "fb: phys=%pa, virt=%p, size=%x\n",
> +               drvdata->fb_phys, drvdata->fb_virt, fbsize);
> 

Hi Michal Simek,

Just now, I tested that the same problem happens on ARM config.
Also, I solved it by adding '&' operator.

'&' operator is necessary as below:

        dev_dbg(dev, "regs: phys=%pa, virt=%p\n",
                 &drvdata->regs_phys, drvdata->regs);
                ^^^

        dev_dbg(dev, "fb: phys=%pa, virt=%p, size=%x\n",
                &drvdata->fb_phys, drvdata->fb_virt, fbsize);
               ^^^

Best regards,
Jingoo Han

>         return 0;       /* success */
> 
> Generates two warnings even it should be ok according to link to specification you sent.
>   CC [M]  drivers/video/xilinxfb.o
> drivers/video/xilinxfb.c: In function 'xilinxfb_assign':
> drivers/video/xilinxfb.c:344: warning: format '%p' expects type 'void *', but argument 4 has type
> 'phys_addr_t'
> drivers/video/xilinxfb.c:348: warning: format '%p' expects type 'void *', but argument 4 has type
> 'dma_addr_t'
> 
> On microblaze toolchain I see the same warnings. (mmu_defconfig)
> 
> I have also grepped the kernel and I see that it is used in 4 c files which seems to me
> weird because phy_addr_t or dma_addr_t are used on a lot of places.
> 
> Thanks,
> Michal
> 
> --
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
> Maintainer of Linux kernel - Xilinx Zynq ARM architecture
> Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
> 


