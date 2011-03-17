From: InKi Dae <daeinki@gmail.com>
Date: Thu, 17 Mar 2011 09:06:07 +0000
Subject: Re: [PATCH 2/2] s5pc110: add MIPI-DSI controller driver.
Message-Id: <AANLkTikHE2mSrJTNhwtrzj_dA3mPxpVHCHSYbtsyGf3m@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294223752-31896-1-git-send-email-inki.dae@samsung.com>
	<00b001cbe47f$5f6894e0$1e39bea0$%kim@samsung.com>
In-Reply-To: <00b001cbe47f$5f6894e0$1e39bea0$%kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

2011/3/17 Kukjin Kim <kgene.kim@samsung.com>:
> Inki Dae wrote:
>>
>> S5PC110 and S5PC210 SoC platform have one or two MIPI-DSI controller.
>> MIPI-DSI controller can be used to connect MIPI-DSI based LCD Panel.
>> this patch adds MIPI-DSI controller driver.
>>
>> to use this driver, MIPI-DSI based LCD panel driver have to register
>> mipi_dsim_lcd_driver object to MIPI-DSI driver and then when MIPI-DSI
>> driver is probed, probe callback of LCD panel driver registered would
>> be called.
>>
>> Signed-off-by: Inki Dae <inki.dae@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> =A0arch/arm/plat-s5p/include/plat/dsim.h =A0 =A0 =A0| =A0357 +++++++++++=
+++++
>> =A0arch/arm/plat-s5p/include/plat/regs-dsim.h | =A0141 ++++++
>> =A0drivers/video/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A07 +
>> =A0drivers/video/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A02 +
>> =A0drivers/video/s5p_mipi_dsi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0428 +++=
++++++++++++++++
>> =A0drivers/video/s5p_mipi_dsi_common.c =A0 =A0 =A0 =A0| =A0635
>> ++++++++++++++++++++++++++++
>> =A0drivers/video/s5p_mipi_dsi_common.h =A0 =A0 =A0 =A0| =A0 38 ++
>> =A0drivers/video/s5p_mipi_dsi_lowlevel.c =A0 =A0 =A0| =A0553
> ++++++++++++++++++++++++
>> =A0drivers/video/s5p_mipi_dsi_lowlevel.h =A0 =A0 =A0| =A0 98 +++++
>> =A09 files changed, 2259 insertions(+), 0 deletions(-)
>> =A0create mode 100644 arch/arm/plat-s5p/include/plat/dsim.h
>> =A0create mode 100644 arch/arm/plat-s5p/include/plat/regs-dsim.h
>> =A0create mode 100644 drivers/video/s5p_mipi_dsi.c
>> =A0create mode 100644 drivers/video/s5p_mipi_dsi_common.c
>> =A0create mode 100644 drivers/video/s5p_mipi_dsi_common.h
>> =A0create mode 100644 drivers/video/s5p_mipi_dsi_lowlevel.c
>> =A0create mode 100644 drivers/video/s5p_mipi_dsi_lowlevel.h
>>
> Hi,
>
> There are some comments.
>
> There is no reason why "dsim.h" is in plat directory because it includes
> everything but it has no dependency on platform. I think, if it is used on
> machine or platform, should be separated and how about mipi_dsim.h like
> plat/mipi_csis.h?
>
hm... ok, don't care. I will correct it to mipi_dsim.h like mipi_csis.h.

> I'm a little confusing for the word between "dsim" and "dsi". Would be
> better if you could use just one such as "csis".
>
> Is find_mipi_client_registered() used for finding LCD panel? If so, where
> does it look for it?
>
Yes, it does.
when init function of MIPI-DSI based lcd panel driver is called at
booting time, mipi_dsim_lcd_driver object of this lcd pane driver
would be registered to dsim_ddi_list of MIPI-DSI driver and then when
probe of MIPI-DSI driver is call, it would find its lcd panel driver
object registered to dsim_ddi_list using
find_mipi_cliend_registered(). also by using this architecture, we
could use other lcd panel drivers with MIPI-DSI driver.

> As you know, EXYNOS4210 has 2 MIPI DSI Master channels. So could you plea=
se
> let me know how to support it?
>
this driver was considered only for S5PV210 because we have no any
EXYNOS4210 machine with MIPI-DSI based lcd panel. we can increasingly
consider that in the future.

> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>> diff --git a/arch/arm/plat-s5p/include/plat/dsim.h b/arch/arm/plat-
>> s5p/include/plat/dsim.h
>> new file mode 100644
>> index 0000000..9aa5a93
>> --- /dev/null
>> +++ b/arch/arm/plat-s5p/include/plat/dsim.h
>> @@ -0,0 +1,357 @@
>> +/* linux/arm/arch/plat-s5p/include/plat/dsim.h
>> + *
>> + * Platform data header for Samsung SoC MIPI-DSIM.
>> + *
>> + * Copyright (c) 2009 Samsung Electronics
>> + * InKi Dae <inki.dae@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#ifndef _DSIM_H
>> +#define _DSIM_H
>> +
>> +#include <linux/device.h>
>> +#include <linux/fb.h>
>> +
>> +#define PANEL_NAME_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0(32)
>> +
>> +enum mipi_dsim_interface_type {
>> + =A0 =A0 DSIM_COMMAND,
>> + =A0 =A0 DSIM_VIDEO
>> +};
>> +
>> +enum mipi_dsim_virtual_ch_no {
>> + =A0 =A0 DSIM_VIRTUAL_CH_0,
>> + =A0 =A0 DSIM_VIRTUAL_CH_1,
>> + =A0 =A0 DSIM_VIRTUAL_CH_2,
>> + =A0 =A0 DSIM_VIRTUAL_CH_3
>> +};
>> +
>> +enum mipi_dsim_burst_mode_type {
>> + =A0 =A0 DSIM_NON_BURST_SYNC_EVENT,
>> + =A0 =A0 DSIM_NON_BURST_SYNC_PULSE =3D 2,
>> + =A0 =A0 DSIM_BURST,
>> + =A0 =A0 DSIM_NON_VIDEO_MODE
>> +};
>> +
>> +enum mipi_dsim_no_of_data_lane {
>> + =A0 =A0 DSIM_DATA_LANE_1,
>> + =A0 =A0 DSIM_DATA_LANE_2,
>> + =A0 =A0 DSIM_DATA_LANE_3,
>> + =A0 =A0 DSIM_DATA_LANE_4
>> +};
>> +
>> +enum mipi_dsim_byte_clk_src {
>> + =A0 =A0 DSIM_PLL_OUT_DIV8,
>> + =A0 =A0 DSIM_EXT_CLK_DIV8,
>> + =A0 =A0 DSIM_EXT_CLK_BYPASS
>> +};
>> +
>> +enum mipi_dsim_pixel_format {
>> + =A0 =A0 DSIM_CMD_3BPP,
>> + =A0 =A0 DSIM_CMD_8BPP,
>> + =A0 =A0 DSIM_CMD_12BPP,
>> + =A0 =A0 DSIM_CMD_16BPP,
>> + =A0 =A0 DSIM_VID_16BPP_565,
>> + =A0 =A0 DSIM_VID_18BPP_666PACKED,
>> + =A0 =A0 DSIM_18BPP_666LOOSELYPACKED,
>> + =A0 =A0 DSIM_24BPP_888
>> +};
>> +
>> +/**
>> + * struct mipi_dsim_config - interface for configuring mipi-dsi
> controller.
>> + *
>> + * @auto_flush: enable or disable Auto flush of MD FIFO using VSYNC
> pulse.
>> + * @eot_disable: enable or disable EoT packet in HS mode.
>> + * @auto_vertical_cnt: specifies auto vertical count mode.
>> + * =A0 in Video mode, the vertical line transition uses line counter
>> + * =A0 configured by VSA, VBP, and Vertical resolution.
>> + * =A0 If this bit is set to '1', the line counter does not use VSA and=
 VBP
>> + * =A0 registers.(in command mode, this variable is ignored)
>> + * @hse: set horizontal sync event mode.
>> + * =A0 In VSYNC pulse and Vporch area, MIPI DSI master transfers only H=
SYNC
>> + * =A0 start packet to MIPI DSI slave at MIPI DSI spec1.1r02.
>> + * =A0 this bit transfers HSYNC end packet in VSYNC pulse and Vporch ar=
ea
>> + * =A0 (in mommand mode, this variable is ignored)
>> + * @hfp: specifies HFP disable mode.
>> + * =A0 if this variable is set, DSI master ignores HFP area in VIDEO mo=
de.
>> + * =A0 (in command mode, this variable is ignored)
>> + * @hbp: specifies HBP disable mode.
>> + * =A0 if this variable is set, DSI master ignores HBP area in VIDEO mo=
de.
>> + * =A0 (in command mode, this variable is ignored)
>> + * @hsa: specifies HSA disable mode.
>> + * =A0 if this variable is set, DSI master ignores HSA area in VIDEO mo=
de.
>> + * =A0 (in command mode, this variable is ignored)
>> + * @e_interface: specifies interface to be used.(CPU or RGB interface)
>> + * @e_virtual_ch: specifies virtual channel number that main or
>> + * =A0 sub diaplsy uses.
>> + * @e_pixel_format: specifies pixel stream format for main or sub
> display.
>> + * @e_burst_mode: selects Burst mode in Video mode.
>> + * =A0 in Non-burst mode, RGB data area is filled with RGB data and NULL
>> + * =A0 packets, according to input bandwidth of RGB interface.
>> + * =A0 In Burst mode, RGB data area is filled with RGB data only.
>> + * @e_no_data_lane: specifies data lane count to be used by Master.
>> + * @e_byte_clk: select byte clock source. (it must be DSIM_PLL_OUT_DIV8)
>> + * =A0 DSIM_EXT_CLK_DIV8 and DSIM_EXT_CLK_BYPASSS are not supported.
>> + * @pll_stable_time: specifies the PLL Timer for stability of the
> ganerated
>> + * =A0 clock(System clock cycle base)
>> + * =A0 if the timer value goes to 0x00000000, the clock stable bit of
> status
>> + * =A0 and interrupt register is set.
>> + * @esc_clk: specifies escape clock frequency for getting the escape
> clock
>> + * =A0 prescaler value.
>> + * @stop_holding_cnt: specifies the interval value between transmitting
>> + * =A0 read packet(or write "set_tear_on" command) and BTA request.
>> + * =A0 after transmitting read packet or write "set_tear_on" command,
>> + * =A0 BTA requests to D-PHY automatically. this counter value specifies
>> + * =A0 the interval between them.
>> + * @bta_timeout: specifies the timer for BTA.
>> + * =A0 this register specifies time out from BTA request to change
>> + * =A0 the direction with respect to Tx escape clock.
>> + * @rx_timeout: specifies the timer for LP Rx mode timeout.
>> + * =A0 this register specifies time out on how long RxValid deasserts,
>> + * =A0 after RxLpdt asserts with respect to Tx escape clock.
>> + * =A0 - RxValid specifies Rx data valid indicator.
>> + * =A0 - RxLpdt specifies an indicator that D-PHY is under RxLpdt mode.
>> + * =A0 - RxValid and RxLpdt specifies signal from D-PHY.
>> + * @lcd_panel_info: pointer for lcd panel specific structure.
>> + * =A0 this structure specifies width, height, timing and polarity and =
so
> on.
>> + * @mipi_ddi_pd: pointer to lcd panel platform data.
>> + */
>> +struct mipi_dsim_config {
>> + =A0 =A0 unsigned char auto_flush;
>> + =A0 =A0 unsigned char eot_disable;
>> +
>> + =A0 =A0 unsigned char auto_vertical_cnt;
>> + =A0 =A0 unsigned char hse;
>> + =A0 =A0 unsigned char hfp;
>> + =A0 =A0 unsigned char hbp;
>> + =A0 =A0 unsigned char hsa;
>> +
>> + =A0 =A0 enum mipi_dsim_interface_type =A0 e_interface;
>> + =A0 =A0 enum mipi_dsim_virtual_ch_no =A0 =A0e_virtual_ch;
>> + =A0 =A0 enum mipi_dsim_pixel_format =A0 =A0 e_pixel_format;
>> + =A0 =A0 enum mipi_dsim_burst_mode_type =A0e_burst_mode;
>> + =A0 =A0 enum mipi_dsim_no_of_data_lane =A0e_no_data_lane;
>> + =A0 =A0 enum mipi_dsim_byte_clk_src =A0 =A0 e_byte_clk;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D>> + =A0 =A0 =A0* | =A0 =A0P =A0 =A0| =A0 =A0M =A0 =A0| =A0 =A0S =A0 =
=A0| =A0 =A0MHz =A0 =A0|
>> + =A0 =A0 =A0* -------------------------------------------
>> + =A0 =A0 =A0* | =A0 =A03 =A0 =A0| =A0 100 =A0 | =A0 =A03 =A0 =A0| =A0 =
=A0100 =A0 =A0|
>> + =A0 =A0 =A0* | =A0 =A03 =A0 =A0| =A0 100 =A0 | =A0 =A02 =A0 =A0| =A0 =
=A0200 =A0 =A0|
>> + =A0 =A0 =A0* | =A0 =A03 =A0 =A0| =A0 =A063 =A0 | =A0 =A01 =A0 =A0| =A0=
 =A0252 =A0 =A0|
>> + =A0 =A0 =A0* | =A0 =A04 =A0 =A0| =A0 100 =A0 | =A0 =A01 =A0 =A0| =A0 =
=A0300 =A0 =A0|
>> + =A0 =A0 =A0* | =A0 =A04 =A0 =A0| =A0 110 =A0 | =A0 =A01 =A0 =A0| =A0 =
=A0330 =A0 =A0|
>> + =A0 =A0 =A0* | =A0 12 =A0 =A0| =A0 350 =A0 | =A0 =A01 =A0 =A0| =A0 =A0=
350 =A0 =A0|
>> + =A0 =A0 =A0* | =A0 =A03 =A0 =A0| =A0 100 =A0 | =A0 =A01 =A0 =A0| =A0 =
=A0400 =A0 =A0|
>> + =A0 =A0 =A0* | =A0 =A04 =A0 =A0| =A0 150 =A0 | =A0 =A01 =A0 =A0| =A0 =
=A0450 =A0 =A0|
>> + =A0 =A0 =A0* | =A0 =A03 =A0 =A0| =A0 118 =A0 | =A0 =A01 =A0 =A0| =A0 =
=A0472 =A0 =A0|
>> + =A0 =A0 =A0* | =A0 12 =A0 =A0| =A0 250 =A0 | =A0 =A00 =A0 =A0| =A0 =A0=
500 =A0 =A0|
>> + =A0 =A0 =A0* | =A0 =A04 =A0 =A0| =A0 100 =A0 | =A0 =A00 =A0 =A0| =A0 =
=A0600 =A0 =A0|
>> + =A0 =A0 =A0* | =A0 =A03 =A0 =A0| =A0 =A081 =A0 | =A0 =A00 =A0 =A0| =A0=
 =A0648 =A0 =A0|
>> + =A0 =A0 =A0* | =A0 =A03 =A0 =A0| =A0 =A088 =A0 | =A0 =A00 =A0 =A0| =A0=
 =A0704 =A0 =A0|
>> + =A0 =A0 =A0* | =A0 =A03 =A0 =A0| =A0 =A090 =A0 | =A0 =A00 =A0 =A0| =A0=
 =A0720 =A0 =A0|
>> + =A0 =A0 =A0* | =A0 =A03 =A0 =A0| =A0 100 =A0 | =A0 =A00 =A0 =A0| =A0 =
=A0800 =A0 =A0|
>> + =A0 =A0 =A0* | =A0 12 =A0 =A0| =A0 425 =A0 | =A0 =A00 =A0 =A0| =A0 =A0=
850 =A0 =A0|
>> + =A0 =A0 =A0* | =A0 =A04 =A0 =A0| =A0 150 =A0 | =A0 =A00 =A0 =A0| =A0 =
=A0900 =A0 =A0|
>> + =A0 =A0 =A0* | =A0 12 =A0 =A0| =A0 475 =A0 | =A0 =A00 =A0 =A0| =A0 =A0=
950 =A0 =A0|
>> + =A0 =A0 =A0* | =A0 =A06 =A0 =A0| =A0 250 =A0 | =A0 =A00 =A0 =A0| =A0 1=
000 =A0 =A0|
>> + =A0 =A0 =A0* -------------------------------------------
>> + =A0 =A0 =A0*/
>> + =A0 =A0 unsigned char p;
>> + =A0 =A0 unsigned short m;
>> + =A0 =A0 unsigned char s;
>> +
>> + =A0 =A0 unsigned int pll_stable_time;
>> + =A0 =A0 unsigned long esc_clk;
>> +
>> + =A0 =A0 unsigned short stop_holding_cnt;
>> + =A0 =A0 unsigned char bta_timeout;
>> + =A0 =A0 unsigned short rx_timeout;
>> +
>> + =A0 =A0 void *lcd_panel_info;
>> + =A0 =A0 void *dsim_ddi_pd;
>> +};
>> +
>> +/**
>> + * struct mipi_dsim_device - global interface for mipi-dsi driver.
>> + *
>> + * @dev: driver model representation of the device.
>> + * @clock: pointer to MIPI-DSI clock of clock framework.
>> + * @irq: interrupt number to MIPI-DSI controller.
>> + * @reg_base: base address to memory mapped SRF of MIPI-DSI controller.
>> + * =A0 (virtual address)
>> + * @pd: pointer to MIPI-DSI driver platform data.
>> + * @dsim_info: infomation for configuring mipi-dsi controller.
>> + * @master_ops: callbacks to mipi-dsi operations.
>> + * @lcd_info: pointer to mipi_lcd_info structure.
>> + * @state: specifies status of MIPI-DSI controller.
>> + * =A0 the status could be RESET, INIT, STOP, HSCLKEN and ULPS.
>> + * @resume_complete: indicates whether resume operation is completed or
> not.
>> + * @data_lane: specifiec enabled data lane number.
>> + * =A0 this variable would be set by driver according to e_no_data_lane
>> + * =A0 automatically.
>> + * @e_clk_src: select byte clock source.
>> + * =A0 this variable would be set by driver according to e_byte_clock
>> + * =A0 automatically.
>> + * @hs_clk: HS clock rate.
>> + * =A0 this variable would be set by driver automatically.
>> + * @byte_clk: Byte clock rate.
>> + * =A0 this variable would be set by driver automatically.
>> + * @escape_clk: ESCAPE clock rate.
>> + * =A0 this variable would be set by driver automatically.
>> + * @freq_band: indicates Bitclk frequency band for D-PHY global timing.
>> + * =A0 Serial Clock(=3DByteClk X 8) =A0 =A0 =A0 =A0 =A0 =A0 =A0FreqBand=
[3:0]
>> + * =A0 =A0 =A0 =A0 =A0 ~ 99.99 MHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 0000
>> + * =A0 =A0 =A0 =A0 =A0 100 ~ 119.99 MHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A00001
>> + * =A0 =A0 =A0 =A0 =A0 120 ~ 159.99 MHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A00010
>> + * =A0 =A0 =A0 =A0 =A0 160 ~ 199.99 MHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A00011
>> + * =A0 =A0 =A0 =A0 =A0 200 ~ 239.99 MHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A00100
>> + * =A0 =A0 =A0 =A0 =A0 140 ~ 319.99 MHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A00101
>> + * =A0 =A0 =A0 =A0 =A0 320 ~ 389.99 MHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A00110
>> + * =A0 =A0 =A0 =A0 =A0 390 ~ 449.99 MHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A00111
>> + * =A0 =A0 =A0 =A0 =A0 450 ~ 509.99 MHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A01000
>> + * =A0 =A0 =A0 =A0 =A0 510 ~ 559.99 MHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A01001
>> + * =A0 =A0 =A0 =A0 =A0 560 ~ 639.99 MHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A01010
>> + * =A0 =A0 =A0 =A0 =A0 640 ~ 689.99 MHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A01011
>> + * =A0 =A0 =A0 =A0 =A0 690 ~ 769.99 MHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A01100
>> + * =A0 =A0 =A0 =A0 =A0 770 ~ 869.99 MHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A01101
>> + * =A0 =A0 =A0 =A0 =A0 870 ~ 949.99 MHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A01110
>> + * =A0 =A0 =A0 =A0 =A0 950 ~ 1000 MHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A01111
>> + * =A0 this variable would be calculated by driver automatically.
>> + */
>> +struct mipi_dsim_device {
>> + =A0 =A0 struct device *dev;
>> + =A0 =A0 struct resource *res;
>> + =A0 =A0 struct clk *clock;
>> + =A0 =A0 unsigned int irq;
>> + =A0 =A0 void __iomem *reg_base;
>> +
>> + =A0 =A0 struct s5p_platform_mipi_dsim *pd;
>> + =A0 =A0 struct mipi_dsim_config *dsim_config;
>> + =A0 =A0 struct mipi_dsim_master_ops *master_ops;
>> + =A0 =A0 struct mipi_dsim_ddi *dsim_ddi;
>> +
>> + =A0 =A0 unsigned int state;
>> + =A0 =A0 unsigned int resume_complete;
>> + =A0 =A0 unsigned int data_lane;
>> + =A0 =A0 enum mipi_dsim_byte_clk_src e_clk_src;
>> + =A0 =A0 unsigned long hs_clk;
>> + =A0 =A0 unsigned long byte_clk;
>> + =A0 =A0 unsigned long escape_clk;
>> + =A0 =A0 unsigned char freq_band;
>> +};
>> +
>> +/**
>> + * struct s5p_platform_mipi_dsim - interface to platform data
>> + * =A0 for mipi-dsi driver.
>> + *
>> + * @lcd_panel_name: specifies lcd panel name registered to mipi-dsi
> driver.
>> + * =A0 lcd panel driver searched would be actived.
>> + * @dsim_config: pointer of structure for configuring mipi-dsi
> controller.
>> + * @dsim_lcd_info: pointer to structure for configuring
>> + * =A0 mipi-dsi based lcd panel.
>> + * @mipi_power: callback pointer for enabling or disabling mipi power.
>> + * @part_reset: callback pointer for reseting mipi phy.
>> + * @init_d_phy: callback pointer for enabing d_phy of dsi master.
>> + * @get_fb_frame_done: callback pointer for getting frame done status of
> the
>> + * =A0 display controller(FIMD).
>> + * @trigger: callback pointer for triggering display controller(FIMD)
>> + * =A0 in case of CPU mode.
>> + * @delay_for_stabilization: specifies stable time.
>> + * =A0 this delay needs when writing data on SFR
>> + * =A0 after mipi mode became LP mode.
>> + */
>> +struct s5p_platform_mipi_dsim {
>> + =A0 =A0 char =A0 =A0lcd_panel_name[PANEL_NAME_SIZE];
>> +
>> + =A0 =A0 struct mipi_dsim_config *dsim_config;
>> + =A0 =A0 struct mipi_dsim_lcd_config *dsim_lcd_config;
>> +
>> + =A0 =A0 unsigned int delay_for_stabilization;
>> +
>> + =A0 =A0 int (*mipi_power) (struct mipi_dsim_device *dsim, unsigned int
> enable);
>> + =A0 =A0 int (*part_reset) (struct mipi_dsim_device *dsim);
>> + =A0 =A0 int (*init_d_phy) (struct mipi_dsim_device *dsim);
>> + =A0 =A0 int (*get_fb_frame_done) (struct fb_info *info);
>> + =A0 =A0 void (*trigger) (struct fb_info *info);
>> +};
>> +/**
>> + * struct mipi_dsim_master_ops - callbacks to mipi-dsi operations.
>> + *
>> + * @cmd_write: transfer command to lcd panel at LP mode.
>> + * @cmd_read: read command from rx register.
>> + * @get_dsim_frame_done: get the status that all screen data have been
>> + * =A0 transferred to mipi-dsi.
>> + * @clear_dsim_frame_done: clear frame done status.
>> + * @change_dsim_transfer_mode: change transfer mode to LP or HS mode.
>> + * =A0 - LP mode is used when commands data ard transferred to lcd pane=
l.
>> + * @get_fb_frame_done: get frame done status of display controller.
>> + * @trigger: trigger display controller.
>> + * =A0 - this one would be used only in case of CPU mode.
>> + */
>> +
>> +struct mipi_dsim_master_ops {
>> + =A0 =A0 int (*cmd_write) (struct mipi_dsim_device *dsim, unsigned int
> data_id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int data0, unsigned int data1);
>> + =A0 =A0 int (*cmd_read) (struct mipi_dsim_device *dsim, unsigned int
> data_id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int data0, unsigned int data1);
>> + =A0 =A0 int (*get_dsim_frame_done) (struct mipi_dsim_device *dsim);
>> + =A0 =A0 int (*clear_dsim_frame_done) (struct mipi_dsim_device *dsim);
>> +
>> + =A0 =A0 int (*change_dsim_transfer_mode) (struct mipi_dsim_device *dsi=
m,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 unsigned int mode);
>> +
>> + =A0 =A0 int (*get_fb_frame_done) (struct fb_info *info);
>> + =A0 =A0 void (*trigger) (struct fb_info *info);
>> +};
>> +
>> +/**
>> + * device structure for mipi-dsi based lcd panel.
>> + *
>> + * @dev: driver model representation of the device.
>> + * @id: id of device registered and when device is registered
>> + * =A0 id would be counted.
>> + * @modalias: name of the driver to use with this device, or an
>> + * =A0 alias for that name.
>> + * @mipi_lcd_drv: pointer of mipi_lcd_driver.
>> + * @master: pointer to dsim_device.
>> + */
>> +struct mipi_dsim_lcd_device {
>> + =A0 =A0 struct =A0device =A0dev;
>> + =A0 =A0 int =A0 =A0 id;
>> + =A0 =A0 char =A0 =A0modalias[64];
>> +
>> + =A0 =A0 struct mipi_dsim_lcd_driver =A0 =A0 *dsim_drv;
>> + =A0 =A0 struct mipi_dsim_device =A0 =A0 =A0 =A0 *master;
>> +};
>> +
>> +/**
>> + * driver structure for mipi-dsi based lcd panel.
>> + *
>> + * this structure should be registered by lcd panel driver.
>> + * mipi-dsi driver seeks lcd panel registered through name field
>> + * and calls these callback functions in appropriate time.
>> + */
>> +struct mipi_dsim_lcd_driver {
>> + =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0*name;
>> +
>> + =A0 =A0 int =A0 =A0 (*probe)(struct mipi_dsim_lcd_device *dsim_dev);
>> + =A0 =A0 int =A0 =A0 (*remove)(struct mipi_dsim_lcd_device *dsim_dev);
>> + =A0 =A0 void =A0 =A0(*shutdown)(struct mipi_dsim_lcd_device *dsim_dev);
>> + =A0 =A0 int =A0 =A0 (*suspend)(struct mipi_dsim_lcd_device *dsim_dev);
>> + =A0 =A0 int =A0 =A0 (*resume)(struct mipi_dsim_lcd_device *dsim_dev);
>> +};
>> +
>> +/**
>> + * register mipi_dsim_lcd_driver object defined by lcd panel driver
>> + * to mipi-dsi driver.
>> + */
>> +extern int s5p_mipi_dsi_register_lcd_driver(struct mipi_dsim_lcd_driver
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 *lcd_drv);
>> +
>> +#endif /* _DSIM_H */
>> diff --git a/arch/arm/plat-s5p/include/plat/regs-dsim.h b/arch/arm/plat-
>> s5p/include/plat/regs-dsim.h
>> new file mode 100644
>> index 0000000..7ef5a2f
>> --- /dev/null
>> +++ b/arch/arm/plat-s5p/include/plat/regs-dsim.h
>> @@ -0,0 +1,141 @@
>> +/* linux/arch/arm/plat-s5p/include/plat/regs-dsim.h
>> + *
>> + * Register definition file for Samsung MIPI-DSIM driver
>> + *
>> + * InKi Dae <inki.dae@samsung.com>, Copyright (c) 2009 Samsung
> Electronics
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#ifndef _REGS_DSIM_H
>> +#define _REGS_DSIM_H
>> +
>> +#define S5P_DSIM_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x0) =A0 /* Status =
register */
>> +#define S5P_DSIM_SWRST =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x4) =A0 /* Softwar=
e reset register
> */
>> +#define S5P_DSIM_CLKCTRL =A0 =A0 (0x8) =A0 /* Clock control register */
>> +#define S5P_DSIM_TIMEOUT =A0 =A0 (0xc) =A0 /* Time out register */
>> +#define S5P_DSIM_CONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x10) =A0/* Configu=
ration register */
>> +#define S5P_DSIM_ESCMODE =A0 =A0 (0x14) =A0/* Escape mode register */
>> +
>> +/* Main display image resolution register */
>> +#define S5P_DSIM_MDRESOL =A0 =A0 (0x18)
>> +#define S5P_DSIM_MVPORCH =A0 =A0 (0x1c) =A0/* Main display Vporch regis=
ter */
>> +#define S5P_DSIM_MHPORCH =A0 =A0 (0x20) =A0/* Main display Hporch regis=
ter */
>> +#define S5P_DSIM_MSYNC =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x24) =A0/* Main di=
splay sync area
>> register */
>> +
>> +/* Sub display image resolution register */
>> +#define S5P_DSIM_SDRESOL =A0 =A0 (0x28)
>> +#define S5P_DSIM_INTSRC =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x2c) =A0/* Interru=
pt source register
> */
>> +#define S5P_DSIM_INTMSK =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x30) =A0/* Interru=
pt mask register
> */
>> +#define S5P_DSIM_PKTHDR =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x34) =A0/* Packet =
Header FIFO
> register
>> */
>> +#define S5P_DSIM_PAYLOAD =A0 =A0 (0x38) =A0/* Payload FIFO register */
>> +#define S5P_DSIM_RXFIFO =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3c) =A0/* Read FI=
FO register */
>> +#define S5P_DSIM_FIFOTHLD =A0 =A0(0x40) =A0/* FIFO threshold level regi=
ster */
>> +#define S5P_DSIM_FIFOCTRL =A0 =A0(0x44) =A0/* FIFO status and control r=
egister
> */
>> +
>> +/* FIFO memory AC characteristic register */
>> +#define S5P_DSIM_PLLCTRL =A0 =A0 (0x4c) =A0/* PLL control register */
>> +#define S5P_DSIM_PLLTMR =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x50) =A0/* PLL tim=
er register */
>> +#define S5P_DSIM_PHYACCHR =A0 =A0(0x54) =A0/* D-PHY AC characteristic r=
egister
> */
>> +#define S5P_DSIM_PHYACCHR1 =A0 (0x58) =A0/* D-PHY AC characteristic reg=
ister1
> */
>> +
>> +/* DSIM_STATUS */
>> +#define DSIM_STOP_STATE_DAT(x) =A0 =A0 =A0 (((x) & 0xf) << 0)
>> +#define DSIM_STOP_STATE_CLK =A0(1 << 8)
>> +#define DSIM_TX_READY_HS_CLK (1 << 10)
>> +
>> +/* DSIM_SWRST */
>> +#define DSIM_FUNCRST =A0 =A0 =A0 =A0 (1 << 16)
>> +#define DSIM_SWRST =A0 =A0 =A0 =A0 =A0 (1 << 0)
>> +
>> +/* S5P_DSIM_TIMEOUT */
>> +#define DSIM_LPDR_TOUT_SHIFT (0)
>> +#define DSIM_BTA_TOUT_SHIFT =A0(16)
>> +
>> +/* S5P_DSIM_CLKCTRL */
>> +#define DSIM_LANE_ESC_CLKEN_SHIFT =A0 =A0(19)
>> +#define DSIM_BYTE_CLKEN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(24)
>> +#define DSIM_BYTE_CLK_SRC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0(25)
>> +#define DSIM_PLL_BYPASS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(27)
>> +#define DSIM_ESC_CLKEN_SHIFT =A0 =A0 =A0 =A0 (28)
>> +#define DSIM_TX_REQUEST_HSCLK_SHIFT =A0(31)
>> +#define DSIM_LANE_ESC_CLKEN(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((x) & 0x1f=
) << \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 DSIM_LANE_ESC_CLKEN_SHIFT)
>> +#define DSIM_BYTE_CLK_ENABLE =A0 =A0 =A0 =A0 (1 << DSIM_BYTE_CLKEN_SHIF=
T)
>> +#define DSIM_BYTE_CLK_DISABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0 << DSIM=
_BYTE_CLKEN_SHIFT)
>> +#define DSIM_PLL_BYPASS_EXTERNAL =A0 =A0 (1 << DSIM_PLL_BYPASS_SHIFT)
>> +#define DSIM_ESC_CLKEN_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << DSIM=
_ESC_CLKEN_SHIFT)
>> +#define DSIM_ESC_CLKEN_DISABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0 << DSIM_E=
SC_CLKEN_SHIFT)
>> +
>> +/* S5P_DSIM_CONFIG */
>> +#define DSIM_NUM_OF_DATALANE_SHIFT =A0 (5)
>> +#define DSIM_HSA_MODE_SHIFT =A0 =A0 =A0 =A0 =A0(20)
>> +#define DSIM_HBP_MODE_SHIFT =A0 =A0 =A0 =A0 =A0(21)
>> +#define DSIM_HFP_MODE_SHIFT =A0 =A0 =A0 =A0 =A0(22)
>> +#define DSIM_HSE_MODE_SHIFT =A0 =A0 =A0 =A0 =A0(23)
>> +#define DSIM_AUTO_MODE_SHIFT =A0 =A0 =A0 =A0 (24)
>> +#define DSIM_LANE_ENx(x) =A0 =A0 =A0 =A0 =A0 =A0 (((x) & 0x1f) << 0)
>> +
>> +#define DSIM_NUM_OF_DATA_LANE(x) =A0 =A0 ((x) << DSIM_NUM_OF_DATALANE_S=
HIFT)
>> +
>> +/* S5P_DSIM_ESCMODE */
>> +#define DSIM_TX_LPDT_SHIFT =A0 =A0 =A0 =A0 =A0 (6)
>> +#define DSIM_CMD_LPDT_SHIFT =A0 =A0 =A0 =A0 =A0(7)
>> +#define DSIM_TX_LPDT_LP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 <=
< DSIM_TX_LPDT_SHIFT)
>> +#define DSIM_CMD_LPDT_LP =A0 =A0 =A0 =A0 =A0 =A0 (1 << DSIM_CMD_LPDT_SH=
IFT)
>> +#define DSIM_STOP_STATE_CNT_SHIFT =A0 =A0(21)
>> +#define DSIM_FORCE_STOP_STATE_SHIFT =A0(20)
>> +
>> +/* S5P_DSIM_MDRESOL */
>> +#define DSIM_MAIN_STAND_BY =A0 =A0 =A0 =A0 =A0 (1 << 31)
>> +#define DSIM_MAIN_VRESOL(x) =A0 =A0 =A0 =A0 =A0(((x) & 0x7ff) << 16)
>> +#define DSIM_MAIN_HRESOL(x) =A0 =A0 =A0 =A0 =A0(((x) & 0X7ff) << 0)
>> +
>> +/* S5P_DSIM_MVPORCH */
>> +#define DSIM_CMD_ALLOW_SHIFT =A0 =A0 =A0 =A0 (28)
>> +#define DSIM_STABLE_VFP_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(16)
>> +#define DSIM_MAIN_VBP_SHIFT =A0 =A0 =A0 =A0 =A0(0)
>> +#define DSIM_CMD_ALLOW_MASK =A0 =A0 =A0 =A0 =A0(0xf << DSIM_CMD_ALLOW_S=
HIFT)
>> +#define DSIM_STABLE_VFP_MASK =A0 =A0 =A0 =A0 (0x7ff << DSIM_STABLE_VFP_=
SHIFT)
>> +#define DSIM_MAIN_VBP_MASK =A0 =A0 =A0 =A0 =A0 (0x7ff << DSIM_MAIN_VBP_=
SHIFT)
>> +
>> +/* S5P_DSIM_MHPORCH */
>> +#define DSIM_MAIN_HFP_SHIFT =A0 =A0 =A0 =A0 =A0(16)
>> +#define DSIM_MAIN_HBP_SHIFT =A0 =A0 =A0 =A0 =A0(0)
>> +#define DSIM_MAIN_HFP_MASK =A0 =A0 =A0 =A0 =A0 ((0xffff) << DSIM_MAIN_H=
FP_SHIFT)
>> +#define DSIM_MAIN_HBP_MASK =A0 =A0 =A0 =A0 =A0 ((0xffff) << DSIM_MAIN_H=
BP_SHIFT)
>> +
>> +/* S5P_DSIM_MSYNC */
>> +#define DSIM_MAIN_VSA_SHIFT =A0 =A0 =A0 =A0 =A0(22)
>> +#define DSIM_MAIN_HSA_SHIFT =A0 =A0 =A0 =A0 =A0(0)
>> +#define DSIM_MAIN_VSA_MASK =A0 =A0 =A0 =A0 =A0 ((0x3ff) << DSIM_MAIN_VS=
A_SHIFT)
>> +#define DSIM_MAIN_HSA_MASK =A0 =A0 =A0 =A0 =A0 ((0xffff) << DSIM_MAIN_H=
SA_SHIFT)
>> +
>> +/* S5P_DSIM_SDRESOL */
>> +#define DSIM_SUB_STANDY_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(31)
>> +#define DSIM_SUB_VRESOL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(16)
>> +#define DSIM_SUB_HRESOL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0)
>> +#define DSIM_SUB_STANDY_MASK =A0 =A0 =A0 =A0 ((0x1) << DSIM_SUB_STANDY_=
SHIFT)
>> +#define DSIM_SUB_VRESOL_MASK =A0 =A0 =A0 =A0 ((0x7ff) << DSIM_SUB_VRESO=
L_SHIFT)
>> +#define DSIM_SUB_HRESOL_MASK =A0 =A0 =A0 =A0 ((0x7ff) << DSIM_SUB_HRESO=
L_SHIFT)
>> +
>> +/* S5P_DSIM_INTSRC */
>> +#define INTSRC_FRAME_DONE =A0 =A0 =A0 =A0 =A0 =A0(1 << 24)
>> +#define INTSRC_PLL_STABLE =A0 =A0 =A0 =A0 =A0 =A0(1 << 31)
>> +
>> +/* S5P_DSIM_INTMSK */
>> +#define INTMSK_FRAME_DONE =A0 =A0 =A0 =A0 =A0 =A0(1 << 24)
>> +
>> +/* S5P_DSIM_FIFOCTRL */
>> +#define SFR_HEADER_EMPTY =A0 =A0 =A0 =A0 =A0 =A0 (1 << 22)
>> +
>> +/* S5P_DSIM_PHYACCHR */
>> +#define DSIM_AFC_CTL(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(((x=
) & 0x7) << 5)
>> +
>> +/* S5P_DSIM_PLLCTRL */
>> +#define DSIM_PLL_EN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0(23)
>> +#define DSIM_FREQ_BAND_SHIFT =A0 =A0 =A0 =A0 (24)
>> +
>> +#endif /* _REGS_DSIM_H */
>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>> index 932e7bb..9744e32 100644
>> --- a/drivers/video/Kconfig
>> +++ b/drivers/video/Kconfig
>> @@ -2098,6 +2098,13 @@ config FB_S3C2410_DEBUG
>> =A0 =A0 =A0 =A0 Turn on debugging messages. Note that you can set/unset =
at run
> time
>> =A0 =A0 =A0 =A0 through sysfs
>>
>> +config S5P_MIPI_DSI
>> + =A0 =A0 tristate "Samsung SoC MIPI-DSI support."
>> + =A0 =A0 depends on FB_S3C && ARCH_S5PV210
>> + =A0 =A0 default n
>> + =A0 =A0 ---help---
>> + =A0 =A0 =A0 This enables support for MIPI-DSI device.
>> +
>> =A0config FB_NUC900
>> =A0 =A0 =A0 =A0 =A0bool "NUC900 LCD framebuffer support"
>> =A0 =A0 =A0 =A0 =A0depends on FB && ARCH_W90X900
>> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
>> index 36aca21..12052a2 100644
>> --- a/drivers/video/Makefile
>> +++ b/drivers/video/Makefile
>> @@ -119,6 +119,8 @@ obj-$(CONFIG_FB_SH7760) =A0 =A0 =A0 =A0 =A0 =A0 +=3D=
 sh7760fb.o
