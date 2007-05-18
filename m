From: "Diego A. Fons" <diegofons@apexar.com>
Subject: Re: Problem with FB
Date: Fri, 18 May 2007 09:56:25 -0300
Message-ID: <464DA279.6070404@apexar.com>
References: <464B3527.4080406@apexar.com> <464D5A56.4070906@rfo.atmel.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030300050800070004060401"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hp1z8-00019U-HG for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 18 May 2007 05:55:06 -0700
Received: from smtp1.allytech.com ([200.49.145.100] helo=ns1.arsesco.com.ar)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hp1z7-000696-58
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 18 May 2007 05:55:06 -0700
Received: from [192.168.0.103] (200-55-73-254.dsl.prima.net.ar [200.55.73.254])
	by ns1.arsesco.com.ar (8.13.8/8.13.1) with ESMTP id l4ICrme4024846
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 18 May 2007 09:53:48 -0300
In-Reply-To: <464D5A56.4070906@rfo.atmel.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030300050800070004060401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Nicolas Ferre escribi=F3:

>Diego A. Fons :
> =20
>
>>Hi,
>>
>>First of all i'm not sure if it is the correct list for posting this=20
>>mail, if it's not, please tell me wich list is the correct one.
>>
>>I'm working on an embedded device (a Ronetix pm9261 board with an=20
>>AT91SAM9261 cpu), i could build the linux kernel version 2.6.19.7 with=20
>>framebuffer support and it works fine. The problem is when i run any=20
>>command that uses net services, i.e. when i run sftp the sreen moves an=
d=20
>>it kept like this, the offset (0,0) is in position (100,0) (it's just a=
n=20
>>example, i don't know thw correct values) and i'm not able to correct=20
>>it. It occurs every time i run a net comand. The display i'm usin is a=20
>>LCD and the driver is sidsab.c.
>>   =20
>>
>
>Strange behavior is not it ;-)
>
>I have seen this before and it was due to a bad timing setup of the
>dm9000 chip select.
>
>-	at91_sys_write(AT91_SMC_CYCLE(2), AT91_SMC_NWECYCLE_(0) | AT91_SMC_NRD=
CYCLE_(16));
>+	at91_sys_write(AT91_SMC_CYCLE(2), AT91_SMC_NWECYCLE_(16) | AT91_SMC_NR=
DCYCLE_(16));
>
>Is you have the first configuration, try with the second and it should
>fix your problem.
>
>Hope that it helps. Tell us if it works.
>
>Regards,
> =20
>
Thanks for replying!

I search the line you describes and i could find something similar in=20
the initialization routine (attach) this is the similar line:

at91_sys_write(AT91_SMC_CYCLE(2), \
                        (       AT91_DM9000_NWE_CYCLE |
                                AT91_DM9000_NRD_CYCLE));

The macros are:

#define AT91_DM9000_NWE_CYCLE           (32 << 0)
#define AT91_DM9000_NRD_CYCLE           (32 << 16)

Did you refer to that? or i have to look another place?

Regards,
Diego A. Fons.

--------------030300050800070004060401
Content-Type: text/plain;
 name="board-pm9261.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="board-pm9261.c"

