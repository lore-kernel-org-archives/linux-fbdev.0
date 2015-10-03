From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sat, 03 Oct 2015 17:08:36 +0000
Subject: Re: [PATCH 2/2] video: fbdev: pxafb: initial devicetree conversion
Message-Id: <87k2r3dgmj.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443888714-12362-1-git-send-email-robert.jarzmik@free.fr>
	<1443888714-12362-3-git-send-email-robert.jarzmik@free.fr>
	<CA+gwMceWchEhPQ0Prs5Ne+D+Fq1uybPkB48tRNWzj=i14TW8Yg@mail.gmail.com>
In-Reply-To: <CA+gwMceWchEhPQ0Prs5Ne+D+Fq1uybPkB48tRNWzj=i14TW8Yg@mail.gmail.com>
	(Philipp Zabel's message of "Sat, 3 Oct 2015 19:02:44 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Philipp Zabel <philipp.zabel@gmail.com> writes:

> Hi Robert,
>
> On Sat, Oct 3, 2015 at 6:11 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> This patch brings a first support of pxa framebuffer devices to a
>> devicetree pxa platform, as was before platform data.
>>
>> There are restrictions with this port, the biggest one being the lack of
>> support of smart panels. Moreover the conversion doesn't provide a way
>> to declare multiple framebuffer configurations with different bits per
>> pixel, only the LCD hardware bus width is used.
>>
>> The patch was tested on both pxa25x, pxa27x and pxa3xx platform (namely
>> lubbock, mainstone and zylonite).
>>
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> Thanks a lot for working on this! Out of interest, do you plan to
> convert MIOA701 to DT?
Actually, I already had. If you take all the pending patches scattered across
all the subsystems (around 40 by my last count), then mioa701 is converted, see
in [1]. If we take -next tree, I think the count will be closer to 20 or so.

>> @@ -2313,11 +2461,19 @@ static int pxafb_remove(struct platform_device *dev)
>>         return 0;
>>  }
>>
>> +static const struct of_device_id pxafb_of_dev_id[] = {
>> +       {
>> +               .compatible = "marvell,pxa2xx-fb",
>
> At least in the old Intel manuals, this was called the LCD Controller,
> all register names are LCsomething.
> Please let's not just put the Linux driver name in the device tree and
> call this pxa2xx-lcd-controller or a shortened version thereof.
Ok, I'm very open for a name change, devicetree is not my speciality, so
basically I'll take any advice :)

Cheers.

-- 
Robert

[1] mioa701 dt
/*
 *  Copyright (C) Robert Jarzmik <robert.jarzmik@free.fr>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License version 2 as
 *  publishhed by the Free Software Foundation.
 */

/dts-v1/;
#include "pxa27x.dtsi"
#include "include/dt-bindings/gpio/gpio.h"
#include "include/dt-bindings/clock/pxa-clock.h"

/ {
	model = "Mitac Mio A701 Board";
	/* compatible = "mitac,mioa701"; */
	compatible = "marvell,pxa270";

	chosen {
		bootargs = "mtdparts=docg3.0:256k@3456k(barebox)ro,256k(barebox-logo),128k(barebox-env),4M(kernel),-(root) ubi.mtd=4 rootfstype=ubifs root=ubi0:linux_root ro";
	};

	memory {
		reg = <0xa0000000 0x04000000>;

		reserved-memory {
			#address-cells = <1>;
			#size-cells = <1>;

			pstore_region:region@0xa2000000 {
				compatible = "linux,contiguous-memory-region";
				reg = <0xa2000000 1048576>;
			};
		};
	};

	cpus {
		cpu {
			cpu-supply = <&vcc_core>;
		};
	};

	pxabus {
		gpio: gpio@40e00000 {
			status = "okay";
		};

		ffuart: uart@40100000 {
			status = "okay";
		};

		btuart: uart@40200000 {
			status = "okay";
		};

		stuart: uart@40700000 {
			status = "okay";
		};

		usb2phy: gpio-vbus@13 {
			compatible = "usb-nop-xceiv";
			vbus-detect-gpio = <&gpio 13 GPIO_ACTIVE_LOW>;
			wakeup;
		};

		pxa27x_udc: udc@40600000 {
			    status = "okay";
			    gpios = <&gpio 22 0>;
			    phys = <&usb2phy>;
			    phys-names = "usb2phy";
		};

		pwri2c: i2c@40f000180 {
			status = "okay";

			max1586@14 {
				compatible = "maxim,max1586";
				reg = <0x14>;
				v3-gain = <1000000>;

				regulators {
					vcc_core: v3 {
						regulator-name = "vcc_core";
						regulator-compatible = "Output_V3";
						regulator-min-microvolt = <1000000>;
						regulator-max-microvolt = <1705000>;
						regulator-always-on;
					};
				};
			};
		};

		pxai2c1: i2c@40301680 {
			mrvl,i2c-fast-mode;
			status = "okay";

			mt9m111: camera@5d {
				compatible = "micron,mt9m111";
				reg = <0x5d>;
				gpios = <&gpio 56 GPIO_ACTIVE_HIGH>;

				remote = <&pxa_camera>;
				port {
					mt9m111_1: endpoint {
						bus-width = <8>;
						remote-endpoint = <&pxa_camera>;
					};
				};
			};
		};

		keypad: keypad@41500000 {
			status = "okay";

			keypad,num-rows = <3>;
			keypad,num-columns = <3>;
			linux,keymap = <
				0x00000067	/* KEY_UP */
				0x0001006a	/* KEY_RIGHT */
				0x000200e2	/* KEY_MEDIA */
				0x0100006c	/* KEY_DOWN */
				0x0101001c	/* KEY_ENTER */
				0x010200da	/* KEY_CONNECT */
				0x02000069	/* KEY_LEFT */
				0x020100a9	/* KEY_PHONE */
				0x020200d4>;	/* KEY_CAMERA */
			marvell,debounce-interval = <0>;
		};

		gpio-keys {
			compatible = "gpio-keys";
			#address-cells = <1>;
			#size-cells = <0>;
			autorepeat;
			status = "okay";

			button@0 {
				label = "GPIO Key Power";
				linux,code = <174>;
				gpios = <&gpio 0 0>;
				gpio-key,wakeup;
			};
			button@12 {
				label = "HP jack detect";
				linux,code = <211>;
				gpios = <&gpio 12 0>;
			};
			button@93 {
				label = "Volume Up Key";
				linux,code = <115>;
				gpios = <&gpio 93 0>;
			};
			button@94 {
				label = "Volume Down Key";
				linux,code = <114>;
				gpios = <&gpio 94 0>;
			};
		};

		mmc0: mmc@41100000 {
			vmmc-supply = <&reg_vmmc>;
			status = "okay";
		};

		pxa_camera: imaging@50000000 {
			status = "okay";

			port {
				#address-cells = <1>;
				#size-cells = <0>;

				/* Parallel bus endpoint */
				qci: endpoint@0 {
					reg = <0>;		/* Local endpoint # */
					remote-endpoint = <&mt9m111_1>;	/* Remote phandle */
					bus-width = <8>;	/* Used data lines */

					hsync-active = <0>;	/* Active low */
					vsync-active = <0>;	/* Active low */
					pclk-sample = <1>;	/* Rising */
				};
			};
		};

		pxafb: video@40500000 {
			status = "okay";
			display = <&display0>;

			enable-transparency-bit = <0>;
			enable-greyscale-cmap = <0>;
		};
	};

	regulators {
		compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <0>;

		reg_vmmc: regulator@0 {
			compatible = "regulator-fixed";
			regulator-name = "vmmc";
			regulator-min-microvolt = <3300000>;
			regulator-max-microvolt = <3300000>;
			regulator-always-on;
		};
	};

	backlight {
		compatible = "pwm-backlight";
		pwms = <&pwm0 0 40960000>;
		pwm-names = "backlight";

		brightness-levels = <0 4 8 16 32 64 128 255>;
		default-brightness-level = <2>;
	};

	docg3: flash@0 {
		compatible = "m-systems,diskonchip-g3";
		reg = <0x0 0x2000>;
	};

	display0: display@0 {
		lcd-type = "color-tft";
		bits-per-pixel = <16>;
		display-timings {
			native-mode = <&timing0>;
			timing0: 240p {
				/* 240x320p24 */
				clock-frequency = <4545000>;
				hactive = <240>;
				vactive = <320>;
				hfront-porch = <4>;
				hback-porch = <6>;
				hsync-len = <4>;
				vback-porch = <5>;
				vfront-porch = <3>;
				vsync-len = <2>;
			};
		};
	};
};
