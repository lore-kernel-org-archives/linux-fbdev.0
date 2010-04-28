From: Anatolij Gustschin <agust@denx.de>
Date: Wed, 28 Apr 2010 20:28:05 +0000
Subject: Re: [PATCH 3/3] powerpc/mpc5121: shared DIU framebuffer support
Message-Id: <20100428222805.0a1bab5d@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
	<1267307902-31939-4-git-send-email-agust@denx.de>
	<fa686aa41002272250j64b2d691vb41f73e1eb335c8a@mail.gmail.com>
In-Reply-To: <fa686aa41002272250j64b2d691vb41f73e1eb335c8a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org, yorksun@freescale.com, dzu@denx.de, wd@denx.de

Hi Grant,

Thanks for review and comments. I'm back to this now and hope
to address your comments soon.

On Sat, 27 Feb 2010 23:50:09 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Sat, Feb 27, 2010 at 2:58 PM, Anatolij Gustschin <agust@denx.de> wrote:
> > MPC5121 DIU configuration/setup as initialized by the boot
> > loader currently will get lost while booting Linux. As a
> > result displaying the boot splash is not possible through
> > the boot process.
> >
> > To prevent this we reserve configured DIU frame buffer
> > address range while booting and preserve AOI descriptor
> > and gamma table so that DIU continues displaying through
> > the whole boot process. On first open from user space
> > DIU frame buffer driver releases the reserved frame
> > buffer area and continues to operate as usual.
> >
> > The patch also moves drivers/video/fsl-diu-fb.h file to
> > include/linux as we use some DIU structures in platform
> > code.
> >
> > 'diu_ops' callbacks in platform code borrowed from John's
> > DIU code.
> >
> > Signed-off-by: John Rigby <jrigby@gmail.com>
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> 
> On quick glance this patch seems mostly okay, but this patch should
> probably be broken up a bit to simplify review and dissociate
> unrelated changes.  For example, the move of fsl-diu-fb.h is a
> discrete change that should be split off.  Some more comments
> below....

I will split off fsl-diu-fb.h move to separate patch.

