From: Robert Whaley <rwhaley@applieddata.net>
Subject: Re: [Sm5xx-devel]  SM501 framebuffer driver
Date: Mon, 16 Oct 2006 15:40:02 -0400
Message-ID: <4533E012.4060909@applieddata.net>
References: <45268042.8050207@billgatliff.com> <452691A2.2020209@anagramm.de>
	<20061013121138.GA21744@linux-sh.org>
	<45327124.6040301@billgatliff.com>
	<20061016030154.GA6301@linux-sh.org>
	<4533DD5B.4020804@billgatliff.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060505080809010305060202"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZYJk-0008Di-LC for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Oct 2006 12:40:08 -0700
Received: from pop-canoe.atl.sa.earthlink.net ([207.69.195.66])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GZYJk-0005D0-8y
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Oct 2006 12:40:08 -0700
In-Reply-To: <4533DD5B.4020804@billgatliff.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Bill Gatliff <bgat@billgatliff.com>
Cc: sm5xx-devel@lists.berlios.de, Paul Mundt <lethal@linux-sh.org>, linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060505080809010305060202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bill Gatliff wrote:
> Paul:
> 
> Paul Mundt wrote:
> 
>> Hi Bill, fancy seeing you in this thread ;-)
>>  
>>
> 
> Heh, you need to talk to the guy at the door.  He'll let anyone in, I'm 
> proof!  :)
> 
>> We want the 8051 blob in userspace if anything, there's little reason to
>> tie this in to the module specifically, and it's handy to expose the
>> interface for people that are specifically interested in loading in
>> alternate code on the 8051.
>>
>> As far as including source for the 8051 code itself, that would be nice
>> to have, but I doubt it's something the majority of users are going to
>> care about. I've certainly never seen any.
>>  
>>
> 
> I totally agree on all points.  But I hate blobs.  If the source code is 
> around, I'd love to have it recorded somewhere even though we all know 
> that Kbuild and most users won't know what to do with it.  Just In Case.
> 
> Do we even know where this blob came from originally?
> 
>> On that note, do you have a pointer to some of the various ALSA
>> implementations that are floating around? I've only seen the OSS driver
>> we had in CVS, and that provides a rather dysmal starting point..
>>  
>>
> 
> Whaley sent me one just last week (hi Robert!).  Given that, I don't 
> suppose he'd mind my forwarding the patch on.

Not at all.  BTW: we use this (moderately buggy) compiler to 
compile the 8051 code:

http://sourceforge.net/project/showfiles.php?group_id=599

Between the bugs in the compiler and the absence of documentation 
in the SM501 manual about 8051 interrupts, etc.   It was pretty 
difficult making this work.

Don't try anything remotely like this with this compiler:

u8 a, b;
u32 c;

    c |= a << b;

That's why all the registers are u8 instead of u32.

>  What makes it tricky to 
> do so is that the patch is against his highly-evolved sm501 driver 
> stack, so there will be some mending required.
> 
> Yet another reason why we've all got to get all this stuff together.  
> The SM501 is a decent chip, and there's too few of us to go around 
> re-inventing the wheel.
> 
> 
> 
> b.g.
> 


-- 
Robert Whaley
Applied Data Systems            www.applieddata.net
434-244-9504		    rwhaley@applieddata.net

--------------060505080809010305060202
Content-Type: text/x-patch;
 name="sm501_8051_alsa.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sm501_8051_alsa.diff"

diff -urN linux-2.6.17.9.orig/arch/arm/common/sm501.c linux-2.6.17.9/arch/arm/common/sm501.c
--- linux-2.6.17.9.orig/arch/arm/common/sm501.c	2006-10-04 09:44:10.000000000 -0400
+++ linux-2.6.17.9/arch/arm/common/sm501.c	2006-10-04 10:42:52.000000000 -0400
@@ -137,7 +137,11 @@
 	DPRINTK(" %s: %p %#lx (%p %#lx)\n", __FUNCTION__,
 		virt, ((virt - sm501Mem) + sm501Phy), sm501Mem, sm501Phy);
 
-	return (virt - sm501Mem) + sm501Phy;
+	if ((sm501Reg > sm501Mem && virt >= sm501Reg) ||
+	    (sm501Reg <= sm501Mem && virt < sm501Mem))
+		return (virt - sm501Reg) + sm501PR;
+	else
+		return (virt - sm501Mem) + sm501Phy;
 }
 
 unsigned long sm501_phys_to_offset(unsigned long phys)
@@ -317,6 +321,13 @@
 
 	DPRINTK(" %s: size %d, virt %p, handle %x\n", __func__, size, virt, handle);
 