/*
 * linux/arch/arm/mach-at91/at91sam9261/board-pm9261.c
 *
 *  Copyright (C) 2006 Ronetix
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include <linux/types.h>
#include <linux/init.h>
#include <linux/mm.h>
#include <linux/module.h>
#include <linux/platform_device.h>
#include <linux/spi/spi.h>
#if defined(CONFIG_SPI_PM9261_TSC2301) || defined(CONFIG_SPI_PM9261_TSC2301_MODULE)
#include <linux/spi/tsc2301.h>
#endif
#include <linux/mtd/nand.h>

#include <asm/hardware.h>
#include <asm/setup.h>
#include <asm/mach-types.h>
#include <asm/irq.h>

#include <asm/mach/arch.h>
#include <asm/mach/map.h>
#include <asm/mach/irq.h>

#include <asm/arch/board.h>
#include <asm/arch/gpio.h>
#include <asm/arch/at91sam9261_matrix.h>
#include <asm/arch/at91sam926x_mc.h>
#include <asm/arch/at91_pmc.h>

#include "generic.h"

#if defined(CONFIG_FB_SIDSA) || defined (CONFIG_FB_SIDSA_MODULE)
static struct resource lcdc_resources[] = {
	[0] = {
		.start	= AT91SAM9261_LCDC_BASE,
		.end	= AT91SAM9261_LCDC_BASE + SZ_4K - 1,
		.flags	= IORESOURCE_MEM,
	},
	[1] = {
		.start	= AT91SAM9261_ID_LCDC,
		.end	= AT91SAM9261_ID_LCDC,
		.flags	= IORESOURCE_IRQ,
	},
#if defined(CONFIG_FB_TCM)
	[2] = {
		.start	= AT91SAM9261_SRAM_BASE,
		.end	= AT91SAM9261_SRAM_BASE + AT91SAM9261_SRAM_SIZE - 1,
		.flags	= IORESOURCE_MEM,
	},
#endif
};

static u64 lcdc_dmamask = 0xffffffffUL;
//static struct lcdc_platform_data lcdc_data;

static struct platform_device lcdc_device = {
	.name           = "lcdc",
	.id             = 0,
	.num_resources  = ARRAY_SIZE(lcdc_resources),
	.resource       = lcdc_resources,
	.dev            = {
		.dma_mask          = &lcdc_dmamask,
		.coherent_dma_mask = 0xffffffff,
//		.platform_data     = &lcdc_data,
	},
};

static void __init pm9261_add_device_lcdc (void) {

	at91_set_A_periph (AT91_PIN_PB1, 0);
	at91_set_A_periph (AT91_PIN_PB2, 0);
	at91_set_A_periph (AT91_PIN_PB3, 0);
	at91_set_A_periph (AT91_PIN_PB4, 0);
	at91_set_A_periph (AT91_PIN_PB7, 0);
	at91_set_A_periph (AT91_PIN_PB8, 0);
	at91_set_A_periph (AT91_PIN_PB9, 0);
	at91_set_A_periph (AT91_PIN_PB10, 0);
	at91_set_A_periph (AT91_PIN_PB11, 0);
	at91_set_A_periph (AT91_PIN_PB12, 0);
	at91_set_A_periph (AT91_PIN_PB15, 0);
	at91_set_A_periph (AT91_PIN_PB16, 0);
	at91_set_A_periph (AT91_PIN_PB17, 0);
	at91_set_A_periph (AT91_PIN_PB18, 0);
	at91_set_A_periph (AT91_PIN_PB19, 0);
	at91_set_A_periph (AT91_PIN_PB20, 0);
	at91_set_B_periph (AT91_PIN_PB23, 0);
	at91_set_B_periph (AT91_PIN_PB24, 0);
	at91_set_B_periph (AT91_PIN_PB25, 0);
	at91_set_B_periph (AT91_PIN_PB26, 0);
	at91_set_B_periph (AT91_PIN_PB27, 0);
	at91_set_B_periph (AT91_PIN_PB28, 0);

	/* Configure PA22 in pio to enable LCD */
	at91_set_gpio_output (AT91_PIN_PA22, 0);

	printk ("pm9261 lcd registered: %i\n",
		platform_device_register (& lcdc_device));
}
#else
static void __init pm9261_add_device_lcdc (void) { }
#endif

static void __init pm9261_init_irq(void)
{
	/* Initialize AIC controller */
	at91sam9261_init_interrupts(NULL);
}

