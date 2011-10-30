From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 30 Oct 2011 15:53:25 +0000
Subject: Re: [PATCH v2] GIO bus support for SGI IP22/28
Message-Id: <4EAD72F5.9010800@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20111020221928.0C2191DA27@solo.franken.de>
In-Reply-To: <20111020221928.0C2191DA27@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org, ralf@linux-mips.org

On 10/20/2011 10:19 PM, Thomas Bogendoerfer wrote:
> SGI IP22/IP28 machines have GIO busses for adding graphics and other
> extension cards. This patch adds support for GIO driver/device
> handling and converts the newport console driver to a GIO driver.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
> 
> Changes to last version:
> - use EXPORT_SYMBOL_GPL
> - ChallengeS has only 2 slots
> - use subsys_initcall for gio detection
> 
> Florian, the whole patch should go through the MIPS tree, if it's ok for
> you.

No problem. I'm not even sure whether I'm responsible for it as it is not a
framebuffer but a console driver. Anyway I had a look at the console code so you
may add an
	Acked-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
if you like.


Best regards,

Florian Tobias Schandinat

>  arch/mips/include/asm/gio_device.h  |   56 +++++
>  arch/mips/sgi-ip22/Makefile         |    2 +-
>  arch/mips/sgi-ip22/ip22-gio.c       |  414 +++++++++++++++++++++++++++++++++++
>  arch/mips/sgi-ip22/ip22-mc.c        |   10 +-
>  arch/mips/sgi-ip22/ip22-setup.c     |   21 --
>  drivers/video/console/newport_con.c |   61 ++++--
>  6 files changed, 518 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/mips/include/asm/gio_device.h b/arch/mips/include/asm/gio_device.h
> new file mode 100644
> index 0000000..5437c84
> --- /dev/null
> +++ b/arch/mips/include/asm/gio_device.h
> @@ -0,0 +1,56 @@
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +
> +struct gio_device_id {
> +	__u8 id;
> +};
> +
> +struct gio_device {
> +	struct device   dev;
> +	struct resource resource;
> +	unsigned int    irq;
> +	unsigned int    slotno;
> +
> +	const char      *name;
> +	struct gio_device_id id;
> +	unsigned        id32:1;
> +	unsigned        gio64:1;
> +};
> +#define to_gio_device(d) container_of(d, struct gio_device, dev)
> +
> +struct gio_driver {
> +	const char    *name;
> +	struct module *owner;
> +	const struct gio_device_id *id_table;
> +
> +	int  (*probe)(struct gio_device *, const struct gio_device_id *);
> +	void (*remove)(struct gio_device *);
> +	int  (*suspend)(struct gio_device *, pm_message_t);
> +	int  (*resume)(struct gio_device *);
> +	void (*shutdown)(struct gio_device *);
> +
> +	struct device_driver driver;
> +};
> +#define to_gio_driver(drv) container_of(drv, struct gio_driver, driver)
> +
> +extern const struct gio_device_id *gio_match_device(const struct gio_device_id *,
> +						    const struct gio_device *);
> +extern struct gio_device *gio_dev_get(struct gio_device *);
> +extern void gio_dev_put(struct gio_device *);
> +
> +extern int gio_device_register(struct gio_device *);
> +extern void gio_device_unregister(struct gio_device *);
> +extern void gio_release_dev(struct device *);
> +
> +static inline void gio_device_free(struct gio_device *dev)
> +{
> +	gio_release_dev(&dev->dev);
> +}
> +
> +extern int gio_register_driver(struct gio_driver *);
> +extern void gio_unregister_driver(struct gio_driver *);
> +
> +#define gio_get_drvdata(_dev)        drv_get_drvdata(&(_dev)->dev)
> +#define gio_set_drvdata(_dev, data)  drv_set_drvdata(&(_dev)->dev, (data))
> +
> +extern void gio_set_master(struct gio_device *);
> diff --git a/arch/mips/sgi-ip22/Makefile b/arch/mips/sgi-ip22/Makefile
> index cc53849..411cda9 100644
> --- a/arch/mips/sgi-ip22/Makefile
> +++ b/arch/mips/sgi-ip22/Makefile
> @@ -4,7 +4,7 @@
>  #
>  
>  obj-y	+= ip22-mc.o ip22-hpc.o ip22-int.o ip22-time.o ip22-nvram.o \
> -	   ip22-platform.o ip22-reset.o ip22-setup.o
> +	   ip22-platform.o ip22-reset.o ip22-setup.o ip22-gio.o
>  
>  obj-$(CONFIG_SGI_IP22) += ip22-berr.o
>  obj-$(CONFIG_SGI_IP28) += ip28-berr.o
> diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
> new file mode 100644
> index 0000000..d841529
> --- /dev/null
> +++ b/arch/mips/sgi-ip22/ip22-gio.c
> @@ -0,0 +1,414 @@
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +
> +#include <asm/addrspace.h>
> +#include <asm/paccess.h>
> +#include <asm/gio_device.h>
> +#include <asm/sgi/gio.h>
> +#include <asm/sgi/hpc3.h>
> +#include <asm/sgi/mc.h>
> +#include <asm/sgi/ip22.h>
> +
> +static struct bus_type gio_bus;
> +
> +static struct {
> +	const char *name;
> +	__u8       id;
> +} gio_name_table[] = {
> +	{ .name = "SGI Impact", .id = 0x10 },
> +	{ .name = "Phobos G160", .id = 0x35 },
> +	/* fake IDs */
> +	{ .name = "SGI Newport", .id = 0x7e },
> +	{ .name = "SGI GR2/GR3", .id = 0x7f },
> +};
> +
> +/**
> + * gio_match_device - Tell if an of_device structure has a matching
> + * gio_match structure
> + * @ids: array of of device match structures to search in
> + * @dev: the of device structure to match against
> + *
> + * Used by a driver to check whether an of_device present in the
> + * system is in its list of supported devices.
> + */
> +const struct gio_device_id *gio_match_device(const struct gio_device_id *match,
> +		     const struct gio_device *dev)
> +{
> +	const struct gio_device_id *ids;
> +
> +	for (ids = match; ids->id != 0xff; ids++)
> +		if (ids->id = dev->id.id)
> +			return ids;
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(gio_match_device);
> +
> +struct gio_device *gio_dev_get(struct gio_device *dev)
> +{
> +	struct device *tmp;
> +
> +	if (!dev)
> +		return NULL;
> +	tmp = get_device(&dev->dev);
> +	if (tmp)
> +		return to_gio_device(tmp);
> +	else
> +		return NULL;
> +}
> +EXPORT_SYMBOL_GPL(gio_dev_get);
> +
> +void gio_dev_put(struct gio_device *dev)
> +{
> +	if (dev)
> +		put_device(&dev->dev);
> +}
> +EXPORT_SYMBOL_GPL(gio_dev_put);
> +
> +static ssize_t dev_show_name(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct gio_device *giodev;
> +
> +	giodev = to_gio_device(dev);
> +	return sprintf(buf, "%s", giodev->name);
> +}
> +
> +static DEVICE_ATTR(name, S_IRUGO, dev_show_name, NULL);
> +
> +static ssize_t dev_show_id(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	struct gio_device *giodev;
> +
> +	giodev = to_gio_device(dev);
> +	return sprintf(buf, "%x", giodev->id.id);
> +}
> +
> +static DEVICE_ATTR(id, S_IRUGO, dev_show_id, NULL);
> +
> +/**
> + * gio_release_dev - free an gio device structure when all users of it are finished.
> + * @dev: device that's been disconnected
> + *
> + * Will be called only by the device core when all users of this gio device are
> + * done.
> + */
> +void gio_release_dev(struct device *dev)
> +{
> +	struct gio_device *giodev;
> +
> +	giodev = to_gio_device(dev);
> +	kfree(giodev);
> +}
> +EXPORT_SYMBOL_GPL(gio_release_dev);
> +
> +int gio_device_register(struct gio_device *giodev)
> +{
> +	int rc;
> +
> +	giodev->dev.bus = &gio_bus;
> +	rc = device_register(&giodev->dev);
> +	if (rc)
> +		return rc;
> +
> +	rc = device_create_file(&giodev->dev, &dev_attr_name);
> +	if (rc)
> +		goto err;
> +	rc = device_create_file(&giodev->dev, &dev_attr_id);
> +	if (rc)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	device_unregister(&giodev->dev);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(gio_device_register);
> +
> +void gio_device_unregister(struct gio_device *giodev)
> +{
> +	device_remove_file(&giodev->dev, &dev_attr_id);
> +	device_remove_file(&giodev->dev, &dev_attr_name);
> +	device_unregister(&giodev->dev);
> +}
> +EXPORT_SYMBOL_GPL(gio_device_unregister);
> +
> +static int gio_bus_match(struct device *dev, struct device_driver *drv)
> +{
> +	struct gio_device *gio_dev = to_gio_device(dev);
> +	struct gio_driver *gio_drv = to_gio_driver(drv);
> +
> +	return gio_match_device(gio_drv->id_table, gio_dev) != NULL;
> +}
> +
> +static int gio_device_probe(struct device *dev)
> +{
> +	int error = -ENODEV;
> +	struct gio_driver *drv;
> +	struct gio_device *gio_dev;
> +	const struct gio_device_id *match;
> +
> +	drv = to_gio_driver(dev->driver);
> +	gio_dev = to_gio_device(dev);
> +
> +	if (!drv->probe)
> +		return error;
> +
> +	gio_dev_get(gio_dev);
> +
> +	match = gio_match_device(drv->id_table, gio_dev);
> +	if (match)
> +		error = drv->probe(gio_dev, match);
> +	if (error)
> +		gio_dev_put(gio_dev);
> +
> +	return error;
> +}
> +
> +static int gio_device_remove(struct device *dev)
> +{
> +	struct gio_device *gio_dev = to_gio_device(dev);
> +	struct gio_driver *drv = to_gio_driver(dev->driver);
> +
> +	if (dev->driver && drv->remove)
> +		drv->remove(gio_dev);
> +	return 0;
> +}
> +
> +static int gio_device_suspend(struct device *dev, pm_message_t state)
> +{
> +	struct gio_device *gio_dev = to_gio_device(dev);
> +	struct gio_driver *drv = to_gio_driver(dev->driver);
> +	int error = 0;
> +
> +	if (dev->driver && drv->suspend)
> +		error = drv->suspend(gio_dev, state);
> +	return error;
> +}
> +
> +static int gio_device_resume(struct device *dev)
> +{
> +	struct gio_device *gio_dev = to_gio_device(dev);
> +	struct gio_driver *drv = to_gio_driver(dev->driver);
> +	int error = 0;
> +
> +	if (dev->driver && drv->resume)
> +		error = drv->resume(gio_dev);
> +	return error;
> +}
> +
> +static void gio_device_shutdown(struct device *dev)
> +{
> +	struct gio_device *gio_dev = to_gio_device(dev);
> +	struct gio_driver *drv = to_gio_driver(dev->driver);
> +
> +	if (dev->driver && drv->shutdown)
> +		drv->shutdown(gio_dev);
> +}
> +
> +int gio_register_driver(struct gio_driver *drv)
> +{
> +	/* initialize common driver fields */
> +	if (!drv->driver.name)
> +		drv->driver.name = drv->name;
> +	if (!drv->driver.owner)
> +		drv->driver.owner = drv->owner;
> +	drv->driver.bus = &gio_bus;
> +
> +	/* register with core */
> +	return driver_register(&drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(gio_register_driver);
> +
> +void gio_unregister_driver(struct gio_driver *drv)
> +{
> +	driver_unregister(&drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(gio_unregister_driver);
> +
> +void gio_set_master(struct gio_device *dev)
> +{
> +	u32 tmp = sgimc->giopar;
> +
> +	switch (dev->slotno) {
> +	case 0:
> +		tmp |= SGIMC_GIOPAR_MASTERGFX;
> +		break;
> +	case 1:
> +		tmp |= SGIMC_GIOPAR_MASTEREXP0;
> +		break;
> +	case 2:
> +		tmp |= SGIMC_GIOPAR_MASTEREXP1;
> +		break;
> +	}
> +	sgimc->giopar = tmp;
> +}
> +EXPORT_SYMBOL_GPL(gio_set_master);
> +
> +void ip22_gio_set_64bit(int slotno)
> +{
> +	u32 tmp = sgimc->giopar;
> +
> +	switch (slotno) {
> +	case 0:
> +		tmp |= SGIMC_GIOPAR_GFX64;
> +		break;
> +	case 1:
> +		tmp |= SGIMC_GIOPAR_EXP064;
> +		break;
> +	case 2:
> +		tmp |= SGIMC_GIOPAR_EXP164;
> +		break;
> +	}
> +	sgimc->giopar = tmp;
> +}
> +
> +static int ip22_gio_id(unsigned long addr, u32 *res)
> +{
> +	u8 tmp8;
> +	u8 tmp16;
> +	u32 tmp32;
> +	u8 *ptr8;
> +	u16 *ptr16;
> +	u32 *ptr32;
> +
> +	ptr32 = (void *)CKSEG1ADDR(addr);
> +	if (!get_dbe(tmp32, ptr32)) {
> +		/*
> +		 * We got no DBE, but this doesn't mean anything.
> +		 * If GIO is pipelined (which can't be disabled
> +		 * for GFX slot) we don't get a DBE, but we see
> +		 * the transfer size as data. So we do an 8bit
> +		 * and a 16bit access and check whether the common
> +		 * data matches
> +		 */
> +		ptr8 = (void *)CKSEG1ADDR(addr + 3);
> +		get_dbe(tmp8, ptr8);
> +		ptr16 = (void *)CKSEG1ADDR(addr + 2);
> +		get_dbe(tmp16, ptr16);
> +		if (tmp8 = (tmp16 & 0xff) &&
> +		    tmp8 = (tmp32 & 0xff) &&
> +		    tmp16 = (tmp32 & 0xffff)) {
> +			*res = tmp32;
> +			return 1;
> +		}
> +	}
> +	return 0; /* nothing here */
> +}
> +
> +#define HQ2_MYSTERY_OFFS       0x6A07C
> +#define NEWPORT_USTATUS_OFFS   0xF133C
> +
> +static int ip22_is_gr2(unsigned long addr)
> +{
> +	u32 tmp;
> +	u32 *ptr;
> +
> +	/* HQ2 only allows 32bit accesses */
> +	ptr = (void *)CKSEG1ADDR(addr + HQ2_MYSTERY_OFFS);
> +	if (!get_dbe(tmp, ptr)) {
> +		if (tmp = 0xdeadbeef)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +
> +static void ip22_check_gio(int slotno, unsigned long addr)
> +{
> +	const char *name = "Unknown";
> +	struct gio_device *gio_dev;
> +	u32 tmp;
> +	__u8 id;
> +	int i;
> +
> +	/* first look for GR2/GR3 by checking mystery register */
> +	if (ip22_is_gr2(addr))
> +		tmp = 0x7f;
> +	else {
> +		if (!ip22_gio_id(addr, &tmp)) {
> +			/*
> +			 * no GIO signature at start address of slot, but
> +			 * Newport doesn't have one, so let's check usea
> +			 * status register
> +			 */
> +			if (ip22_gio_id(addr + NEWPORT_USTATUS_OFFS, &tmp))
> +				tmp = 0x7e;
> +			else
> +				tmp = 0;
> +		}
> +	}
> +	if (tmp) {
> +		id = GIO_ID(tmp);
> +		if (tmp & GIO_32BIT_ID) {
> +			if (tmp & GIO_64BIT_IFACE)
> +				ip22_gio_set_64bit(slotno);
> +		}
> +		for (i = 0; i < ARRAY_SIZE(gio_name_table); i++) {
> +			if (id = gio_name_table[i].id) {
> +				name = gio_name_table[i].name;
> +				break;
> +			}
> +		}
> +		printk(KERN_INFO "GIO: slot %d : %s (id %x)\n",
> +		       slotno, name, id);
> +		gio_dev = kzalloc(sizeof *gio_dev, GFP_KERNEL);
> +		gio_dev->name = name;
> +		gio_dev->slotno = slotno;
> +		gio_dev->id.id = id;
> +		gio_dev->resource.start = addr;
> +		gio_dev->resource.end = addr + 0x3fffff;
> +		gio_dev->resource.flags = IORESOURCE_MEM;
> +		dev_set_name(&gio_dev->dev, "gio%d", slotno);
> +		gio_device_register(gio_dev);
> +	} else
> +		printk(KERN_INFO "GIO: slot %d : Empty\n", slotno);
> +}
> +
> +static struct bus_type gio_bus = {
> +	.name     = "gio",
> +	.match    = gio_bus_match,
> +	.probe    = gio_device_probe,
> +	.remove   = gio_device_remove,
> +	.suspend  = gio_device_suspend,
> +	.resume   = gio_device_resume,
> +	.shutdown = gio_device_shutdown,
> +};
> +
> +static struct resource gio_bus_resource = {
> +	.start = GIO_SLOT_GFX_BASE,
> +	.end   = GIO_SLOT_GFX_BASE + 0x9fffff,
> +	.name  = "GIO Bus",
> +	.flags = IORESOURCE_MEM,
> +};
> +
> +int __init ip22_gio_init(void)
> +{
> +	unsigned int pbdma __maybe_unused;
> +	int ret;
> +
> +	ret = bus_register(&gio_bus);
> +	if (!ret) {
> +		request_resource(&iomem_resource, &gio_bus_resource);
> +		printk(KERN_INFO "GIO: Probing bus...\n");
> +
> +		if (ip22_is_fullhouse() ||
> +		    !get_dbe(pbdma, (unsigned int *)&hpc3c1->pbdma[1])) {
> +			/* Indigo2 and ChallengeS */
> +			ip22_check_gio(0, GIO_SLOT_GFX_BASE);
> +			ip22_check_gio(1, GIO_SLOT_EXP0_BASE);
> +		} else {
> +			/* Indy */
> +			ip22_check_gio(0, GIO_SLOT_GFX_BASE);
> +			ip22_check_gio(1, GIO_SLOT_EXP0_BASE);
> +			ip22_check_gio(2, GIO_SLOT_EXP1_BASE);
> +		}
> +	}
> +	return ret;
> +}
> +
> +subsys_initcall(ip22_gio_init);
> +
> diff --git a/arch/mips/sgi-ip22/ip22-mc.c b/arch/mips/sgi-ip22/ip22-mc.c
> index d22262e..75ada8a 100644
> --- a/arch/mips/sgi-ip22/ip22-mc.c
> +++ b/arch/mips/sgi-ip22/ip22-mc.c
> @@ -139,11 +139,11 @@ void __init sgimc_init(void)
>  	 *         zero.
>  	 */
>  	/* don't touch parity settings for IP28 */
> -#ifndef CONFIG_SGI_IP28
>  	tmp = sgimc->cpuctrl0;
> -	tmp |= (SGIMC_CCTRL0_EPERRGIO | SGIMC_CCTRL0_EPERRMEM |
> -		SGIMC_CCTRL0_R4KNOCHKPARR);
> +#ifndef CONFIG_SGI_IP28
> +	tmp |= SGIMC_CCTRL0_EPERRGIO | SGIMC_CCTRL0_EPERRMEM;
>  #endif
> +	tmp |= SGIMC_CCTRL0_R4KNOCHKPARR;
>  	sgimc->cpuctrl0 = tmp;
>  
>  	/* Step 3: Setup the MC write buffer depth, this is controlled
> @@ -178,7 +178,8 @@ void __init sgimc_init(void)
>  	 */
>  
>  	/* First the basic invariants across all GIO64 implementations. */
> -	tmp = SGIMC_GIOPAR_HPC64;	/* All 1st HPC's interface at 64bits */
> +	tmp = sgimc->giopar & SGIMC_GIOPAR_GFX64; /* keep gfx 64bit settings */
> +	tmp |= SGIMC_GIOPAR_HPC64;	/* All 1st HPC's interface at 64bits */
>  	tmp |= SGIMC_GIOPAR_ONEBUS;	/* Only one physical GIO bus exists */
>  
>  	if (ip22_is_fullhouse()) {
> @@ -193,7 +194,6 @@ void __init sgimc_init(void)
>  			tmp |= SGIMC_GIOPAR_PLINEEXP0;	/* exp[01] pipelined */
>  			tmp |= SGIMC_GIOPAR_PLINEEXP1;
>  			tmp |= SGIMC_GIOPAR_MASTEREISA;	/* EISA masters */
> -			tmp |= SGIMC_GIOPAR_GFX64;	/* GFX at 64 bits */
>  		}
>  	} else {
>  		/* Guiness specific settings. */
> diff --git a/arch/mips/sgi-ip22/ip22-setup.c b/arch/mips/sgi-ip22/ip22-setup.c
> index 5e66213..c7bdfe4 100644
> --- a/arch/mips/sgi-ip22/ip22-setup.c
> +++ b/arch/mips/sgi-ip22/ip22-setup.c
> @@ -26,9 +26,6 @@
>  #include <asm/sgi/hpc3.h>
>  #include <asm/sgi/ip22.h>
>  
> -unsigned long sgi_gfxaddr;
> -EXPORT_SYMBOL_GPL(sgi_gfxaddr);
> -
>  extern void ip22_be_init(void) __init;
>  
>  void __init plat_mem_setup(void)
> @@ -78,22 +75,4 @@ void __init plat_mem_setup(void)
>  		prom_flags |= PROM_FLAG_USE_AS_CONSOLE;
>  		add_preferred_console("arc", 0, NULL);
>  	}
> -
> -#if defined(CONFIG_VT) && defined(CONFIG_SGI_NEWPORT_CONSOLE)
> -	{
> -		ULONG *gfxinfo;
> -		ULONG * (*__vec)(void) = (void *) (long)
> -			*((_PULONG *)(long)((PROMBLOCK)->pvector + 0x20));
> -
> -		gfxinfo = __vec();
> -		sgi_gfxaddr = ((gfxinfo[1] >= 0xa0000000
> -			       && gfxinfo[1] <= 0xc0000000)
> -			       ? gfxinfo[1] - 0xa0000000 : 0);
> -
> -		/* newport addresses? */
> -		if (sgi_gfxaddr = 0x1f0f0000 || sgi_gfxaddr = 0x1f4f0000) {
> -			conswitchp = &newport_con;
> -		}
> -	}
> -#endif
>  }
> diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
> index 93317b5..628b7ec 100644
> --- a/drivers/video/console/newport_con.c
> +++ b/drivers/video/console/newport_con.c
> @@ -25,14 +25,13 @@
>  #include <asm/system.h>
>  #include <asm/page.h>
>  #include <asm/pgtable.h>
> +#include <asm/gio_device.h>
> +
>  #include <video/newport.h>
>  
>  #include <linux/linux_logo.h>
>  #include <linux/font.h>
>  
> -
> -extern unsigned long sgi_gfxaddr;
> -
>  #define FONT_DATA ((unsigned char *)font_vga_8x16.data)
>  
>  /* borrowed from fbcon.c */
> @@ -304,12 +303,6 @@ static const char *newport_startup(void)
>  {
>  	int i;
>  
> -	if (!sgi_gfxaddr)
> -		return NULL;
> -
> -	if (!npregs)
> -		npregs = (struct newport_regs *)/* ioremap cannot fail */
> -			ioremap(sgi_gfxaddr, sizeof(struct newport_regs));
>  	npregs->cset.config = NPORT_CFG_GD0;
>  
>  	if (newport_wait(npregs))
> @@ -743,26 +736,56 @@ const struct consw newport_con = {
>  	.con_save_screen  = DUMMY
>  };
>  
> -#ifdef MODULE
> -static int __init newport_console_init(void)
> +static int newport_probe(struct gio_device *dev,
> +			 const struct gio_device_id *id)
>  {
> -	if (!sgi_gfxaddr)
> -		return 0;
> +	unsigned long newport_addr;
>  
> -	if (!npregs)
> -		npregs = (struct newport_regs *)/* ioremap cannot fail */
> -			ioremap(sgi_gfxaddr, sizeof(struct newport_regs));
> +	if (!dev->resource.start)
> +		return -EINVAL;
> +
> +	if (npregs)
> +		return -EBUSY; /* we only support one Newport as console */
> +
> +	newport_addr = dev->resource.start + 0xF0000;
> +	if (!request_mem_region(newport_addr, 0x10000, "Newport"))
> +		return -ENODEV;
> +
> +	npregs = (struct newport_regs *)/* ioremap cannot fail */
> +		ioremap(newport_addr, sizeof(struct newport_regs));
>  
>  	return take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
>  }
> -module_init(newport_console_init);
>  
> -static void __exit newport_console_exit(void)
> +static void newport_remove(struct gio_device *dev)
>  {
>  	give_up_console(&newport_con);
>  	iounmap((void *)npregs);
>  }
> +
> +static struct gio_device_id newport_ids[] = {
> +	{ .id = 0x7e },
> +	{ .id = 0xff }
> +};
> +
> +static struct gio_driver newport_driver = {
> +	.name = "newport",
> +	.id_table = newport_ids,
> +	.probe = newport_probe,
> +	.remove = newport_remove,
> +};
> +
> +int __init newport_console_init(void)
> +{
> +	return gio_register_driver(&newport_driver);
> +}
> +
> +void __exit newport_console_exit(void)
> +{
> +	gio_unregister_driver(&newport_driver);
> +}
> +
> +module_init(newport_console_init);
>  module_exit(newport_console_exit);
> -#endif
>  
>  MODULE_LICENSE("GPL");
> 