+	/* check for 8051 memory */
+	if ((sm501Reg > sm501Mem && virt >= sm501Reg) ||
+	    (sm501Reg <= sm501Mem && virt < sm501Mem)) {
+		/* if 8051 don't do anything! */
+		return;
+	}
+
 	list_for_each_entry(mem_lst, &sm501_mem_list_head, list) {
 		if (mem_lst->address == virt) {
 			sm501_free(virt);
diff -urN linux-2.6.17.9.orig/arch/arm/configs/adsportal_defconfig linux-2.6.17.9/arch/arm/configs/adsportal_defconfig
--- linux-2.6.17.9.orig/arch/arm/configs/adsportal_defconfig	2006-10-04 09:44:10.000000000 -0400
+++ linux-2.6.17.9/arch/arm/configs/adsportal_defconfig	2006-10-04 17:12:39.000000000 -0400
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.17.9-ep93xx-pxa-ads1
-# Fri Aug 25 10:37:34 2006
+# Linux kernel version: 2.6.17.9-ep93xx-pxa-ads2
+# Wed Oct  4 15:01:22 2006
 #
 CONFIG_ARM=y
 CONFIG_MMU=y
@@ -1109,7 +1109,7 @@
 #
 # Misc devices
 #
-CONFIG_IXP400=m
+# CONFIG_IXP400 is not set
 
 #
 # LED devices
@@ -1269,23 +1269,98 @@
 #
 # Advanced Linux Sound Architecture
 #
-# CONFIG_SND is not set
+CONFIG_SND=y
+CONFIG_SND_TIMER=y
+CONFIG_SND_PCM=y
+# CONFIG_SND_SEQUENCER is not set
+CONFIG_SND_OSSEMUL=y
+CONFIG_SND_MIXER_OSS=y
+CONFIG_SND_PCM_OSS=y
+CONFIG_SND_PCM_OSS_PLUGINS=y
+# CONFIG_SND_DYNAMIC_MINORS is not set
+# CONFIG_SND_SUPPORT_OLD_API is not set
+# CONFIG_SND_VERBOSE_PROCFS is not set
+# CONFIG_SND_VERBOSE_PRINTK is not set
+# CONFIG_SND_DEBUG is not set
+
+#
+# Generic devices
+#
+CONFIG_SND_AC97_CODEC=y
+CONFIG_SND_AC97_BUS=y
+# CONFIG_SND_DUMMY is not set
+# CONFIG_SND_MTPAV is not set
+# CONFIG_SND_SERIAL_U16550 is not set
+# CONFIG_SND_MPU401 is not set
+
+#
+# PCI devices
+#
+# CONFIG_SND_AD1889 is not set
+# CONFIG_SND_ALS300 is not set
+# CONFIG_SND_ALI5451 is not set
+# CONFIG_SND_ATIIXP is not set
+# CONFIG_SND_ATIIXP_MODEM is not set
+# CONFIG_SND_AU8810 is not set
+# CONFIG_SND_AU8820 is not set
+# CONFIG_SND_AU8830 is not set
+# CONFIG_SND_AZT3328 is not set
+# CONFIG_SND_BT87X is not set
+# CONFIG_SND_CA0106 is not set
+# CONFIG_SND_CMIPCI is not set
+# CONFIG_SND_CS4281 is not set
+# CONFIG_SND_CS46XX is not set
+# CONFIG_SND_EMU10K1 is not set
+# CONFIG_SND_EMU10K1X is not set
+# CONFIG_SND_ENS1370 is not set
+# CONFIG_SND_ENS1371 is not set
+# CONFIG_SND_ES1938 is not set
+# CONFIG_SND_ES1968 is not set
+# CONFIG_SND_FM801 is not set
+# CONFIG_SND_HDA_INTEL is not set
+# CONFIG_SND_HDSP is not set
+# CONFIG_SND_HDSPM is not set
+# CONFIG_SND_ICE1712 is not set
+# CONFIG_SND_ICE1724 is not set
+# CONFIG_SND_INTEL8X0 is not set
+# CONFIG_SND_INTEL8X0M is not set
+# CONFIG_SND_KORG1212 is not set
+# CONFIG_SND_MAESTRO3 is not set
+# CONFIG_SND_MIXART is not set
+# CONFIG_SND_NM256 is not set
+# CONFIG_SND_PCXHR is not set
+# CONFIG_SND_RIPTIDE is not set
+# CONFIG_SND_RME32 is not set
+# CONFIG_SND_RME96 is not set
+# CONFIG_SND_RME9652 is not set
+# CONFIG_SND_SONICVIBES is not set
+# CONFIG_SND_TRIDENT is not set
+# CONFIG_SND_VIA82XX is not set
+# CONFIG_SND_VIA82XX_MODEM is not set
+# CONFIG_SND_VX222 is not set
+# CONFIG_SND_YMFPCI is not set
+
+#
+# ALSA ARM devices
+#
+CONFIG_SND_SM501_PCM=y
+CONFIG_SND_SM501_AC97=y
+
+#
+# USB devices
+#
+# CONFIG_SND_USB_AUDIO is not set
+
+#
+# PCMCIA devices
+#
+# CONFIG_SND_VXPOCKET is not set
+# CONFIG_SND_PDAUDIOCF is not set
 
 #
 # Open Sound System
 #
-CONFIG_SOUND_PRIME=y
-# CONFIG_SOUND_BT878 is not set
-# CONFIG_SOUND_EMU10K1 is not set
-# CONFIG_SOUND_FUSION is not set
-# CONFIG_SOUND_ES1371 is not set
-# CONFIG_SOUND_ICH is not set
-# CONFIG_SOUND_TRIDENT is not set
-# CONFIG_SOUND_MSNDCLAS is not set
-# CONFIG_SOUND_MSNDPIN is not set
-# CONFIG_SOUND_VIA82CXXX is not set
-# CONFIG_SOUND_TVMIXER is not set
-CONFIG_SOUND_SM501_AC97=y
+# CONFIG_SOUND_PRIME is not set
 
 #
 # USB support
diff -urN linux-2.6.17.9.orig/include/asm-arm/hardware/sm501.h linux-2.6.17.9/include/asm-arm/hardware/sm501.h
--- linux-2.6.17.9.orig/include/asm-arm/hardware/sm501.h	2006-10-04 09:44:14.000000000 -0400
+++ linux-2.6.17.9/include/asm-arm/hardware/sm501.h	2006-10-04 10:42:52.000000000 -0400
@@ -2305,6 +2305,11 @@
 // CPU Protocol Interrupt
 #define UC8051_INT_CPU					0x0B000C
 
+#define UC8051_PRIVATE_SRAM                             0x0C0000
+#define UC8051_PRIVATE_SRAM_LEN                         0x003000
+#define UC8051_SHARED_SRAM                              0x0C3000
+#define UC8051_SHARED_SRAM_LEN                          0x001000
+
 ////////////////////////////////////////////////////////////////////////////////
 //                                                                            //
 // D I S P L A Y   C O N T R O L L E R                                        //
@@ -2479,6 +2484,7 @@
 	struct device	dev;
 	unsigned int	devid;
 	u64		dma_mask;
+	void		*private;
 };
 
 #define SM501_DEV(_d)	container_of((_d), struct sm501_dev, dev)
diff -urN linux-2.6.17.9.orig/sound/arm/Kconfig linux-2.6.17.9/sound/arm/Kconfig
--- linux-2.6.17.9.orig/sound/arm/Kconfig	2006-08-18 12:26:24.000000000 -0400
+++ linux-2.6.17.9/sound/arm/Kconfig	2006-10-04 10:42:52.000000000 -0400
@@ -33,4 +33,17 @@
 	  Say Y or M if you want to support any AC97 codec attached to
 	  the PXA2xx AC97 interface.
 
+config SND_SM501_PCM
+	tristate
+	select SND_PCM
+
+config SND_SM501_AC97
+	tristate "AC97 driver for the Silicon Motion SM501 chip"
+	depends on SND
+	select SND_SM501_PCM
+	select SND_AC97_CODEC
+	help
+	  Say Y or M if you want to support any AC97 codec attached to
+	  the SM501 AC97 interface.
+
 endmenu
diff -urN linux-2.6.17.9.orig/sound/arm/Makefile linux-2.6.17.9/sound/arm/Makefile
--- linux-2.6.17.9.orig/sound/arm/Makefile	2006-08-18 12:26:24.000000000 -0400
+++ linux-2.6.17.9/sound/arm/Makefile	2006-10-04 10:42:52.000000000 -0400
@@ -13,3 +13,9 @@
 
 obj-$(CONFIG_SND_PXA2XX_AC97)	+= snd-pxa2xx-ac97.o
 snd-pxa2xx-ac97-objs		:= pxa2xx-ac97.o
+
+obj-$(CONFIG_SND_SM501_PCM)	+= snd-sm501-pcm.o
+snd-sm501-pcm-objs		:= sm501-pcm.o
+
+obj-$(CONFIG_SND_SM501_AC97)	+= snd-sm501-ac97.o
+snd-sm501-ac97-objs		:= sm501-ac97.o
diff -urN linux-2.6.17.9.orig/sound/arm/sm501-ac97.c linux-2.6.17.9/sound/arm/sm501-ac97.c
--- linux-2.6.17.9.orig/sound/arm/sm501-ac97.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.17.9/sound/arm/sm501-ac97.c	2006-10-05 13:43:38.000000000 -0400
@@ -0,0 +1,674 @@
+/*
+ * linux/sound/sm501-ac97.c -- AC97 support for the SM501 chip.
+ *
+ * Author:	Robert Whaley, Applied Data Systems October 2nd, 2006
+ *
+ * based on linux/sound/pxa270-ac97.c 
+ * and sm501 oss drivers from Bill Gatliff and Jeff Lackey
+ *
+ * Author:      Nicolas Pitre
+ * Created:	Dec 02, 2004
+ * Copyright:	MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/wait.h>
+#include <linux/delay.h>
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/ac97_codec.h>
+#include <sound/initval.h>
+
+#include <asm/irq.h>
+#include <linux/mutex.h>
+#include <asm/hardware.h>
+#include <asm/hardware/sm501.h>
+
+#include "sm501-pcm.h"
+
+/* this has the microcode source and binary */
+#include "sm501_ac97_8051.c"
+
+static DEFINE_MUTEX(car_mutex);
+
+/* this shared data is written by the 8051 and read
+   by the CPU */
+typedef struct sm501_8051_shared_data {
+	u16 cpu_irq_count;
+	u16 ac97_irq_count;
+	u16 handled_irq_count;
+	u16 loop_count;
+	u16 read_reg;
+	u16 read_reg_value;
+	u16 write_reg;
+	u16 write_reg_value;
+	u16 tx_buffer_pointer;
+	u16 rx_buffer_pointer;
+} sm501_8051_shared_data_t;
+
+static sm501_8051_shared_data_t *sm501_8051_shared;
+
+/* outgoing interrupt word format
+
+   bits   
+    0:2    tag
+      3    rx=1, tx=0
+      4    on=1, off=0
+    5:7    counter
+    8:15   register
+   16:32   value
+*/
+
+#define SM501_8051_IRQ_TAG_READ   1
+#define SM501_8051_IRQ_TAG_WRITE  2
+#define SM501_8051_IRQ_TAG_PCM    3
+#define SM501_8051_IRQ_TAG_BUFSZ  4
+#define SM501_8051_IRQ_TAG_PERSZ  5
+
+#define SM501_8051_IRQ_TAG_MSK    0x00000007
+#define SM501_8051_IRQ_RX_TX_MSK  0x00000008
+#define SM501_8051_IRQ_ON_OFF_MSK 0x00000010
+#define SM501_8051_IRQ_COUNT_MSK  0x000000e0
+#define SM501_8051_IRQ_REG_MSK    0x00007f00
+#define SM501_8051_IRQ_VAL_MSK    0xffff0000
+
+#define SM501_8051_IRQ_TAG_SHF     0
+#define SM501_8051_IRQ_RX_TX_SHF   3
+#define SM501_8051_IRQ_ON_OFF_SHF  4
+#define SM501_8051_IRQ_COUNT_SHF   5
+#define SM501_8051_IRQ_REG_SHF     8
+#define SM501_8051_IRQ_VAL_SHF    16
+
+#define SM501_8051_IRQ_RX         0x1
+#define SM501_8051_IRQ_TX         0x0
+
+#define SM501_8051_IRQ_ON         0x1
+#define SM501_8051_IRQ_OFF        0x0
+
+static void sm501_ac97_power(int on)
+{
+	u32 power_mode_ctl = sm501_regRead32(POWER_MODE_CTRL);
+	u32 power_mode;
+
+	if (FIELD_GET(power_mode_ctl, POWER_MODE_CTRL, MODE) == POWER_MODE_CTRL_MODE_MODE0) {
+		power_mode = sm501_regRead32(POWER_MODE0_GATE);
+		power_mode = on ? FIELD_SET(power_mode, POWER_MODE0_GATE, AC97_I2S, ENABLE) :
+				  FIELD_SET(power_mode, POWER_MODE0_GATE, AC97_I2S, DISABLE);
+		power_mode = on ? FIELD_SET(power_mode, POWER_MODE0_GATE, 8051, ENABLE) :
+				  FIELD_SET(power_mode, POWER_MODE0_GATE, 8051, DISABLE);
+		sm501_regWrite32(POWER_MODE0_GATE, power_mode);
+	}
+	else {
+		power_mode = sm501_regRead32(POWER_MODE1_GATE);
+		power_mode = on ? FIELD_SET(power_mode, POWER_MODE1_GATE, AC97_I2S, ENABLE) :
+				  FIELD_SET(power_mode, POWER_MODE1_GATE, AC97_I2S, DISABLE);
+		power_mode = on ? FIELD_SET(power_mode, POWER_MODE1_GATE, 8051, ENABLE) :
+				  FIELD_SET(power_mode, POWER_MODE1_GATE, 8051, DISABLE);
+		sm501_regWrite32(POWER_MODE1_GATE, power_mode);
+	}
+	mdelay(16);
+}
+
+static void sm501_ac97_enable (void)
+{
+	u32 val;
+	int i;
+	u8 *program_addr;
+
+	// do this first
+	sm501_ac97_power(1);
+
+	val = sm501_regRead32(AC97_CTRL);
+//	val = FIELD_SET(val, AC97_CTRL, SYNC, ENABLE);
+	val = FIELD_SET(val, AC97_CTRL, MASTER, ENABLE);
+	sm501_regWrite32(AC97_CTRL, val);
+
+	program_addr = sm501_get_reg() + UC8051_PRIVATE_SRAM;
+
+	if (sizeof(sm501_ac97_8051_uc) > UC8051_PRIVATE_SRAM_LEN) {
+		printk(KERN_ERR "8051 microcode is to large %d > %d\n",
+		       sizeof(sm501_ac97_8051_uc), UC8051_PRIVATE_SRAM_LEN);
+		return;
+	}
+
+	/* keep 8051 in reset mode while loading it's program */
+	sm501_regWrite32(UC8051_RESET, 0);
+
+	for (i=0; i<sizeof(sm501_ac97_8051_uc); i++) {
+		*(program_addr++) = sm501_ac97_8051_uc[i];
+	}
+
+	sm501_8051_shared = (sm501_8051_shared_data_t *) (sm501_get_reg() + UC8051_SHARED_SRAM);
+}
+
+static void sm501_ac97_disable (void)
+{
+	u32 val;
+
+	sm501_regWrite32(UC8051_RESET, 0);
+
+	val = sm501_regRead32(AC97_CTRL);
+	val = FIELD_SET(val, AC97_CTRL, MASTER, DISABLE);
+	sm501_regWrite32(AC97_CTRL, val);
+
+	sm501_ac97_power(0);
+}
+
+static int sm501_ac97_cold_reset(void)
+{
+	u32 val;
+	int rtn = 0;
+
+	val = sm501_regRead32(AC97_CTRL) & 0xffff;
+	val = FIELD_SET(val, AC97_CTRL, MASTER, ENABLE);
+	val = FIELD_SET(val, AC97_CTRL, COLD, RESET);
+	sm501_regWrite32(AC97_CTRL, val);
+
+	mdelay(10);
+
+	val = sm501_regRead32(AC97_CTRL) & 0xffff;
+	if (FIELD_GET(val, AC97_CTRL, STATUS) == AC97_CTRL_STATUS_OFF)
+		rtn = -ENODEV;
+	else if (FIELD_GET(val, AC97_CTRL, STATUS) != AC97_CTRL_STATUS_RESET)
+		rtn = -EBUSY;
+
+	val = FIELD_SET(val, AC97_CTRL, COLD, CLRRESET);
+	sm501_regWrite32(AC97_CTRL, val);
+
+	mdelay(10);
+
+	val = sm501_regRead32(AC97_CTRL) & 0xffff;
+	if (!rtn && FIELD_GET(val, AC97_CTRL, STATUS) == AC97_CTRL_STATUS_RESET)
+		rtn = -EAGAIN;
+
+	val = sm501_regRead32(AC97_RX_S0_TAG);
+	if (!FIELD_GET(val, AC97_RX_S0_TAG, FRAME)) {
+		printk(KERN_ERR "sm501-ac97: codec not ready after cold reset\n");
+		rtn = -ENODEV;
+	}
+	else if (rtn)
+		printk(KERN_WARNING "sm501-ac97: cold reset err %d\n", rtn);
+
+	return rtn;
+}
+
+static int sm501_ac97_warm_reset(void)
+{
+	u32 val;
+	int rtn = 0;
+
+	val = sm501_regRead32(AC97_CTRL) & 0xffff;
+	val = FIELD_SET(val, AC97_CTRL, WARM, RESET);
+	sm501_regWrite32(AC97_CTRL, val);
+
+	mdelay(10);
+
+	val = sm501_regRead32(AC97_CTRL) & 0xffff;
+	if (FIELD_GET(val, AC97_CTRL, STATUS) == AC97_CTRL_STATUS_OFF)
+		rtn = -ENODEV;
+	else if (FIELD_GET(val, AC97_CTRL, STATUS) != AC97_CTRL_STATUS_RESET)
+		rtn = -EBUSY;
+
+	val = FIELD_SET(val, AC97_CTRL, WARM, CLRRESET);
+	sm501_regWrite32(AC97_CTRL, val);
+
+	mdelay(10);
+
+	val = sm501_regRead32(AC97_CTRL) & 0xffff;
+	if (!rtn && FIELD_GET(val, AC97_CTRL, STATUS) == AC97_CTRL_STATUS_RESET)
+		rtn = -EAGAIN;
+
+	val = sm501_regRead32(AC97_RX_S0_TAG);
+	if (!FIELD_GET(val, AC97_RX_S0_TAG, FRAME)) {
+		printk(KERN_ERR "sm501-ac97: codec not ready after warm reset %#x\n", val);
+		rtn = -ENODEV;
+	}
+	else if (rtn)
+		printk(KERN_WARNING "sm501-ac97: warm reset err %d\n", rtn);
+
+	return rtn;
+}
+
+static void sm501_ac97_init_hw(void)
+{
+	u32 val;
+
+	sm501_regWrite32(UC8051_RESET, 0);
+
+	// I2S and AC97 are mutually exclusive
+	val = sm501_regRead32(I2S_CTRL);
+	val = FIELD_SET(val, I2S_CTRL, I2S, DISABLE);
+	sm501_regWrite32(I2S_CTRL, val);
+
+	val = sm501_regRead32(INT_MASK);
+	val = FIELD_SET(val, INT_MASK, I2S, DISABLE);
+	val = FIELD_SET(val, INT_MASK, AC97, DISABLE);
+	val = FIELD_SET(val, INT_MASK, 8051, DISABLE);
+	sm501_regWrite32(INT_MASK, val);
+
+	// AC97 pins are multiplexed with GPIOs
+	val = sm501_regRead32(GPIO_MUX_LOW);
+	val = FIELD_SET(val, GPIO_MUX_LOW, 28, AC97_I2S);
+	val = FIELD_SET(val, GPIO_MUX_LOW, 27, AC97_I2S);
+	val = FIELD_SET(val, GPIO_MUX_LOW, 26, AC97_I2S);
+	val = FIELD_SET(val, GPIO_MUX_LOW, 25, AC97_I2S);
+	val = FIELD_SET(val, GPIO_MUX_LOW, 24, AC97);
+	sm501_regWrite32(GPIO_MUX_LOW, val);
+
+	sm501_ac97_enable();
+}
+
+static unsigned int sm501_8051_irq_count = SM501_8051_IRQ_COUNT_MSK;
+
+void sm501_send_8051_irq(unsigned int val)
+{
+
+	val |= sm501_8051_irq_count;
+	sm501_regWrite32(UC8051_INT_CPU, val);
+
+	sm501_8051_irq_count += (1 << SM501_8051_IRQ_COUNT_SHF);
+	sm501_8051_irq_count &= SM501_8051_IRQ_COUNT_MSK;
+}
+
+static unsigned short sm501_ac97_read(ac97_t *ac97, unsigned short reg)
+{
+	unsigned short val = -1;
+	unsigned short read_reg;
+	unsigned int tries = 10;
+	unsigned short handled_irq_count;
+
+	mutex_lock(&car_mutex);
+
+	handled_irq_count = sm501_8051_shared[0].handled_irq_count;
+
+	do {
+		sm501_send_8051_irq(
+			((SM501_8051_IRQ_TAG_READ << SM501_8051_IRQ_TAG_SHF) & SM501_8051_IRQ_TAG_MSK) |
+			((reg                     << SM501_8051_IRQ_REG_SHF) & SM501_8051_IRQ_REG_MSK));
+
+		mdelay(1);
+
+	/* make sure the data is consistent */
+	} while (--tries &&
+	       ((reg != sm501_8051_shared[0].read_reg) ||
+		(sm501_8051_shared[0].read_reg != sm501_8051_shared[1].read_reg) ||
+		(sm501_8051_shared[0].read_reg_value != sm501_8051_shared[1].read_reg_value)));
+
+	read_reg = sm501_8051_shared[0].read_reg;
+	val = sm501_8051_shared[0].read_reg_value;
+
+	if ((read_reg != reg) || !tries) {
+		printk(KERN_ERR "%s: read error (ac97_reg=%#x %d)\n", __FUNCTION__, reg, tries);
+		val = -1;
+	}
+
+	if (handled_irq_count + 1 != sm501_8051_shared[0].handled_irq_count) {
+		printk(KERN_WARNING "%s: irq count %d expected %d\n",
+		       __FUNCTION__,
+		       sm501_8051_shared[0].handled_irq_count,
+		       handled_irq_count + 1);
+	}
+
+	mdelay(1);
+
+	mutex_unlock(&car_mutex);
+
+	return val;
+}
+
+static void sm501_ac97_write(ac97_t *ac97, unsigned short reg, unsigned short val)
+{
+	unsigned short write_reg;
+	unsigned short write_val;
+	unsigned int tries = 10;
+
+	unsigned short handled_irq_count;
+
+	mutex_lock(&car_mutex);
+
+	handled_irq_count = sm501_8051_shared[0].handled_irq_count;
+
+	do {
+		sm501_send_8051_irq(
+			((SM501_8051_IRQ_TAG_WRITE << SM501_8051_IRQ_TAG_SHF) & SM501_8051_IRQ_TAG_MSK) |
+			((val                      << SM501_8051_IRQ_VAL_SHF) & SM501_8051_IRQ_VAL_MSK) |
+			((reg                      << SM501_8051_IRQ_REG_SHF) & SM501_8051_IRQ_REG_MSK));
+      
+		mdelay(1);
+
+	/* make sure the data is consistent */
+	} while (--tries &&
+	       ((reg != sm501_8051_shared[0].write_reg) ||
+		(sm501_8051_shared[0].write_reg != sm501_8051_shared[1].write_reg) ||
+		(sm501_8051_shared[0].write_reg_value != sm501_8051_shared[1].write_reg_value)));
+
+	write_reg = sm501_8051_shared[0].write_reg;
+	write_val = sm501_8051_shared[0].write_reg_value;
+
+	if ((write_reg != reg) || (write_val != val) || !tries) {
+		printk(KERN_ERR "%s: write error (ac97_reg=%#x %#x %d)\n",
+				__FUNCTION__, reg, val, tries);
+		goto out;
+	}
+
+	if (handled_irq_count + 1 != sm501_8051_shared[0].handled_irq_count) {
+		printk(KERN_WARNING "%s: irq count %d expected %d\n",
+		       __FUNCTION__,
+		       sm501_8051_shared[0].handled_irq_count,
+		       handled_irq_count + 1);
+	}
+	mdelay(2);
+
+ out:
+	mutex_unlock(&car_mutex);
+
+}
+
+static void sm501_ac97_pcm_set_period_sz(struct snd_pcm_substream *substream, int period)
+{
+	/* change from bytes to frames */
+	period = period / 4;
+
+	mutex_lock(&car_mutex);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+
+		sm501_send_8051_irq(
+			((SM501_8051_IRQ_TAG_PERSZ << SM501_8051_IRQ_TAG_SHF)   & SM501_8051_IRQ_TAG_MSK) |
+			((SM501_8051_IRQ_TX        << SM501_8051_IRQ_RX_TX_SHF) & SM501_8051_IRQ_RX_TX_MSK) |
+			((period                   << SM501_8051_IRQ_VAL_SHF)   & SM501_8051_IRQ_VAL_MSK));
+	}
+	else {
+		sm501_send_8051_irq(
+			((SM501_8051_IRQ_TAG_PERSZ << SM501_8051_IRQ_TAG_SHF)   & SM501_8051_IRQ_TAG_MSK) |
+			((SM501_8051_IRQ_RX        << SM501_8051_IRQ_RX_TX_SHF) & SM501_8051_IRQ_RX_TX_MSK) |
+			((period                   << SM501_8051_IRQ_VAL_SHF)   & SM501_8051_IRQ_VAL_MSK));
+	}
+
+	mdelay(1);
+	mutex_unlock(&car_mutex);
+}
+
+static void sm501_ac97_pcm_set_buffer_sz(struct snd_pcm_substream *substream, int buffer_sz)
+{
+	mutex_lock(&car_mutex);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+
+		sm501_send_8051_irq(
+			((SM501_8051_IRQ_TAG_BUFSZ << SM501_8051_IRQ_TAG_SHF)   & SM501_8051_IRQ_TAG_MSK) |
+			((SM501_8051_IRQ_TX        << SM501_8051_IRQ_RX_TX_SHF) & SM501_8051_IRQ_RX_TX_MSK) |
+			((buffer_sz                << SM501_8051_IRQ_VAL_SHF)   & SM501_8051_IRQ_VAL_MSK));
+	}
+	else {
+		sm501_send_8051_irq(
+			((SM501_8051_IRQ_TAG_BUFSZ << SM501_8051_IRQ_TAG_SHF)   & SM501_8051_IRQ_TAG_MSK) |
+			((SM501_8051_IRQ_RX        << SM501_8051_IRQ_RX_TX_SHF) & SM501_8051_IRQ_RX_TX_MSK) |
+			((buffer_sz                << SM501_8051_IRQ_VAL_SHF)   & SM501_8051_IRQ_VAL_MSK));
+	}
+	mdelay(1);
+	mutex_unlock(&car_mutex);
+}
+
+static void sm501_ac97_reset(ac97_t *ac97)
+{
+	u32 val;
+
+	sm501_regWrite32(UC8051_RESET, 0);
+
+	if (sm501_ac97_cold_reset() < 0) {
+		printk(KERN_WARNING "sm501_ac97_cold_reset failed, trying warm reset.\n");
+	 	if ((sm501_ac97_warm_reset()) < 0) {
+			printk(KERN_WARNING "sm501_ac97_warm_reset failed too.\n");
+			return;
+		}
+	}
+
+	val = sm501_regRead32(AC97_CTRL);
+	val = FIELD_SET(val, AC97_CTRL, SYNC, ENABLE);
+	sm501_regWrite32(AC97_CTRL, val);
+
+	/* After this can no longer do stuff with the AC97 the CPU, only from the UC8051 */
+	sm501_regWrite32(UC8051_RESET, 1);
+}
+
+static struct snd_ac97_bus_ops sm501_ac97_ops = {
+	.read	= sm501_ac97_read,
+	.write	= sm501_ac97_write,
+	.reset	= sm501_ac97_reset,
+};
+
+static struct snd_ac97 *sm501_ac97_ac97;
+
+static void sm501_ac97_pcm_start(struct snd_pcm_substream *substream)
+{
+	mutex_lock(&car_mutex);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		sm501_send_8051_irq(
+			((SM501_8051_IRQ_TAG_PCM << SM501_8051_IRQ_TAG_SHF)    & SM501_8051_IRQ_TAG_MSK) |
+			((SM501_8051_IRQ_TX      << SM501_8051_IRQ_RX_TX_SHF)  & SM501_8051_IRQ_RX_TX_MSK) |
+			((SM501_8051_IRQ_ON      << SM501_8051_IRQ_ON_OFF_SHF) & SM501_8051_IRQ_ON_OFF_MSK));
+	}
+	else {
+		sm501_send_8051_irq(
+			((SM501_8051_IRQ_TAG_PCM << SM501_8051_IRQ_TAG_SHF)    & SM501_8051_IRQ_TAG_MSK) |
+			((SM501_8051_IRQ_RX      << SM501_8051_IRQ_RX_TX_SHF)  & SM501_8051_IRQ_RX_TX_MSK) |
+			((SM501_8051_IRQ_ON      << SM501_8051_IRQ_ON_OFF_SHF) & SM501_8051_IRQ_ON_OFF_MSK));
+	}
+	mdelay(1);
+	mutex_unlock(&car_mutex);
+}
+
+static void sm501_ac97_pcm_stop(struct snd_pcm_substream *substream)
+{
+	mutex_lock(&car_mutex);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		sm501_send_8051_irq(
+			((SM501_8051_IRQ_TAG_PCM << SM501_8051_IRQ_TAG_SHF)    & SM501_8051_IRQ_TAG_MSK) |
+			((SM501_8051_IRQ_TX      << SM501_8051_IRQ_RX_TX_SHF)  & SM501_8051_IRQ_RX_TX_MSK) |
+			((SM501_8051_IRQ_OFF     << SM501_8051_IRQ_ON_OFF_SHF) & SM501_8051_IRQ_ON_OFF_MSK));
+	}
+	else {
+		sm501_send_8051_irq(
+			((SM501_8051_IRQ_TAG_PCM << SM501_8051_IRQ_TAG_SHF)    & SM501_8051_IRQ_TAG_MSK) |
+			((SM501_8051_IRQ_RX      << SM501_8051_IRQ_RX_TX_SHF)  & SM501_8051_IRQ_RX_TX_MSK) |
+			((SM501_8051_IRQ_OFF     << SM501_8051_IRQ_ON_OFF_SHF) & SM501_8051_IRQ_ON_OFF_MSK));
+	}
+	mdelay(1);
+	mutex_unlock(&car_mutex);
+}
+
+static int sm501_ac97_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int reg;
+	int ret;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		reg = AC97_PCM_FRONT_DAC_RATE;
+	}
+	else {
+		reg = AC97_PCM_LR_ADC_RATE;
+	}
+
+	ret = snd_ac97_set_rate(sm501_ac97_ac97, reg, runtime->rate);
+
+	return ret;
+}
+
+static snd_pcm_uframes_t sm501_ac97_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int tries = 10;
+
+	snd_pcm_uframes_t x;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+
+		while (--tries &&
+		       ((x = sm501_8051_shared[0].tx_buffer_pointer) != sm501_8051_shared[1].tx_buffer_pointer)) udelay(1);
+
+		if (!tries) {
+			printk(KERN_WARNING "sm501_ac97_pcm_pointer tx buffer cannot determine pointer\n");
+			return 0;
+		}
+
+		if (x >= 2048) x = 0;
+	}
+	else {
+		while (--tries &&
+		       ((x = sm501_8051_shared[0].rx_buffer_pointer) != sm501_8051_shared[1].rx_buffer_pointer)) udelay(1);
+
+		if (!tries) {
+			printk(KERN_WARNING "sm501_ac97_pcm_pointer rx buffer cannot determine pointer\n");
+			return 0;
+		}
+
+		if (x >= 1024) x = 0;
+	}
+
+
+	/* x should be in frames */
+	x = bytes_to_frames(runtime, x);
+
+	return x;
+}
+
+
+static struct sm501_pcm_client sm501_ac97_pcm_client = {
+	.prepare		= sm501_ac97_pcm_prepare,
+	.pointer                = sm501_ac97_pcm_pointer,
+	.start_pcm              = sm501_ac97_pcm_start,
+	.stop_pcm               = sm501_ac97_pcm_stop,
+	.set_period_sz          = sm501_ac97_pcm_set_period_sz,
+	.set_buffer_sz          = sm501_ac97_pcm_set_buffer_sz,
+};
+
+
+static int sm501_ac97_probe(struct sm501_dev *dev)
+{
+	struct snd_pcm *pcm;
+	struct snd_card *card;
+	struct snd_ac97_bus *ac97_bus;
+	struct snd_ac97_template ac97_template;
+	int ret;
+
+	ret = -ENOMEM;
+	card = snd_card_new(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
+			    THIS_MODULE, 0);
+	if (!card)
+		goto err;
+
+	sm501_ac97_init_hw();
+
+	card->dev = &dev->dev;
+	strncpy(card->driver, dev->dev.driver->name, sizeof(card->driver));
+
+	ret = sm501_pcm_new(card, &sm501_ac97_pcm_client, &pcm);
+	if (ret)
+		goto err;
+
+	dev->private = pcm;
+
+	ret = snd_ac97_bus(card, 0, &sm501_ac97_ops, NULL, &ac97_bus);
+	if (ret)
+		goto err;
+
+	memset(&ac97_template, 0, sizeof(ac97_template));
+	ret = snd_ac97_mixer(ac97_bus, &ac97_template, &sm501_ac97_ac97);
+	if (ret)
+		goto err;
+
+	snprintf(card->shortname, sizeof(card->shortname),
+		 "%s", snd_ac97_get_short_name(sm501_ac97_ac97));
+	snprintf(card->longname, sizeof(card->longname),
+		 "%s (%s)", dev->dev.driver->name, card->mixername);
+
+	ret = snd_card_register(card);
+	if (ret == 0) {
+		platform_set_drvdata(dev, card);
+		return 0;
+	}
+
+ err:
+	printk(KERN_ERR "sm501_ac97_probe failed (%d)\n", ret);
+	if (card) {
+		snd_card_free(card);
+		sm501_ac97_disable();
+	}
+	return ret;
+}
+
+static int sm501_ac97_remove(struct sm501_dev *dev)
+{
+	struct snd_card *card = platform_get_drvdata(dev);
+
+	if (card) {
+		snd_card_free(card);
+		platform_set_drvdata(dev, NULL);
+
+		/* stop the 8051 PCM activity */
+
+		mutex_lock(&car_mutex);
+		sm501_send_8051_irq(
+			((SM501_8051_IRQ_TAG_PCM << SM501_8051_IRQ_TAG_SHF)    & SM501_8051_IRQ_TAG_MSK) |
+			((SM501_8051_IRQ_TX      << SM501_8051_IRQ_RX_TX_SHF)  & SM501_8051_IRQ_RX_TX_MSK) |
+			((SM501_8051_IRQ_OFF     << SM501_8051_IRQ_ON_OFF_SHF) & SM501_8051_IRQ_ON_OFF_MSK));
+
+		mdelay(1);
+
+		sm501_send_8051_irq(
+			((SM501_8051_IRQ_TAG_PCM << SM501_8051_IRQ_TAG_SHF)    & SM501_8051_IRQ_TAG_MSK) |
+			((SM501_8051_IRQ_RX      << SM501_8051_IRQ_RX_TX_SHF)  & SM501_8051_IRQ_RX_TX_MSK) |
+			((SM501_8051_IRQ_OFF     << SM501_8051_IRQ_ON_OFF_SHF) & SM501_8051_IRQ_ON_OFF_MSK));
+
+		mdelay(1);
+		mutex_unlock(&car_mutex);
+
+		free_irq(SM501_8051, dev->private);
+
+		sm501_ac97_disable();
+	}
+
+	return 0;
+}
+
+static struct sm501_driver sm501_ac97_driver = {
+	.drv = {
+		.name	= "sm501-ac97",
+		.bus	= &sm501_bus_type,
+	},
+	.devid		= SM501_DEVID_AC97,
+	.probe		= sm501_ac97_probe,
+	.remove		= sm501_ac97_remove,
+ };
+
+
+static int __devinit sm501_ac97_init(void)
+{
+	return sm501_driver_register(&sm501_ac97_driver);
+	return 0;
+}
+
+static void __exit sm501_ac97_exit(void)
+{
+	sm501_driver_unregister(&sm501_ac97_driver);
+}
+
+module_init(sm501_ac97_init);
+module_exit(sm501_ac97_exit);
+
+MODULE_AUTHOR("Nicolas Pitre");
+MODULE_DESCRIPTION("AC97 driver for the SM501 chip");
+MODULE_LICENSE("GPL");
diff -urN linux-2.6.17.9.orig/sound/arm/sm501-pcm.c linux-2.6.17.9/sound/arm/sm501-pcm.c
--- linux-2.6.17.9.orig/sound/arm/sm501-pcm.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.17.9/sound/arm/sm501-pcm.c	2006-10-04 10:42:52.000000000 -0400
@@ -0,0 +1,259 @@
+/*
+ * linux/sound/arm/sm501-pcm.c -- ALSA PCM interface for the SM501 chip
+ *
+ * Author:	Robert Whaley, Applied Data Systems October 2nd, 2006
+ *
+ * based on linux/sound/pxa270-ac97.c 
+ *
+ * Author:	Nicolas Pitre
+ * Created:	Nov 30, 2004
+ * Copyright:	(C) 2004 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+
+#include <asm/irq.h>
+#include <asm/hardware.h>
+#include <asm/hardware/sm501.h>
+
+#include "sm501-pcm.h"
+
+
+static const struct snd_pcm_hardware sm501_pcm_hardware_tx = {
+	.info			= SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_INTERLEAVED |
+				  SNDRV_PCM_INFO_PAUSE,
+	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
+	.rates			= (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
+				   SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |\
+				   SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |\
+				   SNDRV_PCM_RATE_KNOT),
+	.rate_min		= 8000,
+	.rate_max		= 48000,
+	.channels_min		= 2,
+	.channels_max		= 2,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= TX_BUF_SIZE,
+	.periods_min		= 1,
+	.periods_max		= 64,
+	.buffer_bytes_max	= TX_BUF_SIZE,
+	.fifo_size		= 0,
+};
+
+static const struct snd_pcm_hardware sm501_pcm_hardware_rx = {
+	.info			= SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_INTERLEAVED |
+				  SNDRV_PCM_INFO_PAUSE,
+	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
+	.rates			= (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
+				   SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |\
+				   SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |\
+				   SNDRV_PCM_RATE_KNOT),
+	.rate_min		= 8000,
+	.rate_max		= 48000,
+	.channels_min		= 2,
+	.channels_max		= 2,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= RX_BUF_SIZE,
+	.periods_min		= 1,
+	.periods_max		= 32,
+	.buffer_bytes_max	= RX_BUF_SIZE,
+	.fifo_size		= 0,
+};
+
+static int sm501_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	size_t totsize = params_buffer_bytes(params);
+	struct sm501_pcm_client *client = substream->private_data;
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+	runtime->dma_bytes = totsize;
+
+	client->set_buffer_sz(substream, totsize);
+	client->set_period_sz(substream, params_period_bytes(params));
+
+	return 0;
+}
+
+static int sm501_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	snd_pcm_set_runtime_buffer(substream, NULL);
+
+	return 0;
+}
+
+static int sm501_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct sm501_pcm_client *client = substream->private_data;
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		client->start_pcm(substream);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		client->stop_pcm(substream);
+		break;
+
+	default:
+		printk(KERN_WARNING "%s: unknown cmd: %#x\n", __FUNCTION__, cmd);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int sm501_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		runtime->hw = sm501_pcm_hardware_tx;
+	else
+		runtime->hw = sm501_pcm_hardware_rx;
+
+	return 0;
+}
+
+static int sm501_pcm_close(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static int
+sm501_pcm_mmap(struct snd_pcm_substream *substream, struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
+				     runtime->dma_area,
+				     runtime->dma_addr,
+				     runtime->dma_bytes);
+}
+
+static struct snd_pcm_ops sm501_pcm_ops = {
+	.open		= sm501_pcm_open,
+	.close		= sm501_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= sm501_pcm_hw_params,
+	.hw_free	= sm501_pcm_hw_free,
+	.prepare	= NULL, /* get prepare function from sm501-ac97.c */
+	.trigger	= sm501_pcm_trigger,
+	.pointer	= NULL, /* get pointer function from sm501-ac97.c */
+	.mmap		= sm501_pcm_mmap,
+};
+
+static irqreturn_t sm501_pcm_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct snd_pcm *pcm = dev_id;
+	struct snd_pcm_str *stream;
+	struct snd_pcm_substream *substream;
+
+	volatile u32 val = sm501_regRead32(UC8051_INT_8051); // this clears the interrupt
+
+	/* don't know which (or if both) have elapsed, so hit them both! */
+	stream = &(pcm->streams[SNDRV_PCM_STREAM_PLAYBACK]);
+	substream = stream->substream;
+	if (substream->hw_opened)
+		snd_pcm_period_elapsed(substream);
+
+	stream = &(pcm->streams[SNDRV_PCM_STREAM_CAPTURE]);
+	substream = stream->substream;
+	if (substream->hw_opened)
+		snd_pcm_period_elapsed(substream);
+
+	return IRQ_HANDLED;
+}
+
+static int sm501_pcm_locate_dma_buffer(struct snd_pcm *pcm, int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	unsigned int offset;
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+
+		offset = TX_BUF_OFFSET;
+		buf->bytes = TX_BUF_SIZE;
+	}
+	else {
+		offset = RX_BUF_OFFSET;
+		buf->bytes = RX_BUF_SIZE;
+	}
+	
+	/* virtual addr */
+	buf->area = sm501_get_reg() + UC8051_SHARED_SRAM + offset; 
+
+	/* physical addr */
+	buf->addr = sm501_virt_to_phys(buf->area);
+
+	return 0;
+}
+
+int sm501_pcm_new(struct snd_card *card, struct sm501_pcm_client *client, struct snd_pcm **pcm_handle)
+{
+	struct snd_pcm *pcm;
+	int ret;
+
+	ret = snd_pcm_new(card, "sm501-pcm", 0, 1, 1, &pcm);
+	if (ret)
+		goto out;
+
+	*pcm_handle = pcm;
+
+	pcm->private_data = client;
+
+	/* fill in slots from sm501-ac97.c */
+	sm501_pcm_ops.prepare = client->prepare;
+	sm501_pcm_ops.pointer = client->pointer;
+
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &sm501_pcm_ops);
+	ret = sm501_pcm_locate_dma_buffer(pcm, SNDRV_PCM_STREAM_PLAYBACK);
+	if (ret)
+		goto out;
+	
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &sm501_pcm_ops);
+	ret = sm501_pcm_locate_dma_buffer(pcm, SNDRV_PCM_STREAM_CAPTURE);
+	if (ret)
+		goto out;
+
+	ret = request_irq(SM501_8051, sm501_pcm_irq, 0, "sm501-ac97-8051", pcm);
+	if (ret < 0) {
+		printk(KERN_WARNING "sm501-pcm: request_irq failed\n");
+		goto out;
+	}
+
+ out:
+	return ret;
+}
+
+EXPORT_SYMBOL(sm501_pcm_new);
+
+MODULE_AUTHOR("Robert Whaley");
+MODULE_DESCRIPTION("SM501 8051 PCM module");
+MODULE_LICENSE("GPL");
diff -urN linux-2.6.17.9.orig/sound/arm/sm501-pcm.h linux-2.6.17.9/sound/arm/sm501-pcm.h
--- linux-2.6.17.9.orig/sound/arm/sm501-pcm.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.17.9/sound/arm/sm501-pcm.h	2006-10-04 10:42:52.000000000 -0400
@@ -0,0 +1,29 @@
+/*
+ * linux/sound/arm/sm501-pcm.h -- ALSA PCM interface for the SM501 chip
+ *
+ * Author:	Robert Whaley
+ * Created:	Oct 2, 2006
+ * Copyright:	Applied Data Systems, Inc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define TX_BUF_SIZE 2048
+#define RX_BUF_SIZE 1024
+
+#define TX_BUF_OFFSET 2048
+#define RX_BUF_OFFSET 1024
+
+struct sm501_pcm_client {
+	int (*prepare)(struct snd_pcm_substream *);
+	snd_pcm_uframes_t (*pointer)(struct snd_pcm_substream *);
+	void (*start_pcm)(struct snd_pcm_substream *);
+	void (*stop_pcm)(struct snd_pcm_substream *);
+	void (*set_period_sz)(struct snd_pcm_substream *, int);
+	void (*set_buffer_sz)(struct snd_pcm_substream *, int);
+};
+
+extern int sm501_pcm_new(struct snd_card *, struct sm501_pcm_client *, struct snd_pcm **pcm);
+
diff -urN linux-2.6.17.9.orig/sound/arm/sm501_ac97_8051.c linux-2.6.17.9/sound/arm/sm501_ac97_8051.c
--- linux-2.6.17.9.orig/sound/arm/sm501_ac97_8051.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.17.9/sound/arm/sm501_ac97_8051.c	2006-10-05 12:16:37.000000000 -0400
@@ -0,0 +1,661 @@
+#ifdef REBUILD_FROM_SOURCE
+/*
+ * linux/sound/sm501_ac97_8051.c -- AC97 8051 support for the SM501 chip.
+ *
+ * Author:	Robert Whaley, Applied Data Systems, October 2nd, 2006
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+typedef signed char s8;
+typedef signed short s16;
+typedef signed long s32;
+typedef unsigned char u8;
+typedef unsigned short u16;
+
+volatile xdata at 0x9100 u8 ac97_tx_s0_tag[2];
+
+volatile xdata at 0x9104 u8 ac97_tx_s1_cmd_addr[4];
+volatile xdata at 0x9108 u8 ac97_tx_s2_cmd_data[4];
+volatile xdata at 0x910c u8 ac97_tx_s3_playb_data_left[4];
+volatile xdata at 0x9110 u8 ac97_tx_s4_playb_data_right[4];
+volatile xdata at 0x9140 u8 ac97_rx_s0_tag[2];
+volatile xdata at 0x9144 u8 ac97_rx_s1_status_addr[4];
+volatile xdata at 0x9148 u8 ac97_rx_s2_status_data[4];
+volatile xdata at 0x914c u8 ac97_rx_s3_record_data_left[4];
+volatile xdata at 0x9150 u8 ac97_rx_s4_record_data_right[4];
+volatile xdata at 0x9180 u8 ac97_control_and_status[4];
+
+/* volatile xdata at 0x9000 u8 reset[4];  --- this is not accessible from the 8051 */
+volatile xdata at 0x9004 u8  mode_select;
+volatile xdata at 0x9008 u8  uc8051_protocol_interrupt[4];
+volatile xdata at 0x900c u8  cpu_protocol_interrupt[4];
+
+#define RX_S0_CODEC_READY 0x80
+#define RX_S0_S1_VALID    0x40
+#define RX_S0_S2_VALID    0x20
+#define RX_S0_S3_VALID    0x10
+#define RX_S0_S4_VALID    0x08
+
+#define RX_S1_STATUS_TX_S3_NOT_READY 0x08
+#define RX_S1_STATUS_TX_S4_NOT_READY 0x04
+#define RX_S1_STATUS_REG_INDEX       0x7f000
+
+#define RX_S2_DATA                   0xffff0
+
+#define TX_S0_TAG_VALID_FRAME_TAG    0x80
+#define TX_S0_TAG_SLOT_1_VALID       0x40
+#define TX_S0_TAG_SLOT_2_VALID       0x20
+#define TX_S0_TAG_SLOT_3_VALID       0x10
+#define TX_S0_TAG_SLOT_4_VALID       0x08
+
+#define TX_S1_READ_WRITE_SELECT      0x80000
+
+#define SHARED_SRAM 0x3000
+#define SHARED_SRAM_SIZE 4096
+
+#define CODEC_20BIT_DATA
+
+/* incomming interrupt word format
+
+   bits   
+    0:2    tag
+      3    rx=1, tx=0
+      4    on=1, off=0
+    5:7    counter
+    8:15   register
+   16:32   value
+*/
+
+#define SM501_8051_IRQ_TAG_NONE   0
+#define SM501_8051_IRQ_TAG_READ   1
+#define SM501_8051_IRQ_TAG_WRITE  2
+#define SM501_8051_IRQ_TAG_PCM    3
+#define SM501_8051_IRQ_TAG_BUFSZ  4
+#define SM501_8051_IRQ_TAG_PERSZ  5
+
+#define SM501_8051_IRQ_TAG_MSK    0x07
+#define SM501_8051_IRQ_REG_MSK    0x7f
+#define SM501_8051_IRQ_RX_TX_MSK  0x08
+#define SM501_8051_IRQ_ON_OFF_MSK 0x10
+#define SM501_8051_IRQ_COUNT_MSK  0xe0
+
+#define SM501_TX_IRQ_FRAME_COUNT 256
+#define SM501_RX_IRQ_FRAME_COUNT 128
+
+#define TX_BUF_SIZE 2048
+#define RX_BUF_SIZE 1024
+
+#define TX_BUF_OFFSET 2048
+#define RX_BUF_OFFSET 1024
+
+/* this shared data is written by the 8051 and read
+   by the CPU */
+typedef struct shared_data {
+	u16 cpu_irq_count;
+	u16 ac97_irq_count;
+	u16 handled_irq_count;
+	u16 loop_count;
+	u16 read_reg;
+	u16 read_reg_value;
+	u16 write_reg;
+	u16 write_reg_value;
+	u16 tx_buffer_pointer;
+	u16 rx_buffer_pointer;
+} shared_data_t;
+
+
+/* There are 2 copies of shared because the shared SRAM is not safe if
+ * the 8051 is reading/writing to a location while the CPU is
+ * writing/reading the same location (according to the SM501 manual
+ * and verified by tests).  So 2 redundant copies are maintained and
+ * for the contents to be considered valid the same data must be
+ * present in both copies.
+ */
+
+volatile xdata at (SHARED_SRAM) shared_data_t shared[2];
+volatile xdata at (SHARED_SRAM + RX_BUF_OFFSET) u8 rx[RX_BUF_SIZE];
+volatile xdata at (SHARED_SRAM + TX_BUF_OFFSET) u8 tx[TX_BUF_SIZE];
+
+volatile u16 tx_buf_size = TX_BUF_SIZE;
+volatile u16 rx_buf_size = RX_BUF_SIZE;
+
+u16 rx_index = 0;
+u16 tx_index = 0;
+
+u8 pcm_rx_state = 0;
+u8 pcm_tx_state = 0;
+
+volatile u8 tx_s0_tag = 0;
+
+volatile u16 sm501_tx_irq_frame_count = SM501_TX_IRQ_FRAME_COUNT;
+volatile u16 sm501_rx_irq_frame_count = SM501_RX_IRQ_FRAME_COUNT;
+
+u16 tx_irq_count = SM501_TX_IRQ_FRAME_COUNT;
+u16 rx_irq_count = SM501_RX_IRQ_FRAME_COUNT;
+
+volatile static u8 cpu_irq = 0;
+
+static void bzero(u8 *s, u16 n)
+{
+	while (n) s[--n] = 0;
+}
+
+/* interrupt from CPU */
+void isr7(void) interrupt 7 using 1 {
+	volatile u8 ignore; 
+
+	/* clear interrupt */
+	ignore = cpu_protocol_interrupt[0];
+
+	cpu_irq = 1;
+
+	shared[0].cpu_irq_count++;
+	shared[1].cpu_irq_count++;
+}
+
+
+/* interrupt from AC97 */
+void isr8(void) interrupt 8 using 2 {
+	/* send l and r samples from buffer */
+	u8 t, tup, r, rdown;
+	volatile u8 ignore;
+
+	/* clear interrupt */
+	ignore = ac97_control_and_status[1];
+
+	if (pcm_tx_state &&
+	    ((ac97_rx_s1_status_addr[1] & 0x0c) == 0))
+	{
+#ifdef CODEC_20BIT_DATA
+		/* 20 data bits (4 LS bits are zero) */
+		t = tx[tx_index++];
+		ac97_tx_s3_playb_data_left[0] = (0xf & t) << 4;
+
+		tup = 0xf & (t >> 4);
+		t = tx[tx_index++];
+		ac97_tx_s3_playb_data_left[1] = tup | ((0xf & t) << 4);
+
+		tup = 0xf & (t >> 4);
+		ac97_tx_s3_playb_data_left[2] = tup;
+
+		t = tx[tx_index++];
+		ac97_tx_s4_playb_data_right[0] = (0xf & t) << 4;
+
+		tup = 0xf & (t >> 4);
+		t = tx[tx_index++];
+		ac97_tx_s4_playb_data_right[1] = tup | ((0xf & t) << 4);
+
+		tup = 0xf & (t >> 4);
+		ac97_tx_s4_playb_data_right[2] = tup;
+#else
+		/* 16 data bits (4 MS bits are sign extended) */
+		ac97_tx_s3_playb_data_left[0] = tx[tx_index++];
+		ac97_tx_s3_playb_data_left[1] = tx[tx_index];
+		if (tx[tx_index++] & 0x80) 
+			ac97_tx_s3_playb_data_left[2] = 0xf;
+		else
+			ac97_tx_s3_playb_data_left[2] = 0;
+		ac97_tx_s4_playb_data_right[0] = tx[tx_index++];
+		ac97_tx_s4_playb_data_right[1] = tx[tx_index];
+		if (tx[tx_index++] & 0x80) 
+			ac97_tx_s4_playb_data_right[2] = 0xf;
+		else
+			ac97_tx_s4_playb_data_right[2] = 0;
+#endif
+
+		tx_s0_tag |= TX_S0_TAG_SLOT_3_VALID | TX_S0_TAG_SLOT_4_VALID | TX_S0_TAG_VALID_FRAME_TAG;
+
+		if (tx_index >=  tx_buf_size) {
+			tx_index = 0;
+		}
+
+		if (!--tx_irq_count) {
+			tx_irq_count = sm501_tx_irq_frame_count;
+			uc8051_protocol_interrupt[0] = 1;
+		}
+
+		shared[0].tx_buffer_pointer = tx_index;
+		shared[1].tx_buffer_pointer = tx_index;
+
+	}
+
+	if (pcm_rx_state &&
+	    (ac97_rx_s0_tag[1] & RX_S0_S3_VALID) &&
+	    (ac97_rx_s0_tag[1] & RX_S0_S4_VALID)) {
+#ifdef CODEC_20BIT_DATA
+		rdown = ac97_rx_s3_record_data_left[0] >> 4;
+		r     = ac97_rx_s3_record_data_left[1];
+		rx[rx_index++] = (0xf & rdown) | (0xf0 & (r << 4));
+		rdown = r >> 4;
+		r     = ac97_rx_s3_record_data_left[2];
+		rx[rx_index++] = (0xf & rdown) | (0xf0 & (r << 4));
+
+		rdown = ac97_rx_s4_record_data_right[0] >> 4;
+		r     = ac97_rx_s4_record_data_right[1];
+		rx[rx_index++] = (0xf & rdown) | (0xf0 & (r << 4));
+		rdown = r >> 4;
+		r     = ac97_rx_s4_record_data_right[2];
+		rx[rx_index++] = (0xf & rdown) | (0xf0 & (r << 4));
+#else
+		rx[rx_index++] = ac97_rx_s3_record_data_left[0];
+		rx[rx_index++] = ac97_rx_s3_record_data_left[1];
+		rx[rx_index++] = ac97_rx_s4_record_data_right[0];
+		rx[rx_index++] = ac97_rx_s4_record_data_right[1];
+#endif
+		if (rx_index >=  rx_buf_size) {
+			rx_index = 0;
+		}
+
+		if (!--rx_irq_count) {
+			rx_irq_count = sm501_rx_irq_frame_count;
+			uc8051_protocol_interrupt[0] = 1;
+		}
+	
+		shared[0].rx_buffer_pointer = rx_index;
+		shared[1].rx_buffer_pointer = rx_index;
+	}
+
+	shared[0].ac97_irq_count++;
+	shared[1].ac97_irq_count++;
+}
+
+void main(void) {
+
+	u8 read_reg_waiting = 0;
+	u8 reg_from_cpu = 0;
+	u8 reg_from_ac97 = 0;
+
+	bzero(shared, sizeof(shared) * sizeof(*shared));
+
+	tx_s0_tag = 0;
+	cpu_irq = 0;
+
+#if 0
+	/* run the clock at half speed */
+	mode_select = 0x02;
+#endif
+
+	/* enable interrupts */
+	_asm
+
+
+	  /* I think this enables both the AC97 and the CPU IRQs */
+	  mov 0xe8,#6
+	  /* this also has something to do with enabling IRQs */
+	  mov 0xf8,#4
+
+	  /* This disables IRQ 0 which is GPIO54 */
+	  clr ex0
+	  setb ea
+
+        _endasm;
+
+	while (1) {
+
+		u8 reg_valid = 0;
+		u8 op_done = 0;
+
+		shared[0].loop_count++;
+		shared[1].loop_count++;
+
+		if (cpu_irq) {
+
+			shared[0].handled_irq_count++;
+			shared[1].handled_irq_count++;
+
+			cpu_irq = 0;
+
+			switch (cpu_protocol_interrupt[0] & SM501_8051_IRQ_TAG_MSK) {
+
+			case SM501_8051_IRQ_TAG_PCM:
+
+				/* turn on PCM rx or tx */
+				if (cpu_protocol_interrupt[0] & SM501_8051_IRQ_RX_TX_MSK) {
+					pcm_rx_state = cpu_protocol_interrupt[0] & SM501_8051_IRQ_ON_OFF_MSK;
+				} else {
+					pcm_tx_state = cpu_protocol_interrupt[0] & SM501_8051_IRQ_ON_OFF_MSK;
+				}
+				break;
+
+			case SM501_8051_IRQ_TAG_WRITE:
+
+				/* send data and reg to codec */
+				reg_from_cpu = (cpu_protocol_interrupt[1] & SM501_8051_IRQ_REG_MSK);
+				ac97_tx_s1_cmd_addr[0] = 0;
+				ac97_tx_s1_cmd_addr[1] = (reg_from_cpu & 0xf) << 4;
+				ac97_tx_s1_cmd_addr[2] = (reg_from_cpu & 0x70) >> 4;
+				ac97_tx_s1_cmd_addr[3] = 0;
+
+				ac97_tx_s2_cmd_data[0] =  (cpu_protocol_interrupt[2] & 0xf) << 4;
+				ac97_tx_s2_cmd_data[1] = ((cpu_protocol_interrupt[2] & 0xf0) >> 4) | 
+                                                               ((cpu_protocol_interrupt[3] & 0x0f) << 4);
+				ac97_tx_s2_cmd_data[2] =  (cpu_protocol_interrupt[3] & 0xf0) >> 4;
+				ac97_tx_s2_cmd_data[3] = 0;
+				
+				critical {
+					tx_s0_tag |= TX_S0_TAG_SLOT_1_VALID |
+						     TX_S0_TAG_SLOT_2_VALID |
+						     TX_S0_TAG_VALID_FRAME_TAG;
+				}
+
+				/* update the shared data so CPU knows we are done */
+				shared[0].write_reg = reg_from_cpu;
+				shared[1].write_reg = reg_from_cpu;
+				shared[0].write_reg_value = (cpu_protocol_interrupt[2] |
+							     (cpu_protocol_interrupt[3] << 8));
+				shared[1].write_reg_value = (cpu_protocol_interrupt[2] |
+							     (cpu_protocol_interrupt[3] << 8));
+				break;
+
+			case SM501_8051_IRQ_TAG_READ:
+				/* send read reg to codec */
+
+				reg_from_cpu = (cpu_protocol_interrupt[1] & SM501_8051_IRQ_REG_MSK);
+				ac97_tx_s1_cmd_addr[0] = 0;
+				ac97_tx_s1_cmd_addr[1] = (reg_from_cpu & 0xf) << 4;
+				ac97_tx_s1_cmd_addr[2] = 0x08 | ((reg_from_cpu & 0x70) >> 4);
+				ac97_tx_s1_cmd_addr[3] = 0;
+
+				critical {
+					tx_s0_tag |= TX_S0_TAG_SLOT_1_VALID | TX_S0_TAG_VALID_FRAME_TAG;
+				}
+				read_reg_waiting = 1;
+				break;
+
+			case SM501_8051_IRQ_TAG_BUFSZ:
+				if (cpu_protocol_interrupt[0] & SM501_8051_IRQ_RX_TX_MSK) {
+					rx_buf_size = (cpu_protocol_interrupt[2] |
+						       (cpu_protocol_interrupt[3] << 8));
+				}
+				else {
+					tx_buf_size = (cpu_protocol_interrupt[2] |
+						       (cpu_protocol_interrupt[3] << 8));
+				}
+				break;
+
+			case SM501_8051_IRQ_TAG_PERSZ:
+				if (cpu_protocol_interrupt[0] & SM501_8051_IRQ_RX_TX_MSK) {
+					sm501_rx_irq_frame_count = (cpu_protocol_interrupt[2] |
+								    (cpu_protocol_interrupt[3] << 8));
+				}
+				else {
+					sm501_tx_irq_frame_count = (cpu_protocol_interrupt[2] |
+								    (cpu_protocol_interrupt[3] << 8));
+				}
+				break;
+			}
+		}
+
+		if (read_reg_waiting /* ac97_rx_s0_tag[1] & RX_S0_CODEC_READY */) {
+
+			/* get register value */
+			if (ac97_rx_s0_tag[1] & RX_S0_S1_VALID) {
+				reg_from_ac97 = ((ac97_rx_s1_status_addr[1] >> 4) |
+						 ((ac97_rx_s1_status_addr[2] & 0x7) << 4));
+			}
+
+			/* get data value */
+			if (read_reg_waiting &&
+			    reg_from_ac97 == reg_from_cpu &&
+			    (ac97_rx_s0_tag[1] & RX_S0_S2_VALID)) {
+				shared[0].read_reg = reg_from_ac97;
+				shared[1].read_reg = reg_from_ac97;
+				shared[0].read_reg_value = ( ac97_rx_s2_status_data[0]         >> 4) |
+					                   ( ac97_rx_s2_status_data[1]         << 4) |
+					                   ((ac97_rx_s2_status_data[2] & 0x0f) << 12);
+				shared[1].read_reg_value = ( ac97_rx_s2_status_data[0]         >> 4) |
+					                   ( ac97_rx_s2_status_data[1]         << 4) |
+					                   ((ac97_rx_s2_status_data[2] & 0x0f) << 12);
+				read_reg_waiting = 0;
+			}
+		}
+
+		/* send off everything (or nothing) */
+		critical {
+			if (tx_s0_tag) {
+				ac97_tx_s0_tag[1] = tx_s0_tag;
+				tx_s0_tag = 0;
+			}
+		}
+	}
+}
+#else
+/* generated by bin2c from sm501.bin */
+
+unsigned char sm501_ac97_8051_uc[1844] = {
+	0x02,0x06,0x9e,0x32,0xff,0xff,0xff,0xff,
+	0xff,0xff,0xff,0x32,0xff,0xff,0xff,0xff,
+	0xff,0xff,0xff,0x32,0xff,0xff,0xff,0xff,
+	0xff,0xff,0xff,0x32,0xff,0xff,0xff,0xff,
+	0xff,0xff,0xff,0x32,0xff,0xff,0xff,0xff,
+	0xff,0xff,0xff,0x32,0xff,0xff,0xff,0xff,
+	0xff,0xff,0xff,0x32,0xff,0xff,0xff,0xff,
+	0xff,0xff,0xff,0x02,0x00,0x73,0xff,0xff,
+	0xff,0xff,0xff,0x02,0x00,0xba,0x12,0x03,
+	0x25,0x80,0xfe,0xaa,0x82,0xab,0x83,0xac,
+	0xf0,0xad,0x18,0xae,0x19,0xed,0x4e,0x60,
+	0x19,0x1d,0xbd,0xff,0x01,0x1e,0xed,0x2a,
+	0xff,0xee,0x3b,0xf8,0x8c,0x01,0x8f,0x82,
+	0x88,0x83,0x89,0xf0,0xe4,0x12,0x06,0x6c,
+	0x80,0xe3,0x22,0xc0,0xe0,0xc0,0x82,0xc0,
+	0x83,0xc0,0xd0,0x75,0xd0,0x08,0x90,0x90,
+	0x0c,0xe0,0xf5,0x35,0x75,0x34,0x01,0x90,
+	0x30,0x00,0xe0,0xfa,0xa3,0xe0,0xfb,0x0a,
+	0xba,0x00,0x01,0x0b,0x90,0x30,0x00,0xea,
+	0xf0,0xa3,0xeb,0xf0,0x90,0x30,0x14,0xe0,
+	0xfa,0xa3,0xe0,0xfb,0x0a,0xba,0x00,0x01,
+	0x0b,0x90,0x30,0x14,0xea,0xf0,0xa3,0xeb,
+	0xf0,0xd0,0xd0,0xd0,0x83,0xd0,0x82,0xd0,
+	0xe0,0x32,0xc0,0xe0,0xc0,0x82,0xc0,0x83,
+	0xc0,0xd0,0x75,0xd0,0x10,0x90,0x91,0x81,
+	0xe0,0xf5,0x36,0xe5,0x2a,0x70,0x03,0x02,
+	0x01,0xdb,0x90,0x91,0x45,0xe0,0xfa,0x53,
+	0x12,0x0c,0xba,0x00,0x02,0x80,0x03,0x02,
+	0x01,0xdb,0xaa,0x27,0xab,0x28,0x05,0x27,
+	0xe4,0xb5,0x27,0x02,0x05,0x28,0x8a,0x82,
+	0x74,0x38,0x2b,0xf5,0x83,0xe0,0xfa,0x74,
+	0x0f,0x5a,0xfb,0xc4,0x54,0xf0,0xfb,0x90,
+	0x91,0x0c,0xf0,0xea,0xc4,0x54,0x0f,0xfb,
+	0x53,0x13,0x0f,0xac,0x27,0xad,0x28,0x05,
+	0x27,0xe4,0xb5,0x27,0x02,0x05,0x28,0x8c,
+	0x82,0x74,0x38,0x2d,0xf5,0x83,0xe0,0xfa,
+	0x74,0x0f,0x5a,0xfc,0xc4,0x54,0xf0,0xfc,
+	0xeb,0x42,0x14,0x90,0x91,0x0d,0xec,0xf0,
+	0xea,0xc4,0x54,0x0f,0xfc,0x74,0x0f,0x5c,
+	0xfb,0x90,0x91,0x0e,0xf0,0xac,0x27,0xad,
+	0x28,0x05,0x27,0xe4,0xb5,0x27,0x02,0x05,
+	0x28,0x8c,0x82,0x74,0x38,0x2d,0xf5,0x83,
+	0xe0,0xfa,0x74,0x0f,0x5a,0xfc,0xc4,0x54,
+	0xf0,0xfc,0x90,0x91,0x10,0xf0,0xea,0xc4,
+	0x54,0x0f,0xfc,0x74,0x0f,0x5c,0xfb,0xac,
+	0x27,0xad,0x28,0x05,0x27,0xe4,0xb5,0x27,
+	0x02,0x05,0x28,0x8c,0x82,0x74,0x38,0x2d,
+	0xf5,0x83,0xe0,0xfa,0x74,0x0f,0x5a,0xfc,
+	0xc4,0x54,0xf0,0xfc,0xeb,0x42,0x14,0x90,
+	0x91,0x11,0xec,0xf0,0xea,0xc4,0x54,0x0f,
+	0xfa,0x74,0x0f,0x5a,0xfb,0x90,0x91,0x12,
+	0xf0,0x43,0x2b,0x98,0xc3,0xe5,0x27,0x95,
+	0x21,0xe5,0x28,0x95,0x22,0x40,0x05,0xe4,
+	0xf5,0x27,0xf5,0x28,0x15,0x30,0x74,0xff,
+	0xb5,0x30,0x02,0x15,0x31,0xe5,0x30,0x45,
+	0x31,0x70,0x0c,0x85,0x2c,0x30,0x85,0x2d,
+	0x31,0x90,0x90,0x08,0x74,0x01,0xf0,0x90,
+	0x30,0x10,0xe5,0x27,0xf0,0xa3,0xe5,0x28,
+	0xf0,0x90,0x30,0x24,0xe5,0x27,0xf0,0xa3,
+	0xe5,0x28,0xf0,0xe5,0x29,0x70,0x03,0x02,
+	0x02,0xf2,0x90,0x91,0x41,0xe0,0xfa,0x20,
+	0xe4,0x03,0x02,0x02,0xf2,0x90,0x91,0x41,
+	0xe0,0xfa,0x20,0xe3,0x03,0x02,0x02,0xf2,
+	0x90,0x91,0x4c,0xe0,0xfa,0xc4,0x54,0x0f,
+	0xfa,0x90,0x91,0x4d,0xe0,0xfb,0xac,0x25,
+	0xad,0x26,0x05,0x25,0xe4,0xb5,0x25,0x02,
+	0x05,0x26,0x8c,0x82,0x74,0x34,0x2d,0xf5,
+	0x83,0x74,0x0f,0x5a,0xfc,0xeb,0xc4,0x54,
+	0xf0,0xfd,0x74,0xf0,0x5d,0x42,0x14,0xec,
+	0xf0,0xeb,0xc4,0x54,0x0f,0xfa,0x90,0x91,
+	0x4e,0xe0,0xfb,0xac,0x25,0xad,0x26,0x05,
+	0x25,0xe4,0xb5,0x25,0x02,0x05,0x26,0x8c,
+	0x82,0x74,0x34,0x2d,0xf5,0x83,0x74,0x0f,
+	0x5a,0xfc,0xeb,0xc4,0x54,0xf0,0xfd,0x74,
+	0xf0,0x5d,0x42,0x14,0xec,0xf0,0x90,0x91,
+	0x50,0xe0,0xfc,0xc4,0x54,0x0f,0xfa,0x90,
+	0x91,0x51,0xe0,0xfb,0xac,0x25,0xad,0x26,
+	0x05,0x25,0xe4,0xb5,0x25,0x02,0x05,0x26,
+	0x8c,0x82,0x74,0x34,0x2d,0xf5,0x83,0x74,
+	0x0f,0x5a,0xfc,0xeb,0xc4,0x54,0xf0,0xfd,
+	0x74,0xf0,0x5d,0x42,0x14,0xec,0xf0,0xeb,
+	0xc4,0x54,0x0f,0xfa,0x90,0x91,0x52,0xe0,
+	0xfb,0xac,0x25,0xad,0x26,0x05,0x25,0xe4,
+	0xb5,0x25,0x02,0x05,0x26,0x8c,0x82,0x74,
+	0x34,0x2d,0xf5,0x83,0x53,0x12,0x0f,0xeb,
+	0xc4,0x54,0xf0,0xfb,0x74,0xf0,0x5b,0x42,
+	0x12,0xea,0xf0,0xc3,0xe5,0x25,0x95,0x23,
+	0xe5,0x26,0x95,0x24,0x40,0x05,0xe4,0xf5,
+	0x25,0xf5,0x26,0x15,0x32,0x74,0xff,0xb5,
+	0x32,0x02,0x15,0x33,0xe5,0x32,0x45,0x33,
+	0x70,0x0c,0x85,0x2e,0x32,0x85,0x2f,0x33,
+	0x90,0x90,0x08,0x74,0x01,0xf0,0x90,0x30,
+	0x12,0xe5,0x25,0xf0,0xa3,0xe5,0x26,0xf0,
+	0x90,0x30,0x26,0xe5,0x25,0xf0,0xa3,0xe5,
+	0x26,0xf0,0x90,0x30,0x02,0xe0,0xfa,0xa3,
+	0xe0,0xfb,0x0a,0xba,0x00,0x01,0x0b,0x90,
+	0x30,0x02,0xea,0xf0,0xa3,0xeb,0xf0,0x90,
+	0x30,0x16,0xe0,0xfa,0xa3,0xe0,0xfb,0x0a,
+	0xba,0x00,0x01,0x0b,0x90,0x30,0x16,0xea,
+	0xf0,0xa3,0xeb,0xf0,0xd0,0xd0,0xd0,0x83,
+	0xd0,0x82,0xd0,0xe0,0x32,0x7a,0x00,0x7b,
+	0x00,0x7c,0x00,0x75,0x18,0x20,0x75,0x19,
+	0x03,0x90,0x30,0x00,0x75,0xf0,0x01,0xc0,
+	0x02,0xc0,0x03,0xc0,0x04,0x12,0x00,0x4b,
+	0xd0,0x04,0xd0,0x03,0xd0,0x02,0x75,0x2b,
+	0x00,0x75,0x34,0x00,0x75,0xe8,0x06,0x75,
+	0xf8,0x04,0xc2,0xa8,0xd2,0xaf,0x90,0x30,
+	0x06,0xe0,0xfd,0xa3,0xe0,0xfe,0x0d,0xbd,
+	0x00,0x01,0x0e,0x90,0x30,0x06,0xed,0xf0,
+	0xa3,0xee,0xf0,0x90,0x30,0x1a,0xe0,0xfd,
+	0xa3,0xe0,0xfe,0x0d,0xbd,0x00,0x01,0x0e,
+	0x90,0x30,0x1a,0xed,0xf0,0xa3,0xee,0xf0,
+	0xe5,0x34,0x70,0x03,0x02,0x05,0x76,0x90,
+	0x30,0x04,0xe0,0xfd,0xa3,0xe0,0xfe,0x0d,
+	0xbd,0x00,0x01,0x0e,0x90,0x30,0x04,0xed,
+	0xf0,0xa3,0xee,0xf0,0x90,0x30,0x18,0xe0,
+	0xfd,0xa3,0xe0,0xfe,0x0d,0xbd,0x00,0x01,
+	0x0e,0x90,0x30,0x18,0xed,0xf0,0xa3,0xee,
+	0xf0,0x75,0x34,0x00,0x90,0x90,0x0c,0xe0,
+	0x54,0x07,0xfd,0x24,0xfa,0x50,0x03,0x02,
+	0x05,0x76,0xed,0x2d,0x2d,0x90,0x03,0xc9,
+	0x73,0x02,0x05,0x76,0x02,0x04,0xc7,0x02,
+	0x03,0xfd,0x02,0x03,0xdb,0x02,0x05,0x08,
+	0x02,0x05,0x40,0x90,0x90,0x0c,0xe0,0xfd,
+	0x30,0xe3,0x0d,0x90,0x90,0x0c,0xe0,0xfd,
+	0x74,0x10,0x5d,0xf5,0x29,0x02,0x05,0x76,
+	0x90,0x90,0x0c,0xe0,0xfd,0x74,0x10,0x5d,
+	0xf5,0x2a,0x02,0x05,0x76,0x90,0x90,0x0d,
+	0xe0,0xfd,0x74,0x7f,0x5d,0xfb,0x90,0x91,
+	0x04,0xe4,0xf0,0x74,0x0f,0x5b,0xfd,0xc4,
+	0x54,0xf0,0xfd,0x90,0x91,0x05,0xf0,0x74,
+	0x70,0x5b,0xfd,0xc4,0x54,0x0f,0xfd,0x90,
+	0x91,0x06,0xf0,0x90,0x91,0x07,0xe4,0xf0,
+	0x90,0x90,0x0e,0xe0,0x54,0x0f,0xfd,0xc4,
+	0x54,0xf0,0xfd,0x90,0x91,0x08,0xf0,0x90,
+	0x90,0x0e,0xe0,0x54,0xf0,0xfd,0xc4,0x54,
+	0x0f,0xfd,0x90,0x90,0x0f,0xe0,0x54,0x0f,
+	0xfe,0xc4,0x54,0xf0,0xfe,0x42,0x05,0x90,
+	0x91,0x09,0xed,0xf0,0x90,0x90,0x0f,0xe0,
+	0x54,0xf0,0xfd,0xc4,0x54,0x0f,0xfd,0x90,
+	0x91,0x0a,0xf0,0x90,0x91,0x0b,0xe4,0xf0,
+	0xd2,0x00,0x10,0xaf,0x02,0xc2,0x00,0x43,
+	0x2b,0xe0,0xa2,0x00,0x92,0xaf,0x8b,0x05,
+	0x7e,0x00,0x90,0x30,0x0c,0xed,0xf0,0xa3,
+	0xee,0xf0,0x90,0x30,0x20,0xed,0xf0,0xa3,
+	0xee,0xf0,0x90,0x90,0x0e,0xe0,0xfd,0x90,
+	0x90,0x0f,0xe0,0xfe,0x8e,0x07,0xe4,0xfe,
+	0xf8,0xed,0x42,0x06,0xe8,0x42,0x07,0x90,
+	0x30,0x0e,0xee,0xf0,0xa3,0xef,0xf0,0x90,
+	0x90,0x0e,0xe0,0xfd,0x90,0x90,0x0f,0xe0,
+	0xfe,0x8e,0x07,0xe4,0xfe,0xf8,0xed,0x42,
+	0x06,0xe8,0x42,0x07,0x90,0x30,0x22,0xee,
+	0xf0,0xa3,0xef,0xf0,0x02,0x05,0x76,0x90,
+	0x90,0x0d,0xe0,0xfd,0x74,0x7f,0x5d,0xfb,
+	0x90,0x91,0x04,0xe4,0xf0,0x74,0x0f,0x5b,
+	0xfd,0xc4,0x54,0xf0,0xfd,0x90,0x91,0x05,
+	0xf0,0x74,0x70,0x5b,0xfd,0xc4,0x54,0x0f,
+	0xfd,0x43,0x05,0x08,0x90,0x91,0x06,0xed,
+	0xf0,0x90,0x91,0x07,0xe4,0xf0,0xd2,0x00,
+	0x10,0xaf,0x02,0xc2,0x00,0x43,0x2b,0xc0,
+	0xa2,0x00,0x92,0xaf,0x7a,0x01,0x80,0x6e,
+	0x90,0x90,0x0c,0xe0,0xfd,0x30,0xe3,0x18,
+	0x90,0x90,0x0e,0xe0,0xfd,0x90,0x90,0x0f,
+	0xe0,0xfe,0x8e,0x07,0xe4,0xfe,0xf8,0x4d,
+	0xf5,0x23,0xef,0x48,0xf5,0x24,0x80,0x4e,
+	0x90,0x90,0x0e,0xe0,0xfd,0x90,0x90,0x0f,
+	0xe0,0xfe,0x8e,0x07,0xe4,0xfe,0xf8,0x4d,
+	0xf5,0x21,0xef,0x48,0xf5,0x22,0x80,0x36,
+	0x90,0x90,0x0c,0xe0,0xfd,0x30,0xe3,0x18,
+	0x90,0x90,0x0e,0xe0,0xfd,0x90,0x90,0x0f,
+	0xe0,0xfe,0x8e,0x07,0xe4,0xfe,0xf8,0x4d,
+	0xf5,0x2e,0xef,0x48,0xf5,0x2f,0x80,0x16,
+	0x90,0x90,0x0e,0xe0,0xfd,0x90,0x90,0x0f,
+	0xe0,0xfe,0x8e,0x07,0xe4,0xfe,0xf8,0x4d,
+	0xf5,0x2c,0xef,0x48,0xf5,0x2d,0xea,0x70,
+	0x03,0x02,0x06,0x50,0x90,0x91,0x41,0xe0,
+	0xfd,0x30,0xe6,0x16,0x90,0x91,0x45,0xe0,
+	0xfd,0xc4,0x54,0x0f,0xfd,0x90,0x91,0x46,
+	0xe0,0x54,0x07,0xfe,0xc4,0x54,0xf0,0xfe,
+	0x4d,0xfc,0xea,0x70,0x03,0x02,0x06,0x50,
+	0xec,0xb5,0x03,0x02,0x80,0x03,0x02,0x06,
+	0x50,0x90,0x91,0x41,0xe0,0xfd,0x20,0xe5,
+	0x03,0x02,0x06,0x50,0x8c,0x05,0x7e,0x00,
+	0x90,0x30,0x08,0xed,0xf0,0xa3,0xee,0xf0,
+	0x90,0x30,0x1c,0xed,0xf0,0xa3,0xee,0xf0,
+	0x90,0x91,0x48,0xe0,0xfd,0xc4,0x54,0x0f,
+	0xfd,0x90,0x91,0x49,0xe0,0xfe,0xe4,0xff,
+	0xc4,0x54,0xf0,0xce,0xc4,0xce,0x6e,0xce,
+	0x54,0xf0,0xce,0x6e,0xff,0x78,0x00,0xed,
+	0x42,0x06,0xe8,0x42,0x07,0x90,0x91,0x4a,
+	0xe0,0xfd,0x53,0x05,0x0f,0x78,0x00,0xed,
+	0xc4,0x54,0xf0,0xf8,0xe4,0xfd,0x42,0x06,
+	0xe8,0x42,0x07,0x90,0x30,0x0a,0xee,0xf0,
+	0xa3,0xef,0xf0,0x90,0x91,0x48,0xe0,0xfd,
+	0xc4,0x54,0x0f,0xfd,0x90,0x91,0x49,0xe0,
+	0xfe,0xe4,0xff,0xc4,0x54,0xf0,0xce,0xc4,
+	0xce,0x6e,0xce,0x54,0xf0,0xce,0x6e,0xff,
+	0x78,0x00,0xed,0x42,0x06,0xe8,0x42,0x07,
+	0x90,0x91,0x4a,0xe0,0xfd,0x53,0x05,0x0f,
+	0x78,0x00,0xed,0xc4,0x54,0xf0,0xf8,0xe4,
+	0xfd,0x42,0x06,0xe8,0x42,0x07,0x90,0x30,
+	0x1e,0xee,0xf0,0xa3,0xef,0xf0,0x7a,0x00,
+	0xd2,0x00,0x10,0xaf,0x02,0xc2,0x00,0xe5,
+	0x2b,0x60,0x09,0x90,0x91,0x01,0xe5,0x2b,
+	0xf0,0x75,0x2b,0x00,0xa2,0x00,0x92,0xaf,
+	0x02,0x03,0x56,0x22,0xc0,0xe0,0xe5,0xf0,
+	0x60,0x10,0x14,0x60,0x17,0x14,0x60,0x07,
+	0x14,0x60,0x15,0x14,0x14,0x60,0x03,0xd0,
+	0xe0,0x22,0xd0,0xe0,0xc0,0x00,0xa8,0x82,
+	0xf6,0xd0,0x00,0x22,0xd0,0xe0,0xf0,0x22,
+	0xd0,0xe0,0xc0,0x00,0xa8,0x82,0xf2,0xd0,
+	0x00,0x22,0x75,0x82,0x00,0x22,0x75,0x81,
+	0x36,0x12,0x06,0x9a,0xe5,0x82,0x60,0x03,
+	0x02,0x00,0x46,0x79,0x00,0xe9,0x44,0x00,
+	0x60,0x1b,0x7a,0x00,0x90,0x07,0x34,0x78,
+	0x00,0x75,0xa0,0x00,0xe4,0x93,0xf2,0xa3,
+	0x08,0xb8,0x00,0x02,0x05,0xa0,0xd9,0xf4,
+	0xda,0xf2,0x75,0xa0,0xff,0xe4,0x78,0xff,
+	0xf6,0xd8,0xfd,0x78,0x00,0xe8,0x44,0x00,
+	0x60,0x0a,0x79,0x00,0x75,0xa0,0x00,0xe4,
+	0xf3,0x09,0xd8,0xfc,0x78,0x00,0xe8,0x44,
+	0x00,0x60,0x0c,0x79,0x00,0x90,0x00,0x00,
+	0xe4,0xf0,0xa3,0xd8,0xfc,0xd9,0xfa,0x75,
+	0x21,0x00,0x75,0x22,0x08,0x75,0x23,0x00,
+	0x75,0x24,0x04,0xe4,0xf5,0x25,0xf5,0x26,
+	0xe4,0xf5,0x27,0xf5,0x28,0x75,0x29,0x00,
+	0x75,0x2a,0x00,0x75,0x2b,0x00,0x75,0x2c,
+	0x00,0x75,0x2d,0x01,0x75,0x2e,0x80,0xe4,
+	0xf5,0x2f,0x75,0x30,0x00,0x75,0x31,0x01,
+	0x75,0x32,0x80,0xe4,0xf5,0x33,0x75,0x34,
+	0x00,0x02,0x00,0x46
+};
+#endif

--------------060505080809010305060202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------060505080809010305060202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------060505080809010305060202--