/******************************************************************************
* Serial port configuration.
*    0 .. 2 = USART0 .. USART3
*    3      = DBGU
******************************************************************************/
static struct at91_uart_config __initdata pm9261_uart_config = {
	.console_tty      = 0,			/* ttyS0 */
	.nr_tty           = 2,
	.tty_map          = {3, 0, -1, -1}	/* ttyS0, ..., ttyS3 */
};

/******************************************************************************
* USB host
******************************************************************************/
static struct at91_usbh_data __initdata pm9261_usbh_data = {
	.ports      = 2,
};

/******************************************************************************
* USB device (Gadget)
******************************************************************************/
static struct at91_udc_data __initdata pm9261_udc_data = {
	.vbus_pin   = AT91_PIN_PA15,
	.pullup_pin = 0,		/* Pull driven by UDC IP */
};


/******************************************************************************
*  DM9000 ethernet device
******************************************************************************/
#if defined(CONFIG_DM9000) || defined(CONFIG_DM9000_MODULE)

#include <linux/dm9000.h>

#define AT91C_EBI_CS2 (0x30000000)	// EBI Chip Select 2 base address

static struct resource dm9000_resource[] = {
	[0] = {
		.start = AT91C_EBI_CS2,
		.end   = AT91C_EBI_CS2 + 3,
		.flags = IORESOURCE_MEM
	},
	[1] = {
		.start = AT91C_EBI_CS2 + 4,
		.end   = AT91C_EBI_CS2 + 7,
		.flags = IORESOURCE_MEM
	},
	[2] = {
		.start = AT91_PIN_PA24,
		.end   = AT91_PIN_PA24,
		.flags = IORESOURCE_IRQ
	}
};

/*
* for the moment we limit ourselves to 16bit IO until some
* better IO routines can be written and tested
*/
struct dm9000_plat_data dm9000_platdata = {
        .flags          = DM9000_PLATF_16BITONLY,
};

static struct platform_device dm9000_device = {
	.name           = "dm9000",
	.id             = 0,
	.num_resources  = ARRAY_SIZE(dm9000_resource),
	.resource       = dm9000_resource,
	.dev            = {
		.platform_data 	= &dm9000_platdata,
	}
};

/*
* SMC Chip Select 2 Timmings for DM9000A (davicom).
* These timmings were calculated for MASTER_CLOCK = 119808000
* according to DM9000A timmings. Refer to SMC user interface
* in AT91SAM9261 datasheet to learn how to regenerate these
* values in case MASTER_CLOCK changes.
*/

#define AT91_DM9000_NWE_SETUP		(4 << 0)
#define AT91_DM9000_NCS_WR_SETUP	(2 << 8)
#define AT91_DM9000_NRD_SETUP		(4 << 16)
#define AT91_DM9000_NCS_RD_SETUP	(2 << 24)

#define AT91_DM9000_NWE_PULSE		(8 << 0)
#define AT91_DM9000_NCS_WR_PULSE	(16 << 8)
#define AT91_DM9000_NRD_PULSE		(8 << 16)
#define AT91_DM9000_NCS_RD_PULSE	(16 << 24)

#define AT91_DM9000_NWE_CYCLE		(32 << 0)
#define AT91_DM9000_NRD_CYCLE		(32 << 16)

#define AT91_DM9000_TDF			(1 << 16)

