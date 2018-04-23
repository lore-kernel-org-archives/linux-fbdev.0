From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 23 Apr 2018 12:19:31 +0000
Subject: Re: [PATCH v2 7/7] media: via-camera: allow build on non-x86 archs with COMPILE_TEST
Message-Id: <5323943.SkjzUNBk3k@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1524245455.git.mchehab@s-opensource.com>
        <396bfb33e763c31ead093ac1035b2ecf7311b5bc.1524245455.git.mchehab@s-opensource.com>
        <20180420160321.4ecefa00@vento.lan>
        <CGME20180423121932eucas1p212eb6412ff8df511047c3afa782db6e0@eucas1p2.samsung.com>
In-Reply-To: <20180420160321.4ecefa00@vento.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Hans Verkuil <hans.verkuil@cisco.com>, Arnd Bergmann <arnd@arndb.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, Jacob Chen <jacob-chen@iotwrt.com>, Bhumika Goyal <bhumirks@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-fbdev@vger.kernel.org


Hi Mauro,

On Friday, April 20, 2018 04:03:21 PM Mauro Carvalho Chehab wrote:
> This driver depends on FB_VIA for lots of things. Provide stubs
> for the functions it needs, in order to allow building it with
> COMPILE_TEST outside x86 architecture.

Please cc: me on fbdev related patches (patch adding new FB_VIA
ifdefs _is_ definitely fbdev related).

> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index e3229f7baed1..abaaed98a044 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -15,7 +15,7 @@ source "drivers/media/platform/marvell-ccic/Kconfig"
>  
>  config VIDEO_VIA_CAMERA
>  	tristate "VIAFB camera controller support"
> -	depends on FB_VIA
> +	depends on FB_VIA || COMPILE_TEST

This is incorrect (too simple), please take a look at FB_VIA entry:

config FB_VIA
       tristate "VIA UniChrome (Pro) and Chrome9 display support"
       depends on FB && PCI && X86 && GPIOLIB && I2C
       select FB_CFB_FILLRECT
       select FB_CFB_COPYAREA
       select FB_CFB_IMAGEBLIT
       select I2C_ALGOBIT
       help

Therefore you also need to check PCI, GPIOLIB && I2C dependencies.

* For PCI=n:

drivers/media/platform/via-camera.c: In function ‘viacam_serial_is_enabled’:
drivers/media/platform/via-camera.c:1286:9: error: implicit declaration of function ‘pci_find_bus’ [-Werror=implicit-function-declaration]
drivers/media/platform/via-camera.c:1286:25: warning: initialization makes pointer from integer without a cast [enabled by default]
drivers/media/platform/via-camera.c:1296:2: error: implicit declaration of function ‘pci_bus_read_config_byte’ [-Werror=implicit-function-declaration]
drivers/media/platform/via-camera.c:1308:2: error: implicit declaration of function ‘pci_bus_write_config_byte’ [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors
make[3]: *** [drivers/media/platform/via-camera.o] Error 1

* For I2C=n:

WARNING: unmet direct dependencies detected for VIDEO_OV7670
  Depends on [n]: MEDIA_SUPPORT [=y] && I2C [=n] && VIDEO_V4L2 [=y] && MEDIA_CAMERA_SUPPORT [=y]
  Selected by [y]:
  - VIDEO_VIA_CAMERA [=y] && MEDIA_SUPPORT [=y] && V4L_PLATFORM_DRIVERS [=y] && (FB_VIA [=n] || COMPILE_TEST [=y])

drivers/media/i2c/ov7670.c: In function ‘ov7670_read_smbus’:
drivers/media/i2c/ov7670.c:483:2: error: implicit declaration of function ‘i2c_smbus_read_byte_data’ [-Werror=implicit-function-declaration]
  ret = i2c_smbus_read_byte_data(client, reg);
  ^
drivers/media/i2c/ov7670.c: In function ‘ov7670_write_smbus’:
drivers/media/i2c/ov7670.c:496:2: error: implicit declaration of function ‘i2c_smbus_write_byte_data’ [-Werror=implicit-function-declaration]
  int ret = i2c_smbus_write_byte_data(client, reg, value);
  ^
drivers/media/i2c/ov7670.c: In function ‘ov7670_read_i2c’:
drivers/media/i2c/ov7670.c:521:2: error: implicit declaration of function ‘i2c_transfer’ [-Werror=implicit-function-declaration]
  ret = i2c_transfer(client->adapter, &msg, 1);
  ^
drivers/media/i2c/ov7670.c: In function ‘ov7670_probe’:
drivers/media/i2c/ov7670.c:1835:3: error: implicit declaration of function ‘i2c_adapter_id’ [-Werror=implicit-function-declaration]
   v4l_dbg(1, debug, client,
   ^
drivers/media/i2c/ov7670.c: At top level:
drivers/media/i2c/ov7670.c:1962:1: warning: data definition has no type or storage class [enabled by default]
 module_i2c_driver(ov7670_driver);
 ^
drivers/media/i2c/ov7670.c:1962:1: error: type defaults to ‘int’ in declaration of ‘module_i2c_driver’ [-Werror=implicit-int]
drivers/media/i2c/ov7670.c:1962:1: warning: parameter names (without types) in function declaration [enabled by default]
drivers/media/i2c/ov7670.c:1952:26: warning: ‘ov7670_driver’ defined but not used [-Wunused-variable]
 static struct i2c_driver ov7670_driver = {
                          ^
cc1: some warnings being treated as errors
make[3]: *** [drivers/media/i2c/ov7670.o] Error 1

* For GPIOLIB=n it builds fine.

>  	select VIDEOBUF_DMA_SG
>  	select VIDEO_OV7670
>  	help
> diff --git a/drivers/media/platform/via-camera.c b/drivers/media/platform/via-camera.c
> index e9a02639554b..4ab1695b33af 100644
> --- a/drivers/media/platform/via-camera.c
> +++ b/drivers/media/platform/via-camera.c
> @@ -27,7 +27,10 @@
>  #include <linux/via-core.h>
>  #include <linux/via-gpio.h>
>  #include <linux/via_i2c.h>
> +
> +#ifdef CONFIG_FB_VIA

This should be CONFIG_X86.

>  #include <asm/olpc.h>
> +#endif
>  
>  #include "via-camera.h"
>  
> @@ -1283,6 +1286,11 @@ static bool viacam_serial_is_enabled(void)
>  	struct pci_bus *pbus = pci_find_bus(0, 0);
>  	u8 cbyte;
>  
> +#ifdef CONFIG_FB_VIA

ditto

> +	if (!machine_is_olpc())
> +		return false;
> +#endif
> +
>  	if (!pbus)
>  		return false;
>  	pci_bus_read_config_byte(pbus, VIACAM_SERIAL_DEVFN,
> @@ -1343,7 +1351,7 @@ static int viacam_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	if (machine_is_olpc() && viacam_serial_is_enabled())
> +	if (viacam_serial_is_enabled())
>  		return -EBUSY;
>  
>  	/*
> diff --git a/include/linux/via-core.h b/include/linux/via-core.h
> index 9c21cdf3e3b3..ced4419baef8 100644
> --- a/include/linux/via-core.h
> +++ b/include/linux/via-core.h
> @@ -70,8 +70,12 @@ struct viafb_pm_hooks {
>  	void *private;
>  };
>  
> +#ifdef CONFIG_FB_VIA
>  void viafb_pm_register(struct viafb_pm_hooks *hooks);
>  void viafb_pm_unregister(struct viafb_pm_hooks *hooks);
> +#else
> +static inline void viafb_pm_register(struct viafb_pm_hooks *hooks) {}
> +#endif /* CONFIG_FB_VIA */
>  #endif /* CONFIG_PM */
>  
>  /*
> @@ -113,8 +117,13 @@ struct viafb_dev {
>   * Interrupt management.
>   */
>  
> +#ifdef CONFIG_FB_VIA
>  void viafb_irq_enable(u32 mask);
>  void viafb_irq_disable(u32 mask);
> +#else
> +static inline void viafb_irq_enable(u32 mask) {}
> +static inline void viafb_irq_disable(u32 mask) {}
> +#endif
>  
>  /*
>   * The global interrupt control register and its bits.
> @@ -157,10 +166,18 @@ void viafb_irq_disable(u32 mask);
>  /*
>   * DMA management.
>   */
> +#ifdef CONFIG_FB_VIA
>  int viafb_request_dma(void);
>  void viafb_release_dma(void);
>  /* void viafb_dma_copy_out(unsigned int offset, dma_addr_t paddr, int len); */
>  int viafb_dma_copy_out_sg(unsigned int offset, struct scatterlist *sg, int nsg);
> +#else
> +static inline int viafb_request_dma(void) { return 0; }
> +static inline void viafb_release_dma(void) {}
> +static inline int viafb_dma_copy_out_sg(unsigned int offset,
> +					struct scatterlist *sg, int nsg)
> +{ return 0; }
> +#endif
>  
>  /*
>   * DMA Controller registers.
> diff --git a/include/linux/via-gpio.h b/include/linux/via-gpio.h
> index 8281aea3dd6d..b5a96cf7a874 100644
> --- a/include/linux/via-gpio.h
> +++ b/include/linux/via-gpio.h
> @@ -8,7 +8,11 @@
>  #ifndef __VIA_GPIO_H__
>  #define __VIA_GPIO_H__
>  
> +#ifdef CONFIG_FB_VIA
>  extern int viafb_gpio_lookup(const char *name);
>  extern int viafb_gpio_init(void);
>  extern void viafb_gpio_exit(void);
> +#else
> +static inline int viafb_gpio_lookup(const char *name) { return 0; }
> +#endif
>  #endif
> diff --git a/include/linux/via_i2c.h b/include/linux/via_i2c.h
> index 44532e468c05..209bff950e22 100644
> --- a/include/linux/via_i2c.h
> +++ b/include/linux/via_i2c.h
> @@ -32,6 +32,7 @@ struct via_i2c_stuff {
>  };
>  
>  
> +#ifdef CONFIG_FB_VIA
>  int viafb_i2c_readbyte(u8 adap, u8 slave_addr, u8 index, u8 *pdata);
>  int viafb_i2c_writebyte(u8 adap, u8 slave_addr, u8 index, u8 data);
>  int viafb_i2c_readbytes(u8 adap, u8 slave_addr, u8 index, u8 *buff, int buff_len);
> @@ -39,4 +40,9 @@ struct i2c_adapter *viafb_find_i2c_adapter(enum viafb_i2c_adap which);
>  
>  extern int viafb_i2c_init(void);
>  extern void viafb_i2c_exit(void);
> +#else
> +static inline
> +struct i2c_adapter *viafb_find_i2c_adapter(enum viafb_i2c_adap which)
> +{ return NULL; }
> +#endif
>  #endif /* __VIA_I2C_H__ */

How's about just allowing COMPILE_TEST for FB_VIA instead of adding
all these stubs?


From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] video: fbdev: via: allow COMPILE_TEST build

This patch allows viafb driver to be build on !X86 archs
using COMPILE_TEST config option.

Since via-camera driver (VIDEO_VIA_CAMERA) depends on viafb
it also needs a little fixup.

Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/media/platform/via-camera.c |    5 +++++
 drivers/video/fbdev/Kconfig         |    2 +-
 drivers/video/fbdev/via/global.h    |    6 ++++++
 drivers/video/fbdev/via/hw.c        |    1 -
 drivers/video/fbdev/via/via-core.c  |    1 -
 drivers/video/fbdev/via/via_clock.c |    2 +-
 drivers/video/fbdev/via/viafbdev.c  |    1 -
 7 files changed, 13 insertions(+), 5 deletions(-)

Index: b/drivers/media/platform/via-camera.c
===================================================================
--- a/drivers/media/platform/via-camera.c	2018-04-23 13:46:37.000000000 +0200
+++ b/drivers/media/platform/via-camera.c	2018-04-23 14:01:07.873322815 +0200
@@ -27,7 +27,12 @@
 #include <linux/via-core.h>
 #include <linux/via-gpio.h>
 #include <linux/via_i2c.h>
+
+#ifdef CONFIG_X86
 #include <asm/olpc.h>
+#else
+#define machine_is_olpc(x) 0
+#endif
 
 #include "via-camera.h"
 
Index: b/drivers/video/fbdev/Kconfig
===================================================================
--- a/drivers/video/fbdev/Kconfig	2018-04-10 12:34:26.618867549 +0200
+++ b/drivers/video/fbdev/Kconfig	2018-04-23 13:55:41.389314593 +0200
@@ -1437,7 +1437,7 @@ config FB_SIS_315
 
 config FB_VIA
        tristate "VIA UniChrome (Pro) and Chrome9 display support"
-       depends on FB && PCI && X86 && GPIOLIB && I2C
+       depends on FB && PCI && GPIOLIB && I2C && (X86 || COMPILE_TEST)
        select FB_CFB_FILLRECT
        select FB_CFB_COPYAREA
        select FB_CFB_IMAGEBLIT
Index: b/drivers/video/fbdev/via/global.h
===================================================================
--- a/drivers/video/fbdev/via/global.h	2017-10-18 14:35:22.079448310 +0200
+++ b/drivers/video/fbdev/via/global.h	2018-04-23 13:52:57.121310456 +0200
@@ -33,6 +33,12 @@
 #include <linux/console.h>
 #include <linux/timer.h>
 
+#ifdef CONFIG_X86
+#include <asm/olpc.h>
+#else
+#define machine_is_olpc(x) 0
+#endif
+
 #include "debug.h"
 
 #include "viafbdev.h"
Index: b/drivers/video/fbdev/via/hw.c
===================================================================
--- a/drivers/video/fbdev/via/hw.c	2017-10-18 14:35:22.079448310 +0200
+++ b/drivers/video/fbdev/via/hw.c	2018-04-23 13:54:24.881312666 +0200
@@ -20,7 +20,6 @@
  */
 
 #include <linux/via-core.h>
-#include <asm/olpc.h>
 #include "global.h"
 #include "via_clock.h"
 
Index: b/drivers/video/fbdev/via/via-core.c
===================================================================
--- a/drivers/video/fbdev/via/via-core.c	2017-11-22 14:11:59.852728679 +0100
+++ b/drivers/video/fbdev/via/via-core.c	2018-04-23 13:53:24.893311156 +0200
@@ -17,7 +17,6 @@
 #include <linux/platform_device.h>
 #include <linux/list.h>
 #include <linux/pm.h>
-#include <asm/olpc.h>
 
 /*
  * The default port config.
Index: b/drivers/video/fbdev/via/via_clock.c
===================================================================
--- a/drivers/video/fbdev/via/via_clock.c	2017-10-18 14:35:22.083448309 +0200
+++ b/drivers/video/fbdev/via/via_clock.c	2018-04-23 13:53:45.389311672 +0200
@@ -25,7 +25,7 @@
 
 #include <linux/kernel.h>
 #include <linux/via-core.h>
-#include <asm/olpc.h>
+
 #include "via_clock.h"
 #include "global.h"
 #include "debug.h"
Index: b/drivers/video/fbdev/via/viafbdev.c
===================================================================
--- a/drivers/video/fbdev/via/viafbdev.c	2017-11-22 14:11:59.852728679 +0100
+++ b/drivers/video/fbdev/via/viafbdev.c	2018-04-23 13:53:55.325311922 +0200
@@ -25,7 +25,6 @@
 #include <linux/stat.h>
 #include <linux/via-core.h>
 #include <linux/via_i2c.h>
-#include <asm/olpc.h>
 
 #define _MASTER_FILE
 #include "global.h"