>> =A0obj-$(CONFIG_FB_IMX) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D imxfb.o
>> =A0obj-$(CONFIG_FB_S3C) =A0 =A0 =A0 =A0 =A0 +=3D s3c-fb.o
>> =A0obj-$(CONFIG_FB_S3C2410) =A0 =A0 =A0 +=3D s3c2410fb.o
>> +obj-$(CONFIG_S5P_MIPI_DSI) =A0 =A0 +=3D s5p_mipi_dsi.o s5p_mipi_dsi_com=
mon.o \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s5p=
_mipi_dsi_lowlevel.o
>> =A0obj-$(CONFIG_FB_FSL_DIU) =A0 =A0 =A0 +=3D fsl-diu-fb.o
>> =A0obj-$(CONFIG_FB_COBALT) =A0 =A0 =A0 =A0 =A0 +=3D cobalt_lcdfb.o
>> =A0obj-$(CONFIG_FB_PNX4008_DUM) =A0 +=3D pnx4008/
>> diff --git a/drivers/video/s5p_mipi_dsi.c b/drivers/video/s5p_mipi_dsi.c
>> new file mode 100644
>> index 0000000..0bd9a44
>> --- /dev/null
>> +++ b/drivers/video/s5p_mipi_dsi.c
>> @@ -0,0 +1,428 @@
>> +/* linux/drivers/video/s5p_mipi_dsi.c
>> + *
>> + * Samsung SoC MIPI-DSIM driver.
>> + *
>> + * InKi Dae, <inki.dae@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/errno.h>
>> +#include <linux/clk.h>
>> +#include <linux/mutex.h>
>> +#include <linux/wait.h>
>> +#include <linux/fs.h>
>> +#include <linux/mm.h>
>> +#include <linux/fb.h>
>> +#include <linux/ctype.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/io.h>
>> +#include <linux/irq.h>
>> +#include <linux/memory.h>
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kthread.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/notifier.h>
>> +
>> +#include <plat/fb.h>
>> +#include <plat/regs-dsim.h>
>> +#include <plat/dsim.h>
>> +
>> +#include <mach/map.h>
>> +
>> +#include "s5p_mipi_dsi_common.h"
>> +
>> +#define master_to_driver(a) =A0(a->dsim_ddi->dsim_lcd_drv)
>> +#define master_to_device(a) =A0(a->dsim_ddi->dsim_lcd_dev)
>> +#define set_master_to_device(a) =A0 =A0 =A0(a->dsim_ddi->dsim_lcd_dev->=
master > a)
>> +
>> +struct mipi_dsim_ddi {
>> + =A0 =A0 struct list_head =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list;
>> + =A0 =A0 struct mipi_dsim_lcd_driver =A0 =A0 *dsim_lcd_drv;
>> + =A0 =A0 struct mipi_dsim_lcd_device =A0 =A0 *dsim_lcd_dev;
>> +};
>> +
>> +static LIST_HEAD(dsim_ddi_list);
>> +static DEFINE_MUTEX(mipi_lock);
>> +
>> +static struct s5p_platform_mipi_dsim *to_dsim_plat(struct platform_devi=
ce
>> *pdev)
>> +{
>> + =A0 =A0 return (struct s5p_platform_mipi_dsim *)pdev->dev.platform_dat=
a;
>> +}
>> +
>> +static irqreturn_t s5p_mipi_dsi_interrupt_handler(int irq, void *dev_id)
>> +{
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +int s5p_mipi_dsi_register_lcd_driver(struct mipi_dsim_lcd_driver
> *lcd_drv)
>> +{
>> + =A0 =A0 struct mipi_dsim_ddi *dsim_ddi;
>> + =A0 =A0 struct mipi_dsim_lcd_device *dsim_lcd_dev;
>> + =A0 =A0 static unsigned int id;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 dsim_ddi =3D kzalloc(sizeof(struct mipi_dsim_ddi), GFP_KERNEL);
>> + =A0 =A0 if (!dsim_ddi) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "failed to allocate dsim_ddi o=
bject.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dsim_ddi->dsim_lcd_drv =3D lcd_drv;
>> +
>> + =A0 =A0 dsim_lcd_dev =3D kzalloc(sizeof(struct mipi_dsim_lcd_device),
>> GFP_KERNEL);
>> + =A0 =A0 if (!dsim_lcd_dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "failed to allocate dsim_lcd_d=
ev
> object.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EFAULT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_dsim;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 mutex_lock(&mipi_lock);
>> +
>> + =A0 =A0 dsim_lcd_dev->id =3D id++;
>> + =A0 =A0 dsim_ddi->dsim_lcd_dev =3D dsim_lcd_dev;
>> +
>> + =A0 =A0 device_initialize(&dsim_lcd_dev->dev);
>> +
>> + =A0 =A0 strcpy(dsim_lcd_dev->modalias, lcd_drv->name);
>> +
>> + =A0 =A0 dev_set_name(&dsim_lcd_dev->dev, "mipi-dsi.%d\n", dsim_lcd_dev=
->id);
>> +
>> + =A0 =A0 ret =3D device_add(&dsim_lcd_dev->dev);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "can't %s %s, status %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "add", dev_nam=
e(&dsim_lcd_dev->dev), ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 id--;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_device_add;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 list_add_tail(&dsim_ddi->list, &dsim_ddi_list);
>> +
>> + =A0 =A0 mutex_unlock(&mipi_lock);
>> +
>> + =A0 =A0 printk(KERN_DEBUG "registered panel driver(%s) to mipi-dsi
> driver.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 lcd_drv->name);
>> +
>> + =A0 =A0 return ret;
>> +
>> +err_device_add:
>> + =A0 =A0 kfree(dsim_lcd_dev);
>> +
>> +err_dsim:
>> + =A0 =A0 kfree(dsim_ddi);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +/*
>> + * This function is a wrapper for changing transfer mode.
>> + * It is used for the panel driver before and after changing gamma valu=
e.
>> + */
>> +static int s5p_mipi_dsi_change_transfer_mode(struct mipi_dsim_device
> *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int mode)
>> +{
>> + =A0 =A0 if (mode < 0 || mode > 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->dev, "mode range should be 0 or =
1.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 s5p_mipi_dsi_set_data_transfer_mode(dsim, mode);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct mipi_dsim_ddi *find_mipi_client_registered
>> + =A0 =A0 =A0 =A0 =A0 =A0 (struct mipi_dsim_device *dsim, const char *na=
me)
>> +{
>> + =A0 =A0 struct mipi_dsim_ddi *dsim_ddi;
>> + =A0 =A0 struct mipi_dsim_lcd_driver *dsim_lcd_drv =3D NULL;
>> +
>> + =A0 =A0 mutex_lock(&mipi_lock);
>> +
>> + =A0 =A0 dev_dbg(dsim->dev, "find lcd panel driver(%s).\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 name);
>> +
>> + =A0 =A0 list_for_each_entry(dsim_ddi, &dsim_ddi_list, list) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim_lcd_drv =3D dsim_ddi->dsim_lcd_drv;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((strcmp(dsim_lcd_drv->name, name)) =3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&mipi_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev, "found!!!(%=
s).\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim_lcd_drv->=
name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return dsim_ddi;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dev_warn(dsim->dev, "failed to find lcd panel driver(%s).\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 name);
>> +
>> + =A0 =A0 mutex_unlock(&mipi_lock);
>> +
>> + =A0 =A0 return NULL;
>> +}
>> +
>> +/* define MIPI-DSI Master operations. */
>> +static struct mipi_dsim_master_ops master_ops =3D {
>> + =A0 =A0 .cmd_write =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D s5p_=
mipi_dsi_wr_data,
>> + =A0 =A0 .get_dsim_frame_done =A0 =A0 =A0 =A0 =A0 =A0> s5p_mipi_dsi_get=
_frame_done_status,
>> + =A0 =A0 .clear_dsim_frame_done =A0 =A0 =A0 =A0 =A0=3D s5p_mipi_dsi_cle=
ar_frame_done,
>> + =A0 =A0 .change_dsim_transfer_mode =A0 =A0 =A0=3D s5p_mipi_dsi_change_=
transfer_mode,
>> +};
>> +
>> +static int s5p_mipi_dsi_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 struct resource *res;
>> + =A0 =A0 struct mipi_dsim_device *dsim;
>> + =A0 =A0 struct mipi_dsim_config *dsim_config;
>> + =A0 =A0 struct s5p_platform_mipi_dsim *dsim_pd;
>> + =A0 =A0 int ret =3D -1;
>> +
>> + =A0 =A0 dsim =3D kzalloc(sizeof(struct mipi_dsim_device), GFP_KERNEL);
>> + =A0 =A0 if (!dsim) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to allocate dsim o=
bject.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dsim->pd =3D to_dsim_plat(pdev);
>> + =A0 =A0 dsim->dev =3D &pdev->dev;
>> + =A0 =A0 dsim->resume_complete =3D 0;
>> +
>> + =A0 =A0 /* get s5p_platform_mipi_dsim. */
>> + =A0 =A0 dsim_pd =3D (struct s5p_platform_mipi_dsim *)dsim->pd;
>> + =A0 =A0 /* get mipi_dsim_config. */
>> + =A0 =A0 dsim_config =3D dsim_pd->dsim_config;
>> + =A0 =A0 dsim->dsim_config =3D dsim_config;
>> + =A0 =A0 dsim->master_ops =3D &master_ops;
>> +
>> + =A0 =A0 dsim->clock =3D clk_get(&pdev->dev, "dsim");
>> + =A0 =A0 if (IS_ERR(dsim->clock)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get dsim clock =
source\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_clock_get;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 clk_enable(dsim->clock);
>> +
>> + =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + =A0 =A0 if (!res) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get io memory r=
egion\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_platform_get;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 res =3D request_mem_region(res->start, resource_size(res),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 dev_name(&pdev->dev));
>> + =A0 =A0 if (!res) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to request io memo=
ry region\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_mem_region;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dsim->res =3D res;
>> +
>> + =A0 =A0 dsim->reg_base =3D ioremap(res->start, resource_size(res));
>> + =A0 =A0 if (!dsim->reg_base) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to remap io region=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_mem_region;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* it uses frame done interrupt handler
>> + =A0 =A0 =A0* only in case of MIPI Video mode.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (dsim_config->e_interface =3D DSIM_VIDEO) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->irq =3D platform_get_irq(pdev, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (request_irq(dsim->irq, s5p_mipi_dsi_interr=
upt_handler,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_DISABLED,=
 "mipi-dsi", dsim)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "request_i=
rq failed.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_trigger_irq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (dsim->pd->mipi_power)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->pd->mipi_power(dsim, 1);
>> + =A0 =A0 else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "mipi_power is NULL.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_mipi_power;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* find lcd panel driver registered to mipi-dsi driver. */
>> + =A0 =A0 dsim->dsim_ddi =3D find_mipi_client_registered(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim_pd->lcd_p=
anel_name);
>> + =A0 =A0 if (dsim->dsim_config =3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "dsim_config is NULL.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_dsim_config;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* set dsim to master of mipi_dsim_lcd_device. */
>> + =A0 =A0 set_master_to_device(dsim);
>> +
>> + =A0 =A0 s5p_mipi_dsi_init_dsim(dsim);
>> + =A0 =A0 s5p_mipi_dsi_init_link(dsim);
>> +
>> + =A0 =A0 s5p_mipi_dsi_set_hs_enable(dsim);
>> + =A0 =A0 /* set cpu command transfer mode to hs. */
>> + =A0 =A0 s5p_mipi_dsi_set_data_transfer_mode(dsim, 0);
>> +
>> + =A0 =A0 /* initialize mipi-dsi client(lcd panel). */
>> + =A0 =A0 if (master_to_driver(dsim) && (master_to_driver(dsim))->probe)
>> + =A0 =A0 =A0 =A0 =A0 =A0 (master_to_driver(dsim))->probe(master_to_devi=
ce(dsim));
>> +
>> + =A0 =A0 /* it needs delay for stabilization */
>> + =A0 =A0 mdelay(dsim->pd->delay_for_stabilization);
>> +
>> + =A0 =A0 s5p_mipi_dsi_set_display_mode(dsim, dsim->dsim_config);
>> +
>> + =A0 =A0 /* set lcdc data transfer mode to hs. */
>> + =A0 =A0 s5p_mipi_dsi_set_data_transfer_mode(dsim, 1);
>> +
>> + =A0 =A0 /* in case of command mode, trigger. */
>> + =A0 =A0 if (dsim->dsim_config->e_interface =3D DSIM_COMMAND) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dsim_pd->trigger)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim_pd->trigger(registered_fb=
[0]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&pdev->dev, "trigger =
is null.\n");
>> + =A0 =A0 }
>> +
>> + =A0 =A0 platform_set_drvdata(pdev, dsim);
>> +
>> + =A0 =A0 dev_info(&pdev->dev, "mipi-dsi driver(%s mode) has been probed=
.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 (dsim_config->e_interface =3D DSIM_COMMAND) ?
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "CPU" : "RGB");
>> +
>> + =A0 =A0 return 0;
>> +
>> +err_dsim_config:
>> + =A0 =A0 dsim->pd->mipi_power(dsim, 0);
>> +
>> +err_mipi_power:
>> +err_trigger_irq:
>> + =A0 =A0 release_resource(dsim->res);
>> + =A0 =A0 kfree(dsim->res);
>> +
>> + =A0 =A0 iounmap((void __iomem *) dsim->reg_base);
>> +
>> +err_mem_region:
>> +err_platform_get:
>> + =A0 =A0 clk_disable(dsim->clock);
>> + =A0 =A0 clk_put(dsim->clock);
>> +
>> +err_clock_get:
>> + =A0 =A0 kfree(dsim);
>> +
>> + =A0 =A0 return ret;
>> +
>> +}
>> +
>> +static int __devexit s5p_mipi_dsi_remove(struct platform_device *pdev)
>> +{
>> + =A0 =A0 struct mipi_dsim_device *dsim =3D platform_get_drvdata(pdev);
>> + =A0 =A0 struct mipi_dsim_ddi *dsim_ddi =3D NULL;
>> +
>> + =A0 =A0 if (dsim->dsim_config->e_interface =3D DSIM_VIDEO)
>> + =A0 =A0 =A0 =A0 =A0 =A0 free_irq(dsim->irq, dsim);
>> +
>> + =A0 =A0 iounmap(dsim->reg_base);
>> +
>> + =A0 =A0 clk_disable(dsim->clock);
>> + =A0 =A0 clk_put(dsim->clock);
>> +
>> + =A0 =A0 release_resource(dsim->res);
>> + =A0 =A0 kfree(dsim->res);
>> +
>> + =A0 =A0 list_for_each_entry(dsim_ddi, &dsim_ddi_list, list)
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(dsim_ddi);
>> +
>> + =A0 =A0 kfree(dsim);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int s5p_mipi_dsi_suspend(struct platform_device *pdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_message_t state)
>> +{
>> + =A0 =A0 struct mipi_dsim_device *dsim =3D platform_get_drvdata(pdev);
>> +
>> + =A0 =A0 dsim->resume_complete =3D 0;
>> +
>> + =A0 =A0 if (master_to_driver(dsim) && (master_to_driver(dsim))->suspen=
d)
>> + =A0 =A0 =A0 =A0 =A0 =A0 (master_to_driver(dsim))->suspend(master_to_de=
vice(dsim));
>> +
>> + =A0 =A0 clk_disable(dsim->clock);
>> +
>> + =A0 =A0 if (dsim->pd->mipi_power)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->pd->mipi_power(dsim, 0);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int s5p_mipi_dsi_resume(struct platform_device *pdev)
>> +{
>> + =A0 =A0 struct mipi_dsim_device *dsim =3D platform_get_drvdata(pdev);
>> +
>> + =A0 =A0 if (dsim->pd->mipi_power)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->pd->mipi_power(dsim, 1);
>> +
>> + =A0 =A0 clk_enable(dsim->clock);
>> +
>> + =A0 =A0 s5p_mipi_dsi_init_dsim(dsim);
>> + =A0 =A0 s5p_mipi_dsi_init_link(dsim);
>> +
>> + =A0 =A0 s5p_mipi_dsi_set_hs_enable(dsim);
>> + =A0 =A0 /* set cpu command transfer mode to hs. */
>> + =A0 =A0 s5p_mipi_dsi_set_data_transfer_mode(dsim, 0);
>> +
>> + =A0 =A0 /* it needs delay for stabilization */
>> + =A0 =A0 mdelay(dsim->pd->delay_for_stabilization);
>> +
>> + =A0 =A0 if (master_to_driver(dsim) && (master_to_driver(dsim))->resume)
>> + =A0 =A0 =A0 =A0 =A0 =A0 (master_to_driver(dsim))->resume(master_to_dev=
ice(dsim));
>> +
>> + =A0 =A0 s5p_mipi_dsi_set_display_mode(dsim, dsim->dsim_config);
>> +
>> + =A0 =A0 /* set lcdc data transfer mode to hs. */
>> + =A0 =A0 s5p_mipi_dsi_set_data_transfer_mode(dsim, 1);
>> +
>> + =A0 =A0 dsim->resume_complete =3D 1;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +#else
>> +#define s5p_mipi_dsi_suspend NULL
>> +#define s5p_mipi_dsi_resume NULL
>> +#endif
>> +
>> +static struct platform_driver s5p_mipi_dsi_driver =3D {
>> + =A0 =A0 .probe =3D s5p_mipi_dsi_probe,
>> + =A0 =A0 .remove =3D __devexit_p(s5p_mipi_dsi_remove),
>> + =A0 =A0 .suspend =3D s5p_mipi_dsi_suspend,
>> + =A0 =A0 .resume =3D s5p_mipi_dsi_resume,
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "s5p-mipi-dsim",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
>> + =A0 =A0 },
>> +};
>> +
>> +static int s5p_mipi_dsi_register(void)
>> +{
>> + =A0 =A0 platform_driver_register(&s5p_mipi_dsi_driver);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void s5p_mipi_dsi_unregister(void)
>> +{
>> + =A0 =A0 platform_driver_unregister(&s5p_mipi_dsi_driver);
>> +}
>> +
>> +module_init(s5p_mipi_dsi_register);
>> +module_exit(s5p_mipi_dsi_unregister);
>> +
>> +MODULE_AUTHOR("InKi Dae <inki.dae@samsung.com>");
>> +MODULE_DESCRIPTION("Samusung MIPI-DSI driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/video/s5p_mipi_dsi_common.c
>> b/drivers/video/s5p_mipi_dsi_common.c
>> new file mode 100644
>> index 0000000..cb5c280
>> --- /dev/null
>> +++ b/drivers/video/s5p_mipi_dsi_common.c
>> @@ -0,0 +1,635 @@
>> +/* linux/drivers/video/s5p_mipi_dsi_common.c
>> + *
>> + * Samsung MIPI-DSI common driver.
>> + *
>> + * InKi Dae, <inki.dae@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/errno.h>
>> +#include <linux/mutex.h>
>> +#include <linux/wait.h>
>> +#include <linux/fs.h>
>> +#include <linux/mm.h>
>> +#include <linux/fb.h>
>> +#include <linux/ctype.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/io.h>
>> +#include <linux/memory.h>
>> +#include <linux/delay.h>
>> +#include <linux/kthread.h>
>> +
>> +#include <video/mipi_display.h>
>> +
>> +#include <plat/fb.h>
>> +#include <plat/regs-dsim.h>
>> +
>> +#include <mach/map.h>
>> +#include <plat/dsim.h>
>> +#include <plat/regs-dsim.h>
>> +
>> +#include "s5p_mipi_dsi_lowlevel.h"
>> +
>> +#define MHZ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1000 * 1000)
>> +#define FIN_HZ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (24 * MHZ)
>> +
>> +#define DFIN_PLL_MIN_HZ =A0 =A0 =A0 =A0 =A0 =A0 =A0(6 * MHZ)
>> +#define DFIN_PLL_MAX_HZ =A0 =A0 =A0 =A0 =A0 =A0 =A0(12 * MHZ)
>> +
>> +#define DFVCO_MIN_HZ =A0 =A0 =A0 =A0 (500 * MHZ)
>> +#define DFVCO_MAX_HZ =A0 =A0 =A0 =A0 (1000 * MHZ)
>> +
>> +#define TRY_GET_FIFO_TIMEOUT (5000 * 2)
>> +
>> +#define DSIM_ESCCLK_ON =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x0)
>> +#define DSIM_ESCCLK_OFF =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1)
>> +
>> +/* MIPI-DSIM status types. */
>> +enum {
>> + =A0 =A0 DSIM_STATE_INIT, =A0 =A0 =A0 =A0/* should be initialized. */
>> + =A0 =A0 DSIM_STATE_STOP, =A0 =A0 =A0 =A0/* CPU and LCDC are LP mode. */
>> + =A0 =A0 DSIM_STATE_HSCLKEN, =A0 =A0 /* HS clock was enabled. */
>> + =A0 =A0 DSIM_STATE_ULPS
>> +};
>> +
>> +/* define DSI lane types. */
>> +enum {
>> + =A0 =A0 DSIM_LANE_CLOCK =3D (1 << 0),
>> + =A0 =A0 DSIM_LANE_DATA0 =3D (1 << 1),
>> + =A0 =A0 DSIM_LANE_DATA1 =3D (1 << 2),
>> + =A0 =A0 DSIM_LANE_DATA2 =3D (1 << 3),
>> + =A0 =A0 DSIM_LANE_DATA3 =3D (1 << 4)
>> +};
>> +
>> +static unsigned int dpll_table[15] =3D {
>> + =A0 =A0 100, 120, 170, 220, 270,
>> + =A0 =A0 320, 390, 450, 510, 560,
>> + =A0 =A0 640, 690, 770, 870, 950 };
>> +
>> +static void s5p_mipi_dsi_long_data_wr(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int data0, unsigned int data1)
>> +{
>> + =A0 =A0 unsigned int data_cnt =3D 0, payload =3D 0;
>> +
>> + =A0 =A0 /* in case that data count is more then 4 */
>> + =A0 =A0 for (data_cnt =3D 0; data_cnt < data1; data_cnt +=3D 4) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* after sending 4bytes per one time,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* send remainder data less then 4.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((data1 - data_cnt) < 4) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((data1 - data_cnt) =3D 3) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 payload =3D *(=
u8 *)(data0 + data_cnt) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*(u8 =
*)(data0 + (data_cnt + 1))) << 8 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (*(u8 *)(data0 + (data_cnt + 2))) <<
> 16;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev, "count =3D =
3 payload
>> =3D %x, %x %x %x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 payload, *(u8 =
*)(data0 + data_cnt),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ (data_cnt + 1)),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ (data_cnt + 2)));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if ((data1 - data_cnt) =
=3D 2) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 payload =3D *(=
u8 *)(data0 + data_cnt) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (*(u8 *)(data0 + (data_cnt + 1))) <<
> 8;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "count =3D 2 p=
ayload =3D %x, %x %x\n", payload,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ data_cnt),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ (data_cnt + 1)));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if ((data1 - data_cnt) =
=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 payload =3D *(=
u8 *)(data0 + data_cnt);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_wr_tx_data(dsim, =
payload);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* send 4bytes per one time. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 payload =3D *(u8 *)(data0 + da=
ta_cnt) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*(u8 *)(data0=
 + (data_cnt + 1))) << 8 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*(u8 *)(data0=
 + (data_cnt + 2))) << 16 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*(u8 *)(data0=
 + (data_cnt + 3))) << 24;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "count =3D 4 p=
ayload =3D %x, %x %x %x %x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 payload, *(u8 =
*)(data0 + data_cnt),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ (data_cnt + 1)),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ (data_cnt + 2)),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ (data_cnt + 3)));
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_wr_tx_data(dsim, =
payload);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +}
>> +
>> +int s5p_mipi_dsi_wr_data(struct mipi_dsim_device *dsim, unsigned int
> data_id,
>> + =A0 =A0 unsigned int data0, unsigned int data1)
>> +{
>> + =A0 =A0 unsigned int timeout =3D TRY_GET_FIFO_TIMEOUT;
>> + =A0 =A0 unsigned long delay_val, udelay;
>> + =A0 =A0 unsigned int check_rx_ack =3D 0;
>> +
>> + =A0 =A0 if (dsim->state =3D DSIM_STATE_ULPS) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->dev, "state is ULPS.\n");
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 delay_val =3D MHZ / dsim->dsim_config->esc_clk;
>> + =A0 =A0 udelay =3D 10 * delay_val;
>> +
>> + =A0 =A0 mdelay(udelay);
>> +
>> + =A0 =A0 /* only if transfer mode is LPDT, wait SFR becomes empty. */
>> + =A0 =A0 if (dsim->state =3D DSIM_STATE_STOP) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 while (!(s5p_mipi_dsi_get_fifo_state(dsim) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SFR_HEADER_EMP=
TY)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((timeout--) > 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->=
dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "SRF header fifo is not empty.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 switch (data_id) {
>> + =A0 =A0 /* short packet types of packet types for command. */
>> + =A0 =A0 case MIPI_DSI_GENERIC_SHORT_WRITE_0_PARAM:
>> + =A0 =A0 case MIPI_DSI_GENERIC_SHORT_WRITE_1_PARAM:
>> + =A0 =A0 case MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM:
>> + =A0 =A0 case MIPI_DSI_DCS_SHORT_WRITE:
>> + =A0 =A0 case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
>> + =A0 =A0 case MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_wr_tx_header(dsim, data_id, data0=
, data1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (check_rx_ack)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* process response func shoul=
d be implemented */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 /* general command */
>> + =A0 =A0 case MIPI_DSI_COLOR_MODE_OFF:
>> + =A0 =A0 case MIPI_DSI_COLOR_MODE_ON:
>> + =A0 =A0 case MIPI_DSI_SHUTDOWN_PERIPHERAL:
>> + =A0 =A0 case MIPI_DSI_TURN_ON_PERIPHERAL:
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_wr_tx_header(dsim, data_id, data0=
, data1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (check_rx_ack)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* process response func shoul=
d be implemented. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 /* packet types for video data */
>> + =A0 =A0 case MIPI_DSI_V_SYNC_START:
>> + =A0 =A0 case MIPI_DSI_V_SYNC_END:
>> + =A0 =A0 case MIPI_DSI_H_SYNC_START:
>> + =A0 =A0 case MIPI_DSI_H_SYNC_END:
>> + =A0 =A0 case MIPI_DSI_END_OF_TRANSMISSION:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 /* short and response packet types for command */
>> + =A0 =A0 case MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM:
>> + =A0 =A0 case MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM:
>> + =A0 =A0 case MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM:
>> + =A0 =A0 case MIPI_DSI_DCS_READ:
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_clear_all_interrupt(dsim);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_wr_tx_header(dsim, data_id, data0=
, data1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* process response func should be implemented=
. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 /* long packet type and null packet */
>> + =A0 =A0 case MIPI_DSI_NULL_PACKET:
>> + =A0 =A0 case MIPI_DSI_BLANKING_PACKET:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 case MIPI_DSI_GENERIC_LONG_WRITE:
>> + =A0 =A0 case MIPI_DSI_DCS_LONG_WRITE:
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int size, data_cnt =3D 0, payload =3D=
 0;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 size =3D data1 * 4;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* if data count is less then 4, then send 3by=
tes data. =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (data1 < 4) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 payload =3D *(u8 *)(data0) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ 1) << 8 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ 2) << 16;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_wr_tx_data(dsim, =
payload);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev, "count =3D =
%d payload
>> =3D %x,%x %x %x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data1, payload,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ data_cnt),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ (data_cnt + 1)),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u8 *)(data0 =
+ (data_cnt + 2)));
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* in case that data count is more then 4 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_long_data_wr(dsim=
, data0, data1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* put data into header fifo */
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_wr_tx_header(dsim, data_id, data1=
 & 0xff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (data1 & 0xff00) >> 8);
>> +
>> + =A0 =A0 }
>> + =A0 =A0 if (check_rx_ack)
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* process response func should be implemented=
. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 /* packet typo for video data */
>> + =A0 =A0 case MIPI_DSI_PACKED_PIXEL_STREAM_16:
>> + =A0 =A0 case MIPI_DSI_PACKED_PIXEL_STREAM_18:
>> + =A0 =A0 case MIPI_DSI_PIXEL_STREAM_3BYTE_18:
>> + =A0 =A0 case MIPI_DSI_PACKED_PIXEL_STREAM_24:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (check_rx_ack)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* process response func shoul=
d be implemented. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "data id %x is not supported c=
urrent DSI spec.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_id);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_mipi_dsi_pll_on(struct mipi_dsim_device *dsim, unsigned int
> enable)
>> +{
>> + =A0 =A0 int sw_timeout;
>> +
>> + =A0 =A0 if (enable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 sw_timeout =3D 1000;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_clear_interrupt(dsim);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_enable_pll(dsim, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 while (1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sw_timeout--;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s5p_mipi_dsi_is_pll_stable=
(dsim))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sw_timeout =3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_enable_pll(dsim, 0);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +unsigned long s5p_mipi_dsi_change_pll(struct mipi_dsim_device *dsim,
>> + =A0 =A0 unsigned int pre_divider, unsigned int main_divider,
>> + =A0 =A0 unsigned int scaler)
>> +{
>> + =A0 =A0 unsigned long dfin_pll, dfvco, dpll_out;
>> + =A0 =A0 unsigned int i, freq_band =3D 0xf;
>> +
>> + =A0 =A0 dfin_pll =3D (FIN_HZ / pre_divider);
>> +
>> + =A0 =A0 if (dfin_pll < DFIN_PLL_MIN_HZ || dfin_pll > DFIN_PLL_MAX_HZ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev, "fin_pll range should be 6=
MHz ~
> 12MHz\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_enable_afc(dsim, 0, 0);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dfin_pll < 7 * MHZ)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_enable_afc(dsim, =
1, 0x1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (dfin_pll < 8 * MHZ)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_enable_afc(dsim, =
1, 0x0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (dfin_pll < 9 * MHZ)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_enable_afc(dsim, =
1, 0x3);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (dfin_pll < 10 * MHZ)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_enable_afc(dsim, =
1, 0x2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (dfin_pll < 11 * MHZ)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_enable_afc(dsim, =
1, 0x5);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_enable_afc(dsim, =
1, 0x4);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dfvco =3D dfin_pll * main_divider;
>> + =A0 =A0 dev_dbg(dsim->dev, "dfvco =3D %lu, dfin_pll =3D %lu, main_divi=
der > %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dfvco, dfin_pl=
l, main_divider);
>> + =A0 =A0 if (dfvco < DFVCO_MIN_HZ || dfvco > DFVCO_MAX_HZ)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev, "fvco range should be 500M=
Hz ~
> 1000MHz\n");
>> +
>> + =A0 =A0 dpll_out =3D dfvco / (1 << scaler);
>> + =A0 =A0 dev_dbg(dsim->dev, "dpll_out =3D %lu, dfvco =3D %lu, scaler =
=3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 dpll_out, dfvco, scaler);
>> +
>> + =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(dpll_table); i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dpll_out < dpll_table[i] * MHZ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 freq_band =3D i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dev_dbg(dsim->dev, "freq_band =3D %d\n", freq_band);
>> +
>> + =A0 =A0 s5p_mipi_dsi_pll_freq(dsim, pre_divider, main_divider, scaler);
>> +
>> + =A0 =A0 s5p_mipi_dsi_hs_zero_ctrl(dsim, 0);
>> + =A0 =A0 s5p_mipi_dsi_prep_ctrl(dsim, 0);
>> +
>> + =A0 =A0 /* Freq Band */
>> + =A0 =A0 s5p_mipi_dsi_pll_freq_band(dsim, freq_band);
>> +
>> + =A0 =A0 /* Stable time */
>> + =A0 =A0 s5p_mipi_dsi_pll_stable_time(dsim,
> dsim->dsim_config->pll_stable_time);
>> +
>> + =A0 =A0 /* Enable PLL */
>> + =A0 =A0 dev_dbg(dsim->dev, "FOUT of mipi dphy pll is %luMHz\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 (dpll_out / MHZ));
>> +
>> + =A0 =A0 return dpll_out;
>> +}
>> +
>> +int s5p_mipi_dsi_set_clock(struct mipi_dsim_device *dsim,
>> + =A0 =A0 unsigned int byte_clk_sel, unsigned int enable)
>> +{
>> + =A0 =A0 unsigned int esc_div;
>> + =A0 =A0 unsigned long esc_clk_error_rate;
>> +
>> + =A0 =A0 if (enable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->e_clk_src =3D byte_clk_sel;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Escape mode clock and byte clock source */
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_set_byte_clock_src(dsim, byte_clk=
_sel);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* DPHY, DSIM Link : D-PHY clock out */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (byte_clk_sel =3D DSIM_PLL_OUT_DIV8) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->hs_clk =3D s5p_mipi_dsi_=
change_pll(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->dsim_con=
fig->p, dsim->dsim_config->m,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->dsim_con=
fig->s);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dsim->hs_clk =3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->=
dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "failed to get hs clock.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->byte_clk =3D dsim->hs_cl=
k / 8;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_enable_pll_bypass=
(dsim, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_pll_on(dsim, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* DPHY : D-PHY clock out, DSIM link : externa=
l clock out */
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else if (byte_clk_sel =3D DSIM_EXT_CLK_DIV8)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "this project =
is not support \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 external clock=
 source for MIPI DSIM\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (byte_clk_sel =3D DSIM_EXT_CLK_BYPASS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "this project =
is not support \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 external clock=
 source for MIPI DSIM\n");
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* escape clock divider */
>> + =A0 =A0 =A0 =A0 =A0 =A0 esc_div =3D dsim->byte_clk / (dsim->dsim_confi=
g->esc_clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "esc_div =3D %d, byte_clk =3D =
%lu, esc_clk =3D %lu\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 esc_div, dsim->byte_clk,
> dsim->dsim_config->esc_clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((dsim->byte_clk / esc_div) >=3D (20 * MHZ)=
 ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dsim->byte_cl=
k / esc_div) >
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 dsim->dsim_config->esc_clk)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 esc_div +=3D 1;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->escape_clk =3D dsim->byte_clk / esc_div;
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "escape_clk =3D %lu, byte_clk =
=3D %lu, esc_div =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->escape_clk, dsim->byte_c=
lk, esc_div);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* enable escape clock. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_enable_byte_clock(dsim, DSIM_ESCC=
LK_ON);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* enable byte clk and escape clock */
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_set_esc_clk_prs(dsim, 1, esc_div);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* escape clock on lane */
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_enable_esc_clk_on_lane(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DSIM_LANE_CLOCK | dsim->data_=
lane), 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev, "byte clock is %luMHz\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dsim->byte_clk / MHZ));
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev, "escape clock that user's n=
eed is %lu\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dsim->dsim_config->esc_clk / =
MHZ));
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev, "escape clock divider is %x=
\n", esc_div);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dsim->dev, "escape clock is %luMHz\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((dsim->byte_clk / esc_div) / =
MHZ));
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((dsim->byte_clk / esc_div) > dsim->escape_=
clk) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 esc_clk_error_rate =3D dsim->e=
scape_clk /
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dsim->byte_cl=
k / esc_div);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev, "error rat=
e is %lu over.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (esc_clk_error=
_rate / 100));
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else if ((dsim->byte_clk / esc_div) < (dsim-=
>escape_clk))
> {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 esc_clk_error_rate =3D (dsim->=
byte_clk / esc_div) /
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->escape_c=
lk;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev, "error rat=
e is %lu under.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (esc_clk_error=
_rate / 100));
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_enable_esc_clk_on_lane(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DSIM_LANE_CLOCK | dsim->data_=
lane), 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_set_esc_clk_prs(dsim, 0, 0);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* disable escape clock. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_enable_byte_clock(dsim, DSIM_ESCC=
LK_OFF);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (byte_clk_sel =3D DSIM_PLL_OUT_DIV8)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_pll_on(dsim, 0);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_mipi_dsi_init_dsim(struct mipi_dsim_device *dsim)
>> +{
>> + =A0 =A0 if (dsim->pd->init_d_phy)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->pd->init_d_phy(dsim);
>> +
>> + =A0 =A0 dsim->state =3D DSIM_STATE_INIT;
>> +
>> + =A0 =A0 switch (dsim->dsim_config->e_no_data_lane) {
>> + =A0 =A0 case DSIM_DATA_LANE_1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->data_lane =3D DSIM_LANE_DATA0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case DSIM_DATA_LANE_2:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->data_lane =3D DSIM_LANE_DATA0 | DSIM_LAN=
E_DATA1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case DSIM_DATA_LANE_3:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->data_lane =3D DSIM_LANE_DATA0 | DSIM_LAN=
E_DATA1 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSIM_LANE_DATA2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case DSIM_DATA_LANE_4:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->data_lane =3D DSIM_LANE_DATA0 | DSIM_LAN=
E_DATA1 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSIM_LANE_DATA2 | DSIM_LANE_DA=
TA3;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dsim->dev, "data lane is invalid.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 };
>> +
>> + =A0 =A0 s5p_mipi_dsi_sw_reset(dsim);
>> + =A0 =A0 s5p_mipi_dsi_dp_dn_swap(dsim, 0);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_mipi_dsi_enable_frame_done_int(struct mipi_dsim_device *dsim,
>> + =A0 =A0 unsigned int enable)
>> +{
>> + =A0 =A0 /* enable only frame done interrupt */
>> + =A0 =A0 s5p_mipi_dsi_set_interrupt_mask(dsim, INTMSK_FRAME_DONE, enabl=
e);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_mipi_dsi_set_display_mode(struct mipi_dsim_device *dsim,
>> + =A0 =A0 struct mipi_dsim_config *dsim_config)
>> +{
>> + =A0 =A0 struct fb_videomode *lcd_video =3D NULL;
>> + =A0 =A0 struct s3c_fb_pd_win *pd;
>> + =A0 =A0 unsigned int width =3D 0, height =3D 0;
>> +
>> + =A0 =A0 pd =3D (struct s3c_fb_pd_win *)dsim->dsim_config->lcd_panel_in=
fo;
>> + =A0 =A0 lcd_video =3D (struct fb_videomode *)&pd->win_mode;
>> +
>> + =A0 =A0 width =3D lcd_video->xres;
>> + =A0 =A0 height =3D lcd_video->yres;
>> +
>> + =A0 =A0 /* in case of VIDEO MODE (RGB INTERFACE) */
>> + =A0 =A0 if (dsim->dsim_config->e_interface =3D (u32) DSIM_VIDEO) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dsim->dsim_config->auto_vertical_cnt =3D 0=
) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_set_main_disp_vpo=
rch(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd_video->upp=
er_margin,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd_video->low=
er_margin, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_set_main_disp_hpo=
rch(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd_video->lef=
t_margin,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd_video->rig=
ht_margin);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_set_main_disp_syn=
c_area(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd_video->vsy=
nc_len,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd_video->hsy=
nc_len);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 s5p_mipi_dsi_set_main_disp_resol(dsim, height, width);
>> +
>> + =A0 =A0 s5p_mipi_dsi_display_config(dsim, dsim->dsim_config);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_mipi_dsi_init_link(struct mipi_dsim_device *dsim)
>> +{
>> + =A0 =A0 unsigned int time_out =3D 100;
>> +
>> + =A0 =A0 switch (dsim->state) {
>> + =A0 =A0 case DSIM_STATE_INIT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_sw_reset(dsim);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_init_fifo_pointer(dsim, 0x1f);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* dsi configuration */
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_init_config(dsim);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_enable_lane(dsim, DSIM_LANE_CLOCK=
, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_enable_lane(dsim, dsim->data_lane=
, 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* set clock configuration */
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_set_clock(dsim, dsim->dsim_config=
->e_byte_clk,
> 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* check clock and data lane state are stop st=
ate */
>> + =A0 =A0 =A0 =A0 =A0 =A0 while (!(s5p_mipi_dsi_is_lane_state(dsim))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 time_out--;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_out =3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->=
dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "DSI Master is not stop state.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->=
dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "Check initialization process\n");
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (time_out !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "DSI Master dr=
iver has been completed.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dsim->dev, "DSI Maste=
r state is stop
>> state\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsim->state =3D DSIM_STATE_STOP;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* BTA sequence counters */
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_set_stop_state_counter(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->dsim_config->stop_holdin=
g_cnt);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_set_bta_timeout(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->dsim_config->bta_timeout=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_set_lpdr_timeout(dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->dsim_config->rx_timeout);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dsim->dev, "DSI Master is already ini=
t.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_mipi_dsi_set_hs_enable(struct mipi_dsim_device *dsim)
>> +{
>> + =A0 =A0 if (dsim->state =3D DSIM_STATE_STOP) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dsim->e_clk_src !=3D DSIM_EXT_CLK_BYPASS) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsim->state =3D DSIM_STATE_HSC=
LKEN;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* set LCDC and CPU transfe=
r mode to HS. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_set_lcdc_transfer=
_mode(dsim, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_set_cpu_transfer_=
mode(dsim, 0);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_enable_hs_clock(d=
sim, 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "clock source =
is external bypass.\n");
>> + =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dsim->dev, "DSIM is not stop state.\n=
");
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_mipi_dsi_set_data_transfer_mode(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int mode)
>> +{
>> + =A0 =A0 if (mode) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dsim->state !=3D DSIM_STATE_HSCLKEN) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->dev, "HS Clock l=
ane is not
> enabled.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_set_lcdc_transfer_mode(dsim, 0);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dsim->state =3D DSIM_STATE_INIT || dsim->s=
tate =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSIM_STATE_ULPS) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "DSI Master is=
 not STOP or HSDT state.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 s5p_mipi_dsi_set_cpu_transfer_mode(dsim, 0);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int s5p_mipi_dsi_get_frame_done_status(struct mipi_dsim_device *dsim)
>> +{
>> + =A0 =A0 return _s5p_mipi_dsi_get_frame_done_status(dsim);
>> +}
>> +
>> +int s5p_mipi_dsi_clear_frame_done(struct mipi_dsim_device *dsim)
>> +{
>> + =A0 =A0 _s5p_mipi_dsi_clear_frame_done(dsim);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +MODULE_AUTHOR("InKi Dae <inki.dae@samsung.com>");
>> +MODULE_DESCRIPTION("Samusung MIPI-DSIM common driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/video/s5p_mipi_dsi_common.h
>> b/drivers/video/s5p_mipi_dsi_common.h
>> new file mode 100644
>> index 0000000..040d70e
>> --- /dev/null
>> +++ b/drivers/video/s5p_mipi_dsi_common.h
>> @@ -0,0 +1,38 @@
>> +/* linux/drivers/video/s5p_mipi_dsi_common.h
>> + *
>> + * Header file for Samsung MIPI-DSI common driver.
>> + *
>> + * Copyright (c) 2009 Samsung Electronics
>> + * InKi Dae <inki.dae@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#ifndef _S5P_MIPI_DSI_COMMON_H
>> +#define _S5P_MIPI_DSI_COMMON_H
>> +
>> +int s5p_mipi_dsi_wr_data(struct mipi_dsim_device *dsim, unsigned int
> data_id,
>> + =A0 =A0 unsigned int data0, unsigned int data1);
>> +int s5p_mipi_dsi_pll_on(struct mipi_dsim_device *dsim, unsigned int
> enable);
>> +unsigned long s5p_mipi_dsi_change_pll(struct mipi_dsim_device *dsim,
>> + =A0 =A0 unsigned int pre_divider, unsigned int main_divider,
>> + =A0 =A0 unsigned int scaler);
>> +int s5p_mipi_dsi_set_clock(struct mipi_dsim_device *dsim,
>> + =A0 =A0 unsigned int byte_clk_sel, unsigned int enable);
>> +int s5p_mipi_dsi_init_dsim(struct mipi_dsim_device *dsim);
>> +int s5p_mipi_dsi_set_display_mode(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mipi_dsim_config *dsim_=
info);
>> +int s5p_mipi_dsi_init_link(struct mipi_dsim_device *dsim);
>> +int s5p_mipi_dsi_set_hs_enable(struct mipi_dsim_device *dsim);
>> +int s5p_mipi_dsi_set_data_transfer_mode(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int mode);
>> +int s5p_mipi_dsi_enable_frame_done_int(struct mipi_dsim_device *dsim,
>> + =A0 =A0 unsigned int enable);
>> +int s5p_mipi_dsi_get_frame_done_status(struct mipi_dsim_device *dsim);
>> +int s5p_mipi_dsi_clear_frame_done(struct mipi_dsim_device *dsim);
>> +
>> +extern struct fb_info *registered_fb[FB_MAX] __read_mostly;
>> +
>> +#endif /* _S5P_MIPI_DSI_COMMON_H */
>> diff --git a/drivers/video/s5p_mipi_dsi_lowlevel.c
>> b/drivers/video/s5p_mipi_dsi_lowlevel.c
>> new file mode 100644
>> index 0000000..8afea36
>> --- /dev/null
>> +++ b/drivers/video/s5p_mipi_dsi_lowlevel.c
>> @@ -0,0 +1,553 @@
>> +/* linux/drivers/video/s5p_mipi_dsi_lowlevel.c
>> + *
>> + * Samsung MIPI-DSI lowlevel driver.
>> + *
>> + * InKi Dae, <inki.dae@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/errno.h>
>> +#include <linux/mutex.h>
>> +#include <linux/wait.h>
>> +#include <linux/delay.h>
>> +#include <linux/fs.h>
>> +#include <linux/mm.h>
>> +#include <linux/ctype.h>
>> +#include <linux/io.h>
>> +
>> +#include <mach/map.h>
>> +
>> +#include <plat/dsim.h>
>> +#include <plat/regs-dsim.h>
>> +
>> +void s5p_mipi_dsi_func_reset(struct mipi_dsim_device *dsim)
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 reg =3D readl(dsim->reg_base + S5P_DSIM_SWRST);
>> +
>> + =A0 =A0 reg |=3D DSIM_FUNCRST;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_SWRST);
>> +}
>> +
>> +void s5p_mipi_dsi_sw_reset(struct mipi_dsim_device *dsim)
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 reg =3D readl(dsim->reg_base + S5P_DSIM_SWRST);
>> +
>> + =A0 =A0 reg |=3D DSIM_SWRST;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_SWRST);
>> +}
>> +
>> +void s5p_mipi_dsi_set_interrupt_mask(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int mode, unsigned int mask)
>> +{
>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_INTMSK);
>> +
>> + =A0 =A0 if (mask)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D mode;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~mode;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_INTMSK);
>> +}
>> +
>> +void s5p_mipi_dsi_init_fifo_pointer(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int cfg)
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 reg =3D readl(dsim->reg_base + S5P_DSIM_FIFOCTRL);
>> +
>> + =A0 =A0 writel(reg & ~(cfg), dsim->reg_base + S5P_DSIM_FIFOCTRL);
>> + =A0 =A0 mdelay(10);
>> + =A0 =A0 reg |=3D cfg;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_FIFOCTRL);
>> +}
>> +
>> +/*
>> + * this function set PLL P, M and S value in D-PHY
>> + */
>> +void s5p_mipi_dsi_set_phy_tunning(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int value)
>> +{
>> + =A0 =A0 writel(DSIM_AFC_CTL(value), dsim->reg_base + S5P_DSIM_PHYACCHR=
);
>> +}
>> +
>> +void s5p_mipi_dsi_set_main_disp_resol(struct mipi_dsim_device *dsim,
>> + =A0 =A0 unsigned int vert_resol, unsigned int hori_resol)
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 /* standby should be set after configuration so set to not rea=
dy*/
>> + =A0 =A0 reg =3D (readl(dsim->reg_base + S5P_DSIM_MDRESOL)) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(DSIM_MAIN_STAND_BY);
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_MDRESOL);
>> +
>> + =A0 =A0 reg &=3D ~(0x7ff << 16) & ~(0x7ff << 0);
>> + =A0 =A0 reg |=3D DSIM_MAIN_VRESOL(vert_resol) | DSIM_MAIN_HRESOL(hori_=
resol);
>> +
>> + =A0 =A0 reg |=3D DSIM_MAIN_STAND_BY;
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_MDRESOL);
>> +}
>> +
>> +void s5p_mipi_dsi_set_main_disp_vporch(struct mipi_dsim_device *dsim,
>> + =A0 =A0 unsigned int cmd_allow, unsigned int vfront, unsigned int vbac=
k)
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 reg =3D (readl(dsim->reg_base + S5P_DSIM_MVPORCH)) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(DSIM_CMD_ALLOW_MASK) & ~(DSIM_STABLE_VFP_MAS=
K) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(DSIM_MAIN_VBP_MASK);
>> +
>> + =A0 =A0 reg |=3D ((cmd_allow & 0xf) << DSIM_CMD_ALLOW_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((vfront & 0x7ff) << DSIM_STABLE_VFP_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((vback & 0x7ff) << DSIM_MAIN_VBP_SHIFT);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_MVPORCH);
>> +}
>> +
>> +void s5p_mipi_dsi_set_main_disp_hporch(struct mipi_dsim_device *dsim,
>> + =A0 =A0 unsigned int front, unsigned int back)
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 reg =3D (readl(dsim->reg_base + S5P_DSIM_MHPORCH)) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(DSIM_MAIN_HFP_MASK) & ~(DSIM_MAIN_HBP_MASK);
>> +
>> + =A0 =A0 reg |=3D (front << DSIM_MAIN_HFP_SHIFT) | (back <<
> DSIM_MAIN_HBP_SHIFT);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_MHPORCH);
>> +}
>> +
>> +void s5p_mipi_dsi_set_main_disp_sync_area(struct mipi_dsim_device *dsim,
>> + =A0 =A0 unsigned int vert, unsigned int hori)
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 reg =3D (readl(dsim->reg_base + S5P_DSIM_MSYNC)) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(DSIM_MAIN_VSA_MASK) & ~(DSIM_MAIN_HSA_MASK);
>> +
>> + =A0 =A0 reg |=3D ((vert & 0x3ff) << DSIM_MAIN_VSA_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (hori << DSIM_MAIN_HSA_SHIFT);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_MSYNC);
>> +}
>> +
>> +void s5p_mipi_dsi_set_sub_disp_resol(struct mipi_dsim_device *dsim,
>> + =A0 =A0 unsigned int vert, unsigned int hori)
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 reg =3D (readl(dsim->reg_base + S5P_DSIM_SDRESOL)) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(DSIM_SUB_STANDY_MASK);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_SDRESOL);
>> +
>> + =A0 =A0 reg &=3D ~(DSIM_SUB_VRESOL_MASK) | ~(DSIM_SUB_HRESOL_MASK);
>> + =A0 =A0 reg |=3D ((vert & 0x7ff) << DSIM_SUB_VRESOL_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((hori & 0x7ff) << DSIM_SUB_HRESOL_SHIFT);
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_SDRESOL);
>> +
>> + =A0 =A0 reg |=3D (1 << DSIM_SUB_STANDY_SHIFT);
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_SDRESOL);
>> +}
>> +
>> +void s5p_mipi_dsi_init_config(struct mipi_dsim_device *dsim)
>> +{
>> + =A0 =A0 struct mipi_dsim_config *dsim_config =3D dsim->dsim_config;
>> +
>> + =A0 =A0 unsigned int cfg =3D (readl(dsim->reg_base + S5P_DSIM_CONFIG))=
 &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(1 << 28) & ~(0x1f << 20) & ~(0x3 << 5);
>> +
>> + =A0 =A0 cfg =3D =A0 (dsim_config->auto_flush << 29) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (dsim_config->eot_disable << 28) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (dsim_config->auto_vertical_cnt << DSIM_AUTO_M=
ODE_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (dsim_config->hse << DSIM_HSE_MODE_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (dsim_config->hfp << DSIM_HFP_MODE_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (dsim_config->hbp << DSIM_HBP_MODE_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (dsim_config->hsa << DSIM_HSA_MODE_SHIFT) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (dsim_config->e_no_data_lane << DSIM_NUM_OF_DA=
TALANE_SHIFT);
>> +
>> + =A0 =A0 writel(cfg, dsim->reg_base + S5P_DSIM_CONFIG);
>> +}
>> +
>> +void s5p_mipi_dsi_display_config(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mipi_ds=
im_config *dsim_config)
>> +{
>> + =A0 =A0 u32 reg =3D (readl(dsim->reg_base + S5P_DSIM_CONFIG)) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(0x3 << 26) & ~(1 << 25) & ~(0x3 << 18) & ~(0=
x7 << 12) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(0x3 << 16) & ~(0x7 << 8);
>> +
>> + =A0 =A0 if (dsim_config->e_interface =3D DSIM_VIDEO)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (1 << 25);
>> + =A0 =A0 else if (dsim_config->e_interface =3D DSIM_COMMAND)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(1 << 25);
>> + =A0 =A0 else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dsim->dev, "this ddi is not MIPI inter=
face.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* main lcd */
>> + =A0 =A0 reg |=3D ((u8) (dsim_config->e_burst_mode) & 0x3) << 26 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((u8) (dsim_config->e_virtual_ch) & 0x3) << 18=
 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((u8) (dsim_config->e_pixel_format) & 0x7) << =
12;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_CONFIG);
>> +}
>> +
>> +void s5p_mipi_dsi_enable_lane(struct mipi_dsim_device *dsim, unsigned i=
nt
>> lane,
>> + =A0 =A0 unsigned int enable)
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 reg =3D readl(dsim->reg_base + S5P_DSIM_CONFIG);
>> +
>> + =A0 =A0 if (enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D DSIM_LANE_ENx(lane);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~DSIM_LANE_ENx(lane);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_CONFIG);
>> +}
>> +
>> +
>> +void s5p_mipi_dsi_set_data_lane_number(struct mipi_dsim_device *dsim,
>> + =A0 =A0 unsigned int count)
>> +{
>> + =A0 =A0 unsigned int cfg;
>> +
>> + =A0 =A0 /* get the data lane number. */
>> + =A0 =A0 cfg =3D DSIM_NUM_OF_DATA_LANE(count);
>> +
>> + =A0 =A0 writel(cfg, dsim->reg_base + S5P_DSIM_CONFIG);
>> +}
>> +
>> +void s5p_mipi_dsi_enable_afc(struct mipi_dsim_device *dsim, unsigned int
>> enable,
>> + =A0 =A0 unsigned int afc_code)
>> +{
>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_PHYACCHR);
>> +
>> + =A0 =A0 if (enable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (1 << 14);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(0x7 << 5);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (afc_code & 0x7) << 5;
>> + =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(1 << 14);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_PHYACCHR);
>> +}
>> +
>> +void s5p_mipi_dsi_enable_pll_bypass(struct mipi_dsim_device *dsim,
>> + =A0 =A0 unsigned int enable)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(DSIM_PLL_BYPASS_EXTERNAL);
>> +
>> + =A0 =A0 reg |=3D enable << DSIM_PLL_BYPASS_SHIFT;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
>> +}
>> +
>> +void s5p_mipi_dsi_set_pll_pms(struct mipi_dsim_device *dsim, unsigned i=
nt
> p,
>> + =A0 =A0 unsigned int m, unsigned int s)
>> +{
>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_PLLCTRL);
>> +
>> + =A0 =A0 reg |=3D ((p & 0x3f) << 13) | ((m & 0x1ff) << 4) | ((s & 0x7) =
<< 1);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
>> +}
>> +
>> +void s5p_mipi_dsi_pll_freq_band(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int freq_band)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(0x1f << DSIM_FREQ_BAND_SHIFT);
>> +
>> + =A0 =A0 reg |=3D ((freq_band & 0x1f) << DSIM_FREQ_BAND_SHIFT);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
>> +}
>> +
>> +void s5p_mipi_dsi_pll_freq(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int pre_divider, unsigned int main_di=
vider,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int scaler)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(0x7ffff << 1);
>> +
>> + =A0 =A0 reg |=3D (pre_divider & 0x3f) << 13 | (main_divider & 0x1ff) <=
< 4 |
>> + =A0 =A0 =A0 =A0 =A0 =A0 (scaler & 0x7) << 1;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
>> +}
>> +
>> +void s5p_mipi_dsi_pll_stable_time(struct mipi_dsim_device *dsim,
>> + =A0 =A0 unsigned int lock_time)
>> +{
>> + =A0 =A0 writel(lock_time, dsim->reg_base + S5P_DSIM_PLLTMR);
>> +}
>> +
>> +void s5p_mipi_dsi_enable_pll(struct mipi_dsim_device *dsim, unsigned int
>> enable)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(0x1 << DSIM_PLL_EN_SHIFT);
>> +
>> + =A0 =A0 reg |=3D ((enable & 0x1) << DSIM_PLL_EN_SHIFT);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
>> +}
>> +
>> +void s5p_mipi_dsi_set_byte_clock_src(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int src)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(0x3 << DSIM_BYTE_CLK_SRC_SHIFT);
>> +
>> + =A0 =A0 reg |=3D ((unsigned int) src) << DSIM_BYTE_CLK_SRC_SHIFT;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
>> +}
>> +
>> +void s5p_mipi_dsi_enable_byte_clock(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int enable)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(1 << DSIM_BYTE_CLKEN_SHIFT);
>> +
>> + =A0 =A0 reg |=3D enable << DSIM_BYTE_CLKEN_SHIFT;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
>> +}
>> +
>> +void s5p_mipi_dsi_set_esc_clk_prs(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int enable, unsigned int prs_val)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(1 << DSIM_ESC_CLKEN_SHIFT) & ~(0xffff);
>> +
>> + =A0 =A0 reg |=3D enable << DSIM_ESC_CLKEN_SHIFT;
>> + =A0 =A0 if (enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D prs_val;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
>> +}
>> +
>> +void s5p_mipi_dsi_enable_esc_clk_on_lane(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int lane_sel, unsigned int enable)
>> +{
>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_CLKCTRL);
>> +
>> + =A0 =A0 if (enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D DSIM_LANE_ESC_CLKEN(lane_sel);
>> + =A0 =A0 else
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~DSIM_LANE_ESC_CLKEN(lane_sel);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
>> +}
>> +
>> +void s5p_mipi_dsi_force_dphy_stop_state(struct mipi_dsim_device *dsim,
>> + =A0 =A0 unsigned int enable)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_ESCMODE)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(0x1 << DSIM_FORCE_STOP_STATE_SHIFT);
>> +
>> + =A0 =A0 reg |=3D ((enable & 0x1) << DSIM_FORCE_STOP_STATE_SHIFT);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_ESCMODE);
>> +}
>> +
>> +unsigned int s5p_mipi_dsi_is_lane_state(struct mipi_dsim_device *dsim)
>> +{
>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_STATUS);
>> +
>> + =A0 =A0 /**
>> + =A0 =A0 =A0* check clock and data lane states.
>> + =A0 =A0 =A0* if MIPI-DSI controller was enabled at bootloader then
>> + =A0 =A0 =A0* TX_READY_HS_CLK is enabled otherwise STOP_STATE_CLK.
>> + =A0 =A0 =A0* so it should be checked for two case.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if ((reg & DSIM_STOP_STATE_DAT(0xf)) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((reg & DSIM_STOP_STATE_CLK) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(reg & DSIM_TX_READY_HS_CLK=
)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +void s5p_mipi_dsi_set_stop_state_counter(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int cnt_val)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_ESCMODE)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(0x7ff << DSIM_STOP_STATE_CNT_SHIFT);
>> +
>> + =A0 =A0 reg |=3D ((cnt_val & 0x7ff) << DSIM_STOP_STATE_CNT_SHIFT);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_ESCMODE);
>> +}
>> +
>> +void s5p_mipi_dsi_set_bta_timeout(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int timeout)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_TIMEOUT)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(0xff << DSIM_BTA_TOUT_SHIFT);
>> +
>> + =A0 =A0 reg |=3D (timeout << DSIM_BTA_TOUT_SHIFT);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_TIMEOUT);
>> +}
>> +
>> +void s5p_mipi_dsi_set_lpdr_timeout(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int timeout)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_TIMEOUT)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(0xffff << DSIM_LPDR_TOUT_SHIFT);
>> +
>> + =A0 =A0 reg |=3D (timeout << DSIM_LPDR_TOUT_SHIFT);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_TIMEOUT);
>> +}
>> +
>> +void s5p_mipi_dsi_set_cpu_transfer_mode(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int lp)
>> +{
>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_ESCMODE);
>> +
>> + =A0 =A0 reg &=3D ~DSIM_CMD_LPDT_LP;
>> +
>> + =A0 =A0 reg |=3D lp << DSIM_CMD_LPDT_SHIFT;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_ESCMODE);
>> +}
>> +
>> +void s5p_mipi_dsi_set_lcdc_transfer_mode(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int lp)
>> +{
>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_ESCMODE);
>> +
>> + =A0 =A0 reg &=3D ~DSIM_TX_LPDT_LP;
>> +
>> + =A0 =A0 reg |=3D lp << DSIM_TX_LPDT_SHIFT;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_ESCMODE);
>> +}
>> +
>> +void s5p_mipi_dsi_enable_hs_clock(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int enable)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(1 << DSIM_TX_REQUEST_HSCLK_SHIFT);
>> +
>> + =A0 =A0 reg |=3D enable << DSIM_TX_REQUEST_HSCLK_SHIFT;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
>> +}
>> +
>> +void s5p_mipi_dsi_dp_dn_swap(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int swap_en)
>> +{
>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_PHYACCHR1=
);
>> +
>> + =A0 =A0 reg &=3D ~(0x3 << 0);
>> + =A0 =A0 reg |=3D (swap_en & 0x3) << 0;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_PHYACCHR1);
>> +}
>> +
>> +void s5p_mipi_dsi_hs_zero_ctrl(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int hs_zero)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(0xf << 28);
>> +
>> + =A0 =A0 reg |=3D ((hs_zero & 0xf) << 28);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
>> +}
>> +
>> +void s5p_mipi_dsi_prep_ctrl(struct mipi_dsim_device *dsim, unsigned int
> prep)
>> +{
>> + =A0 =A0 unsigned int reg =3D (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)=
) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 ~(0x7 << 20);
>> +
>> + =A0 =A0 reg |=3D ((prep & 0x7) << 20);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
>> +}
>> +
>> +void s5p_mipi_dsi_clear_interrupt(struct mipi_dsim_device *dsim)
>> +{
>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_INTSRC);
>> +
>> + =A0 =A0 reg |=3D INTSRC_PLL_STABLE;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_INTSRC);
>> +}
>> +
>> +void s5p_mipi_dsi_clear_all_interrupt(struct mipi_dsim_device *dsim)
>> +{
>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_INTSRC);
>> +
>> + =A0 =A0 reg |=3D 0xffffffff;
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_INTSRC);
>> +}
>> +
>> +unsigned int s5p_mipi_dsi_is_pll_stable(struct mipi_dsim_device *dsim)
>> +{
>> + =A0 =A0 unsigned int reg;
>> +
>> + =A0 =A0 reg =3D readl(dsim->reg_base + S5P_DSIM_STATUS);
>> +
>> + =A0 =A0 return reg & (1 << 31) ? 1 : 0;
>> +}
>> +
>> +unsigned int s5p_mipi_dsi_get_fifo_state(struct mipi_dsim_device *dsim)
>> +{
>> + =A0 =A0 unsigned int ret;
>> +
>> + =A0 =A0 ret =3D readl(dsim->reg_base + S5P_DSIM_FIFOCTRL) & ~(0x1f);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +void s5p_mipi_dsi_wr_tx_header(struct mipi_dsim_device *dsim,
>> + =A0 =A0 unsigned int di, unsigned int data0, unsigned int data1)
>> +{
>> + =A0 =A0 unsigned int reg =3D (data1 << 16) | (data0 << 8) | ((di & 0x3=
f) <<
> 0);
>> +
>> + =A0 =A0 writel(reg, dsim->reg_base + S5P_DSIM_PKTHDR);
>> +}
>> +
>> +unsigned int _s5p_mipi_dsi_get_frame_done_status(struct mipi_dsim_device
>> *dsim)
>> +{
>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_INTSRC);
>> +
>> + =A0 =A0 return (reg & INTSRC_FRAME_DONE) ? 1 : 0;
>> +}
>> +
>> +void _s5p_mipi_dsi_clear_frame_done(struct mipi_dsim_device *dsim)
>> +{
>> + =A0 =A0 unsigned int reg =3D readl(dsim->reg_base + S5P_DSIM_INTSRC);
>> +
>> + =A0 =A0 writel(reg | INTSRC_FRAME_DONE, dsim->reg_base +
>> + =A0 =A0 =A0 =A0 =A0 =A0 S5P_DSIM_INTSRC);
>> +}
>> +
>> +void s5p_mipi_dsi_wr_tx_data(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int tx_data)
>> +{
>> + =A0 =A0 writel(tx_data, dsim->reg_base + S5P_DSIM_PAYLOAD);
>> +}
>> diff --git a/drivers/video/s5p_mipi_dsi_lowlevel.h
>> b/drivers/video/s5p_mipi_dsi_lowlevel.h
>> new file mode 100644
>> index 0000000..ed3f91c
>> --- /dev/null
>> +++ b/drivers/video/s5p_mipi_dsi_lowlevel.h
>> @@ -0,0 +1,98 @@
>> +/* linux/drivers/video/s5p_mipi_dsi_lowlevel.h
>> + *
>> + * Header file for Samsung MIPI-DSI lowlevel driver.
>> + *
>> + * Copyright (c) 2009 Samsung Electronics
>> + * InKi Dae <inki.dae@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#ifndef _S5P_MIPI_DSI_LOWLEVEL_H
>> +#define _S5P_MIPI_DSI_LOWLEVEL_H
>> +
>> +void s5p_mipi_dsi_func_reset(struct mipi_dsim_device *dsim);
>> +void s5p_mipi_dsi_sw_reset(struct mipi_dsim_device *dsim);
>> +void s5p_mipi_dsi_set_interrupt_mask(struct mipi_dsim_device *dsim,
>> + =A0 =A0 unsigned int mode, unsigned int mask);
>> +void s5p_mipi_dsi_set_data_lane_number(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 unsigned int count);
>> +void s5p_mipi_dsi_init_fifo_pointer(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 unsigned int cfg);
>> +void s5p_mipi_dsi_set_phy_tunning(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int v=
alue);
>> +void s5p_mipi_dsi_set_phy_tunning(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int v=
alue);
>> +void s5p_mipi_dsi_set_main_disp_resol(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int vert_resol, unsigned int hori_res=
ol);
>> +void s5p_mipi_dsi_set_main_disp_vporch(struct mipi_dsim_device *dsim,
>> + =A0 =A0 unsigned int cmd_allow, unsigned int vfront, unsigned int vbac=
k);
>> +void s5p_mipi_dsi_set_main_disp_hporch(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int front, unsigned i=
nt back);
>> +void s5p_mipi_dsi_set_main_disp_sync_area(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int v=
ert, unsigned int hori);
>> +void s5p_mipi_dsi_set_sub_disp_resol(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int v=
ert, unsigned int hori);
>> +void s5p_mipi_dsi_init_config(struct mipi_dsim_device *dsim);
>> +void s5p_mipi_dsi_display_config(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mipi_ds=
im_config *dsim_config);
>> +void s5p_mipi_dsi_set_data_lane_number(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int c=
ount);
>> +void s5p_mipi_dsi_enable_lane(struct mipi_dsim_device *dsim, unsigned i=
nt
>> lane,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int e=
nable);
>> +void s5p_mipi_dsi_enable_afc(struct mipi_dsim_device *dsim, unsigned int
>> enable,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int a=
fc_code);
>> +void s5p_mipi_dsi_enable_pll_bypass(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int e=
nable);
>> +void s5p_mipi_dsi_set_pll_pms(struct mipi_dsim_device *dsim, unsigned i=
nt
> p,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int m=
, unsigned int s);
>> +void s5p_mipi_dsi_pll_freq_band(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int f=
req_band);
>> +void s5p_mipi_dsi_pll_freq(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int pre_divider, unsi=
gned int main_divider,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int scaler);
>> +void s5p_mipi_dsi_pll_stable_time(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int lock_time);
>> +void s5p_mipi_dsi_enable_pll(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 unsigned int enable);
>> +void s5p_mipi_dsi_set_byte_clock_src(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 unsigned int src);
>> +void s5p_mipi_dsi_enable_byte_clock(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 unsigned int enable);
>> +void s5p_mipi_dsi_set_esc_clk_prs(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int e=
nable, unsigned int prs_val);
>> +void s5p_mipi_dsi_enable_esc_clk_on_lane(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int l=
ane_sel, unsigned int enable);
>> +void s5p_mipi_dsi_force_dphy_stop_state(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int e=
nable);
>> +unsigned int s5p_mipi_dsi_is_lane_state(struct mipi_dsim_device *dsim);
>> +void s5p_mipi_dsi_set_stop_state_counter(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int c=
nt_val);
>> +void s5p_mipi_dsi_set_bta_timeout(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int t=
imeout);
>> +void s5p_mipi_dsi_set_lpdr_timeout(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int t=
imeout);
>> +void s5p_mipi_dsi_set_lcdc_transfer_mode(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 unsigned int lp);
>> +void s5p_mipi_dsi_set_cpu_transfer_mode(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 unsigned int lp);
>> +void s5p_mipi_dsi_enable_hs_clock(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int e=
nable);
>> +void s5p_mipi_dsi_dp_dn_swap(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int s=
wap_en);
>> +void s5p_mipi_dsi_hs_zero_ctrl(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int h=
s_zero);
>> +void s5p_mipi_dsi_prep_ctrl(struct mipi_dsim_device *dsim, unsigned int
>> prep);
>> +void s5p_mipi_dsi_clear_interrupt(struct mipi_dsim_device *dsim);
>> +void s5p_mipi_dsi_clear_all_interrupt(struct mipi_dsim_device *dsim);
>> +unsigned int s5p_mipi_dsi_is_pll_stable(struct mipi_dsim_device *dsim);
>> +unsigned int s5p_mipi_dsi_get_fifo_state(struct mipi_dsim_device *dsim);
>> +unsigned int _s5p_mipi_dsi_get_frame_done_status(struct mipi_dsim_device
>> *dsim);
>> +void _s5p_mipi_dsi_clear_frame_done(struct mipi_dsim_device *dsim);
>> +void s5p_mipi_dsi_wr_tx_header(struct mipi_dsim_device *dsim, unsigned
> int
>> di,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int d=
ata0, unsigned int data1);
>> +void s5p_mipi_dsi_wr_tx_data(struct mipi_dsim_device *dsim,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int tx_data);
>> +
>> +#endif /* _S5P_MIPI_DSI_LOWLEVEL_H */
>> --
>> 1.7.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