static void __init pm9261_add_device_dm9000(void)
{
	printk("at91_add_device_dm9000 SMC & PIO initialisation\n");

	// Configure SMC CS2 for DM9000
	at91_sys_write(AT91_SMC_SETUP(2), \
			(	AT91_DM9000_NWE_SETUP |
				AT91_DM9000_NCS_WR_SETUP |
				AT91_DM9000_NRD_SETUP |
				AT91_DM9000_NCS_RD_SETUP));

	at91_sys_write(AT91_SMC_PULSE(2), \
			(	AT91_DM9000_NWE_PULSE |
				AT91_DM9000_NCS_WR_PULSE |
				AT91_DM9000_NRD_PULSE |
				AT91_DM9000_NCS_RD_PULSE));

	at91_sys_write(AT91_SMC_CYCLE(2), \
			(	AT91_DM9000_NWE_CYCLE |
				AT91_DM9000_NRD_CYCLE));

	at91_sys_write(AT91_SMC_MODE(2), \
			(	AT91_SMC_READMODE |
				AT91_SMC_WRITEMODE |
				AT91_SMC_EXNWMODE_DISABLE |
				AT91_SMC_BAT_WRITE |
				AT91_SMC_DBW_16 |
				AT91_DM9000_TDF));

	// Configure Interrupt pin in input, no pull-up
	at91_set_gpio_input (AT91_PIN_PA24, 0);

	platform_device_register(&dm9000_device);
}
#else
static void __init pm9261_add_device_dm9000() {}
#endif /* CONFIG_DM9000 */

#if defined(CONFIG_MTD_NAND_AT91) || defined(CONFIG_MTD_NAND_AT91_MODULE)
static struct mtd_partition __initdata pm9261_nand_partition[] = {
	{
		.name	= "nand",
		.offset	= 0,
		.size	= MTDPART_SIZ_FULL,
	},
};

static struct mtd_partition *pm9261_nand_partitions(int size, int *num_partitions)
{
	*num_partitions = ARRAY_SIZE(pm9261_nand_partition);
	return pm9261_nand_partition;
}

static struct at91_nand_data __initdata pm9261_nand_data = {
	.ale		= 22,
	.cle		= 21,
//	.det_pin	= AT91_PIN_PB1,		// smart media detect pin
	.rdy_pin	= AT91_PIN_PA16,
	.enable_pin	= AT91_PIN_PC14,
	.partition_info	= pm9261_nand_partitions,
#if defined(CONFIG_MTD_NAND_AT91_BUSWIDTH_16)
	.bus_width_16	= 1,
#else
	.bus_width_16	= 0,
#endif
};
#endif

#if defined(CONFIG_AT91_CF) || defined(CONFIG_AT91_CF_MODULE)

static struct at91_cf_data pm9261_cf_data = {
	.det_pin	= AT91_PIN_PA23,
//	.rst_pin	= no,
	.irq_pin	= AT91_PIN_PA25,
	// .vcc_pin	= ... always powered
	.chipselect	= 4,
};

static struct resource pm9261_cf_resources[] = {
	[0] = {
		.start	= AT91_CHIPSELECT_4,
		.end	= AT91_CHIPSELECT_4 + (0x10000000 - 1),
		.flags	= IORESOURCE_MEM | IORESOURCE_MEM_8AND16BIT,
	},
};

static struct platform_device pm9261_cf_device = {
	.name		= "at91_cf",
	.id		= -1,
	.dev		= {
		.platform_data	= &pm9261_cf_data,
	},
	.resource	= pm9261_cf_resources,
	.num_resources	= ARRAY_SIZE(pm9261_cf_resources),
};

#if 1
#if 0
/* Timings for IDE Interface
 *
 * SETUP / LENGTH / HOLD - cycles valid for 50 MHz clk
 * 70	   165	    30	   PIO-Mode 0, [ns]
 *  4	     9	     2		       [Cycles]
 * 50	   125	    20	   PIO-Mode 1, [ns]
 *  3	     7	     2		       [Cycles]
 * 30	   100	    15	   PIO-Mode 2, [ns]
 *  2	     6	     1		       [Cycles]
 * 30	    80	    10	   PIO-Mode 3, [ns]
 *  2	     5	     1		       [Cycles]
 * 25	    70	    10	   PIO-Mode 4, [ns]
 *  2	     4	     1		       [Cycles]
 */
#endif
#define CF_NWE_SETUP	(10 << 0)
#define CF_NCS_WR_SETUP	(10 << 8)
#define CF_NRD_SETUP	(10 << 16)
#define CF_NCS_RD_SETUP	(10 << 24)

