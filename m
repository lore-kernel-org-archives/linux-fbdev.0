From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Feb 2011 08:11:09 +0000
Subject: Re: [PATCH] radeonfb: Let hwmon driver probe the "monid" I2C bus
Message-Id: <20110202091109.44342b88@endymion.delvare>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110111162352.5a634e9e@endymion.delvare>
In-Reply-To: <20110111162352.5a634e9e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Alexander,

On Wed, 02 Feb 2011 07:50:16 +0200, Alexander Goomenyuk wrote:
> On Thu, 2011-01-13 at 14:44 +1000, Dave Airlie wrote:
> > On Thu, Jan 13, 2011 at 2:11 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > > On Tue, Jan 11, 2011 at 04:23:52PM +0100, Jean Delvare wrote:
> > >> Some Radeon cards have an I2C-based thermal sensor chip connected to
> > >> the "monid" I2C bus. Set the I2C probing class of this bus properly so
> > >> that hwmon drivers can detect devices on it and bind to them.
> > >>
> > >> This closes kernel.org bug #26172.
> > >>
> > 
> > The radeon BIOS actually contains a table to tell us what chip is on the bus,
> > in the KMS driver we read this table and load the appropriate hwmon device,
> > 
> > There could possibly be other things on this bus than hw monitor devices.
> > 
> > Though radeonfb should be considered mostly dead.
> > 
> > Dave.
> 
> I have tried radeon KMS driver.
>         modinfo output:
>         filename:       /lib/modules/2.6.36-tuxonice-r3/kernel/drivers/gpu/drm/radeon/radeon.ko
>         depends:
>         drm,drm_kms_helper,ttm,fb,i2c-core,cfbfillrect,cfbimgblt,cfbcopyarea,i2c-algo-bit
>         vermagic:       2.6.36-tuxonice-r3 SMP mod_unload 686 
>         parm:           no_wb:Disable AGP writeback for scratch
>         registers (int)
>         parm:           modeset:Disable/Enable modesetting (int)
>         parm:           dynclks:Disable/Enable dynamic clocks (int)
>         parm:           r4xx_atom:Enable ATOMBIOS modesetting for R4xx
>         (int)
>         parm:           vramlimit:Restrict VRAM for testing (int)
>         parm:           agpmode:AGP Mode (-1 = PCI) (int)
>         parm:           gartsize:Size of PCIE/IGP gart to setup in
>         megabytes (32,64, etc)
>          (int)
>         parm:           benchmark:Run benchmark (int)
>         parm:           test:Run tests (int)
>         parm:           connector_table:Force connector table (int)
>         parm:           tv:TV enable (0 = disable) (int)
>         parm:           new_pll:Select new PLL code (int)
>         parm:           audio:Audio enable (0 = disable) (int)
>         parm:           disp_priority:Display Priority (0 = auto, 1 >         normal, 2 = high) (int)
>         parm:           hw_i2c:hw i2c engine enable (0 = disable) (int)
>         
> But it also need modifications in order to be used by lm63 hwmon driver.
> 1. MONID line is disable by combios_setup_i2c_bus() for RV380 because
> of:
>         case CHIP_RV350:
>         case CHIP_RV380:
>         case CHIP_RS400:
>         case CHIP_RS480:
>                 switch (ddc_line) {
>                 case RADEON_GPIO_VGA_DDC:
>                 case RADEON_GPIO_DVI_DDC:
> +                       i2c.hw_capable = true;
> -                       i2c.hw_capable = false;
>                         break;
>                 case RADEON_GPIO_MONID:
>                      /* hw i2c on RADEON_GPIO_MONID doesn't seem to work
>                       * reliably on some pre-r4xx hardware; not sure why
>                       */
>                         i2c.hw_capable = true;
>                         break;
> 
> extracted from the sources.
> It would be nice if there will be some driver parameter to control this
> behavior. Or/and control it in kernel configuration menu.

I'm sorry but I don't understand what you mean. For one thing, I can't
see how the above change (?) is related to your problem, as it only
affects the DDC channels and not the MONID channel. For another, I
can't see how the bus being software or hardware driven would have any
effect.

> 
> 2. MONID adapter is not registered as HWMON capable.
> So I have added the following line into radeon_combios_i2c_init():
> 
>         } else if (rdev->family >= CHIP_R300) {
>                i2c = combios_setup_i2c_bus(rdev, DDC_MONID, 0, 0);
>                rdev->i2c_bus[3] = radeon_i2c_create(dev, &i2c, "MONID");
> +              rdev->i2c_bus[3]->adapter.class = I2C_CLASS_HWMON;
> 
> Now I see GPU temperature using lm_sensors.

But this isn't the way the drm radeon driver is designed. It reads from
the BIOS whether there are sensors available, what is their type and
their address, etc. It does not rely on physical probing as the
radeonfb driver does. So the above is NOT correct.

I can imagine that sensor support has only been implemented for
atom-BIOS based boards and not older com-BIOS based ones. At least
searching for "lm63" in the source code has matches in only
radeon_atombios.c and not radeon_combios.c. I have no idea if it would
be possible to extend this mechanism to older boards or not - I don't
know if the com-BIOS included the information already.

-- 
Jean Delvare