...
> > diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c b/arch/powerpc/platforms/512x/mpc5121_generic.c
> > index a6c0e3a..3aaa281 100644
> > --- a/arch/powerpc/platforms/512x/mpc5121_generic.c
> > +++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
> > @@ -28,6 +28,7 @@
> >  */
> >  static char *board[] __initdata = {
> >        "prt,prtlvt",
> > +       "ifm,pdm360ng",
> 
> You're adding a new board here.  This is completely unrelated.

Yes, it is unrelated. This hunk sneaked in by accident, will drop it.

...
> > diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
> > index d72b2c7..1cfe9d5 100644
> > --- a/arch/powerpc/platforms/512x/mpc512x.h
> > +++ b/arch/powerpc/platforms/512x/mpc512x.h
> > @@ -17,4 +17,7 @@ extern int __init mpc5121_clk_init(void);
> >  void __init mpc512x_declare_of_platform_devices(void);
> >  extern void mpc512x_restart(char *cmd);
> >  extern void __init mpc5121_usb_init(void);
> > +extern void __init mpc512x_init_diu(void);
> > +extern void __init mpc512x_setup_diu(void);
> 
> __init annotations do not belong in header files.

Ok, I will remove them.

> > +extern struct fsl_diu_shared_fb diu_shared_fb;
> 
> Hmmmm.  I'm not fond of the global data structure.  Especially
> considering that the struct fsl_diu_shared_fb is defined in
> mpc512x_shared.c, so nothing outside of that .c file can do anything
> with the structure.

This is a remainder from early debugging code, will remove it.

> >  #endif                         /* __MPC512X_H__ */
> > diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
> > index fbdf65f..a8c50a6 100644
> > --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> > +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> > @@ -16,7 +16,11 @@
> >  #include <linux/io.h>
> >  #include <linux/irq.h>
> >  #include <linux/of_platform.h>
> > +#include <linux/fsl-diu-fb.h>
> > +#include <linux/bootmem.h>
> > +#include <sysdev/fsl_soc.h>
> >
> > +#include <asm/cacheflush.h>
> >  #include <asm/machdep.h>
> >  #include <asm/ipic.h>
> >  #include <asm/prom.h>
> > @@ -53,6 +57,284 @@ void mpc512x_restart(char *cmd)
> >                ;
> >  }
> >
> > +struct fsl_diu_shared_fb {
> > +       char            gamma[0x300];   /* 32-bit aligned! */
> > +       struct diu_ad   ad0;            /* 32-bit aligned! */
> > +       phys_addr_t     fb_phys;
> > +       size_t          fb_len;
> > +       bool            in_use;
> > +};
> > +
> > +unsigned int mpc512x_get_pixel_format(unsigned int bits_per_pixel,
> > +                                     int monitor_port)
> > +{
> > +       unsigned int pix_fmt;
> > +
> > +       switch (bits_per_pixel) {
> > +       case 32:
> > +               pix_fmt = 0x88883316;
> > +               break;
> > +       case 24:
> > +               pix_fmt = 0x88082219;
> > +               break;
> > +       case 16:
> > +               pix_fmt = 0x65053118;
> > +               break;
> > +       default:
> > +               pix_fmt = 0x00000400;
> > +       }
> > +       return pix_fmt;
> > +}
> > +
> > +void mpc512x_set_gamma_table(int monitor_port, char *gamma_table_base)
> > +{
> > +}
> > +
> > +void mpc512x_set_monitor_port(int monitor_port)
> > +{
> > +}
> > +
> > +#define CCM_SCFR1      0x0000000c
> > +#define DIU_DIV_MASK   0x000000ff
> > +void mpc512x_set_pixel_clock(unsigned int pixclock)
> > +{
> > +       unsigned long bestval, bestfreq, speed_ccb, busfreq;
> > +       unsigned long minpixclock, maxpixclock, pixval;
> > +       struct device_node *np;
> > +       void __iomem *ccm;
> > +       u32 temp;
> > +       long err;
> > +       int i;
> > +
> > +       np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-clock");
> > +       if (!np) {
> > +               pr_err("Can't find clock control module.\n");
> > +               return;
> > +       }
> > +
> > +       ccm = of_iomap(np, 0);
> > +       if (!ccm) {
> > +               pr_err("Can't map clock control module reg.\n");
> > +               of_node_put(np);
> > +               return;
> > +       }
> > +       of_node_put(np);
> > +
> > +       busfreq = 200000000;
> 
> Instead of some hard coding some bogus defalt busfreq, you should
> error out if the real frequency cannot be determined.  Force users to
> supply a valid tree.

Ok, will fix.

...
> > +
> > +       /* Calculate the pixel clock with the smallest error */
> > +       /* calculate the following in steps to avoid overflow */
> > +       pr_debug("DIU pixclock in ps - %d\n", pixclock);
> > +       temp = 1;
> > +       temp *= 1000000000;
> > +       temp /= pixclock;
> > +       temp *= 1000;
> > +       pixclock = temp;
> 
> Really?  I think you can simplify this.

Yes, will do it in the next patch.

...
> > diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> > index 19ca1da..263f7da 100644
> > --- a/drivers/video/fsl-diu-fb.c
> > +++ b/drivers/video/fsl-diu-fb.c
> > @@ -34,7 +34,7 @@
> >  #include <linux/of_platform.h>
> >
> >  #include <sysdev/fsl_soc.h>
> > -#include "fsl-diu-fb.h"
> > +#include <linux/fsl-diu-fb.h>
> >
> >  #include "ofmode.h"
> >
> > @@ -331,8 +331,11 @@ static int fsl_diu_enable_panel(struct fb_info *info)
> >        if (mfbi->type != MFB_TYPE_OFF) {
> >                switch (mfbi->index) {
> >                case 0:                         /* plane 0 */
> > -                       if (hw->desc[0] != ad->paddr)
> > +                       if (in_be32(&hw->desc[0]) != ad->paddr) {
> 
> Unrelated bugfix?  If so, please split into separate patch.
> 
> 
> > +                               out_be32(&dr.diu_reg->diu_mode, 0);
> >                                out_be32(&hw->desc[0], ad->paddr);
> 
> This line also looks like it needs fixing.

Will re-check it an fix.

> 
> > +                               out_be32(&dr.diu_reg->diu_mode, 1);
> > +                       }
> >                        break;
> >                case 1:                         /* plane 1 AOI 0 */
> >                        cmfbi = machine_data->fsl_diu_info[2]->par;
> > @@ -391,7 +394,7 @@ static int fsl_diu_disable_panel(struct fb_info *info)
> >
> >        switch (mfbi->index) {
> >        case 0:                                 /* plane 0 */
> > -               if (hw->desc[0] != machine_data->dummy_ad->paddr)
> > +               if (in_be32(&hw->desc[0]) != machine_data->dummy_ad->paddr)
> 
> Same bugfix?

Will re-check it, too.

> 
> >                        out_be32(&hw->desc[0],
> >                                machine_data->dummy_ad->paddr);
> >                break;
> > @@ -1102,6 +1105,10 @@ static int fsl_diu_open(struct fb_info *info, int user)
> >        struct mfb_info *mfbi = info->par;
> >        int res = 0;
> >
> > +       /* free boot splash memory on first /dev/fb0 open */
> > +       if (!mfbi->index && diu_ops.release_bootmem)
> > +               diu_ops.release_bootmem();
> > +
> >        spin_lock(&diu_lock);
> >        mfbi->count++;
> >        if (mfbi->count = 1) {
> > @@ -1436,6 +1443,7 @@ static int __devinit fsl_diu_probe(struct of_device *ofdev,
> >        int ret, i, error = 0;
> >        struct resource res;
> >        struct fsl_diu_data *machine_data;
> > +       int diu_mode;
> >
> >        machine_data = kzalloc(sizeof(struct fsl_diu_data), GFP_KERNEL);
> >        if (!machine_data)
> > @@ -1472,7 +1480,9 @@ static int __devinit fsl_diu_probe(struct of_device *ofdev,
> >                goto error2;
> >        }
> >
> > -       out_be32(&dr.diu_reg->diu_mode, 0);             /* disable DIU anyway*/
> > +       diu_mode = in_be32(&dr.diu_reg->diu_mode);
> > +       if (diu_mode != MFB_MODE1)
> > +               out_be32(&dr.diu_reg->diu_mode, 0);     /* disable DIU */
> 
> Is this the best approach?  Would it be better to make this decision
> based on a property in the device tree?

I don't think it is worth it. The driver disables the DIU
regardless of it is enabled or not and enables it later
using a dummy descriptor. We just prevent this disabling
if the DIU is pre-initialized and already displaying.

> >
> >        /* Get the IRQ of the DIU */
> >        machine_data->irq = irq_of_parse_and_map(np, 0);
> > @@ -1520,7 +1530,12 @@ static int __devinit fsl_diu_probe(struct of_device *ofdev,
> >        machine_data->dummy_ad->offset_xyd = 0;
> >        machine_data->dummy_ad->next_ad = 0;
> >
> > -       out_be32(&dr.diu_reg->desc[0], machine_data->dummy_ad->paddr);
> > +       /* Let DIU display splash screen if it was pre-initialized
> > +        * by the bootloader, set dummy area descriptor otherwise.
> > +        */
> > +       if (diu_mode != MFB_MODE1)
> > +               out_be32(&dr.diu_reg->desc[0], machine_data->dummy_ad->paddr);
> > +
> 
> Same as above.
> 
> >        out_be32(&dr.diu_reg->desc[1], machine_data->dummy_ad->paddr);
> >        out_be32(&dr.diu_reg->desc[2], machine_data->dummy_ad->paddr);
> >
> 
> 
> 

Thanks,
Anatolij