#define CF_NWE_PULSE 	(11 << 0)
#define CF_NCS_WR_PULSE	(11 << 8)
#define CF_NRD_PULSE	(11 << 16)
#define CF_NCS_RD_PULSE	(11 << 24)

#define CF_NWE_CYCLE 	(16 << 0)
#define CF_NRD_CYCLE	(16 << 16)

#define CF_TDF		(0x16 << 16)

#else

#define CF_NWE_SETUP	(10 << 0)
#define CF_NCS_WR_SETUP	(10 << 8)
#define CF_NRD_SETUP	(10 << 16)
#define CF_NCS_RD_SETUP	(10 << 24)

#define CF_NWE_PULSE 	(11 << 0)
#define CF_NCS_WR_PULSE	(11 << 8)
#define CF_NRD_PULSE	(11 << 16)
#define CF_NCS_RD_PULSE	(11 << 24)

#define CF_NWE_CYCLE 	(16 << 0)
#define CF_NRD_CYCLE	(16 << 16)

#define CF_TDF		(0x16 << 16)
#endif

static void __init pm9261_add_device_cf(void) {
struct at91_cf_data *data = & pm9261_cf_data;
unsigned int csa;

	// Setup Compact flash, first enable the address range of
	// CS4 in HMATRIX user interface
	csa = at91_sys_read (AT91_MATRIX_EBICSA);
	at91_sys_write (AT91_MATRIX_EBICSA, csa | AT91_MATRIX_CS4A_SMC_CF1);

	/* Configure SMC CS4 */
	at91_sys_write (AT91_SMC_SETUP(4),
				(CF_NWE_SETUP |
				CF_NCS_WR_SETUP |
				CF_NRD_SETUP |
				CF_NCS_RD_SETUP));

	at91_sys_write (AT91_SMC_PULSE(4), (CF_NWE_PULSE |
					CF_NCS_WR_PULSE |
					CF_NRD_PULSE |
					CF_NCS_RD_PULSE));
	at91_sys_write (AT91_SMC_CYCLE(4),
			(CF_NWE_CYCLE | CF_NRD_CYCLE));
	// 16 bit
	at91_sys_write (AT91_SMC_MODE(4), (AT91_SMC_READMODE |
					AT91_SMC_WRITEMODE |
					AT91_SMC_EXNWMODE_DISABLE |
					AT91_SMC_DBW_16 |
					AT91_SMC_BAT_WRITE |
					CF_TDF));

	// Clock PIOC
//	at91_sys_write (AT91_PMC_PCER, 1 << AT91_ID_PIOC);
//	at91_sys_write (AT91_PMC_PCER, 1 << AT91_ID_PIOA);

	/* input/irq */
	if (data-> irq_pin) {
		at91_set_gpio_input (data-> irq_pin, 0);
		at91_set_deglitch (data-> irq_pin, 1);
	}
	at91_set_gpio_input (data-> det_pin, 0);
	at91_set_deglitch (data-> det_pin, 1);

	/* outputs, initially off */
	if (data-> vcc_pin)
		at91_set_gpio_output (data-> vcc_pin, 0);
	if (data->rst_pin)
		at91_set_gpio_output (data->rst_pin, 0);

	/* force poweron defaults for these pins ... */
	at91_set_A_periph (AT91_PIN_PC2, 1);	/* PC2/CF_NWAIT */
	at91_set_A_periph (AT91_PIN_PC3, 0);	/* A25/CFRNW */
	at91_set_A_periph (AT91_PIN_PC4, 0);	/* NCS4/CFCS0 */
	at91_set_A_periph (AT91_PIN_PC6, 0);	/* PC6/CFCE1 */
	at91_set_A_periph (AT91_PIN_PC7, 0);	/* PC7/CFCE2 */

	// not used
//	at91_set_A_periph (AT91_PIN_PA12, 0);	/* PA12/CF_BVD2 */
//	at91_set_A_periph (AT91_PIN_PA11, 0);	/* PA11/CF_BVD1 */
//	at91_set_A_periph (AT91_PIN_PA26, 0);	/* PA26/CF_INPACK_N */

	platform_device_register (& pm9261_cf_device);
}
#else
void __init pm9261_add_device_cf(void) {}
#endif

#if (defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)) && \
(!(defined(CONFIG_SPI_ATMEL) || defined(CONFIG_SPI_ATMEL_MODULE)))
static struct at91_mmc_data __initdata pm9261_mmc_data = {
	.slot_b		= 0,
	.wire4		= 1,
	.det_pin	= 0,//AT91_PIN_PA6,
	.wp_pin		= 0,
};
#endif

/* --------------------------------------------------------------------
 *  SPI
 * -------------------------------------------------------------------- */

#if defined(CONFIG_SPI_ATMEL) || defined(CONFIG_SPI_ATMEL_MODULE)
static u64 spi_dmamask = 0xffffffffUL;

static struct resource at91_spi_resources[] = {
	[0] = {
		.start	= AT91SAM9261_BASE_SPI0,
		.end	= AT91SAM9261_BASE_SPI0 + SZ_16K - 1,
		.flags	= IORESOURCE_MEM,
	},
	[1] = {
		.start	= AT91SAM9261_ID_SPI0,
		.end	= AT91SAM9261_ID_SPI0,
		.flags	= IORESOURCE_IRQ,
	},
};

static struct platform_device pm9261_spi_device = {
	.name		= "atmel_spi",
	.id		= 0,
	.dev		= {
		.dma_mask		= &spi_dmamask,
		.coherent_dma_mask	= 0xffffffff,
	},
	.resource	= at91_spi_resources,
	.num_resources	= ARRAY_SIZE(at91_spi_resources),
};

static const unsigned at91_spi_standard_cs[4] =
{ AT91_PIN_PA3, AT91_PIN_PA27, AT91_PIN_PA28, AT91_PIN_PA6 };
static const unsigned at91_spi_standard_cs_perif[4] =
{            1,             2,             2,            1 };

//#if defined(CONFIG_TOUCHSCREEN_TSC2301) || defined(CONFIG_TOUCHSCREEN_TSC2301_MODULE)
#if defined(CONFIG_SPI_PM9261_TSC2301) || defined(CONFIG_SPI_PM9261_TSC2301_MODULE)
static struct tsc2301_platform_data tsc2301_data = {
	.x_plate_ohms = 250,
};
#endif

static struct spi_board_info pm9261_spi_devices[] = {
	{	/* DataFlash chip */
		.modalias	= "mtd_dataflash",
		.chip_select	= 0,
		.max_speed_hz	= 15 * 1000 * 1000,
		.bus_num	= 0,
	},
#if defined(CONFIG_SPI_PM9261_TSC2301) || defined(CONFIG_SPI_PM9261_TSC2301_MODULE)
	{	/* TSC2301PAG - touchscreen,sound */
		.modalias	= "pm9261_tsc2301_spi",
		.chip_select	= 2,
		.max_speed_hz	= 2 * 1000 * 1000,
		.bus_num	= 0,
		.platform_data  = & tsc2301_data,
		.irq		= AT91_PIN_PB29,
	},
#endif
#if defined(CONFIG_MMC_SPI) || defined(CONFIG_MMC_SPI_MODULE)
	{	/* SPI MMC card */
		.modalias	= "mmc_spi",
		.chip_select	= 3,
		.max_speed_hz	= 20 * 1000 * 1000,
		.bus_num	= 0,
		.irq		= 0,
	},
#endif
};

void __init pm9261_add_device_spi(void)
{
	int i;
	unsigned long cs_pin, cs_perif;
	struct spi_board_info *devices = pm9261_spi_devices;
	int nr_devices = ARRAY_SIZE(pm9261_spi_devices);

#if defined(CONFIG_SPI_ATMEL) || defined(CONFIG_SPI_ATMEL_MODULE)
#else
	at91_set_A_periph(AT91_PIN_PA0, 0);	/* MISO */
	at91_set_A_periph(AT91_PIN_PA1, 0);	/* MOSI */
	at91_set_A_periph(AT91_PIN_PA2, 0);	/* SPCK */
#endif
	/* Enable SPI chip-selects */
	for (i = 0; i < nr_devices; i++) {
		if (devices[i].controller_data) {
			cs_pin = (unsigned long) devices[i].controller_data;
			cs_perif = 1;
		} else {
			cs_pin = at91_spi_standard_cs[devices[i].chip_select];
			cs_perif = at91_spi_standard_cs_perif[devices[i].chip_select];
		}
#if 1 //defined(CONFIG_SPI_AT91_MANUAL_CS)
		at91_set_gpio_output(cs_pin, 1);
#else
		if (cs_perif == 1) {
			at91_set_A_periph(cs_pin, 0);
		} else {
			at91_set_B_periph(cs_pin, 0);
		}
#endif

		/* pass chip-select pin to driver */
		devices[i].controller_data = (void *) cs_pin;
	}

	spi_register_board_info(devices, nr_devices);
	at91_clock_associate("spi0_clk", &pm9261_spi_device.dev, "spi_clk");
	platform_device_register(&pm9261_spi_device);
}
#else
void __init pm9261_add_device_spi(void) {}
#endif


/******************************************************************************
* Init
******************************************************************************/
static void __init pm9261_map_io(void)
{
	printk(KERN_INFO "AT91 pm9261_map_io\n");

	/* Initialize processor: 18.432 MHz crystal */
	at91sam9261_initialize(18432000);

	/* Setup the serial ports and console */
	at91_init_serial(&pm9261_uart_config);
}

static void __init pm9261_board_init(void)
{
	/* Serial */
	at91_add_device_serial();

	/* USB host */
	at91_add_device_usbh(&pm9261_usbh_data);

	/* USB Device */
	at91_add_device_udc(&pm9261_udc_data);

	/* DM9000 Ethernet controller */
	pm9261_add_device_dm9000();

	/* flash access init */
	// Configure SMC CS0 for flash
	printk("pm9261_flash_access_init\n");
	at91_sys_write(AT91_SMC_SETUP(0), 0x0A0A0A0A);
	at91_sys_write(AT91_SMC_PULSE(0), 0x0B0B0B0B);
	at91_sys_write(AT91_SMC_CYCLE(0), 0x00160016);
	at91_sys_write(AT91_SMC_MODE(0), 0x00161003);

#if defined(CONFIG_MTD_NAND_AT91) || defined(CONFIG_MTD_NAND_AT91_MODULE)
	/* NAND (SmartMedia) */
	at91_add_device_nand (& pm9261_nand_data);
#endif

	/* LCD Controlec */
	pm9261_add_device_lcdc ();

	/* Compact flash */
	pm9261_add_device_cf ();

#if defined(CONFIG_SPI_ATMEL) || defined(CONFIG_SPI_ATMEL_MODULE)
	pm9261_add_device_spi ();
#else
#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
	/* MMC */
	at91_add_device_mmc(&pm9261_mmc_data);
#endif
#endif
}

MACHINE_START(PM9261, "Ronetix PM9261")
	/* Maintainer: Ronetix */
	.phys_io       = AT91_BASE_SYS,
	.io_pg_offst   = (AT91_VA_BASE_SYS >> 18) & 0xfffc,
	.boot_params   = AT91_SDRAM_BASE + 0x100,
	.timer         = & at91sam926x_timer,
	.map_io        = pm9261_map_io,
	.init_irq      = pm9261_init_irq,
	.init_machine  = pm9261_board_init,
MACHINE_END

--------------030300050800070004060401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------030300050800070004060401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------030300050800070004060401--
