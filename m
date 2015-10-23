From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 23 Oct 2015 15:56:35 +0000
Subject: Re: [PATCH v4 4/4] ARM: dts: sun6i: Add dts file for MSI Primo81 tablet
Message-Id: <CAGb2v64xESxh0Dzsh9GijYZADbB-SM99ZVtu=9FGB2Gfz2-Z6Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1445572241-13259-1-git-send-email-wens@csie.org>
 <1445572241-13259-5-git-send-email-wens@csie.org>
 <20151023145309.GA1885@excalibur.cnev.de>
 <CAGb2v67HO5isvUxG09traLUBrBp-0Bea9cXn_O0oqBCTYtfN=w@mail.gmail.com>
In-Reply-To: <CAGb2v67HO5isvUxG09traLUBrBp-0Bea9cXn_O0oqBCTYtfN=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Oct 23, 2015 at 11:46 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Fri, Oct 23, 2015 at 10:53 PM, Karsten Merker <merker@debian.org> wrote:
>> On Fri, Oct 23, 2015 at 11:50:41AM +0800, Chen-Yu Tsai wrote:
>>
>>> From: Karsten Merker <merker@debian.org>
>>>
>>> The MSI Primo81 is an A31s based tablet, with 1G RAM, 16G NAND,
>>> 768x1024 IPS LCD display, mono speaker, 0.3 MP front camera, 2.0 MP
>>> rear camera, 3500 mAh battery, gt911 touchscreen, mma8452 accelerometer
>>> and rtl8188etv usb wifi. Has "power", "volume+" and "volume-" buttons
>>> (both volume buttons are also connected to the UBOOT_SEL pin). The
>>
>> Hello Chen-Yu,
>>
>> the volume button function is something that I wanted to confirm
>> again but forgot to ask previously: Siarhei had pointed out that
>> only the volume+ button triggers UBOOT_SEL, but for me actually
>> both volume buttons work as described above.  Could you
>> cross-check that on your Primo81?
>
> IIRC both work. I can test next week.
>
>>
>>> external connectors are represented by MicroSD slot, MiniHDMI, MicroUSB
>>> OTG and 3.5mm headphone jack.
>>>
>>> USB OTG is enabled in host only mode. AXP221 USB power supply and
>>> GPIO support are required for full USB OTG support.
>>>
>>> Signed-off-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
>>> Signed-off-by: Karsten Merker <merker@debian.org>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>
>>> Changes since last submission (was part of Sinlinx SinA31s series)
>>>
>>>   - Update axp22x.dtsi file name
>>>   - Sort regulators
>>>   - Drop URL in commit message
>>>   - Drop comment for capacitive touch panel
>>>   - Add simplefb regulators
>>>   - Drop regulator-always-on for regulators that aren't critical
>>>   - Fix CPU and GPU regulator supply mix-up
>>>
>>> ---
>>>  arch/arm/boot/dts/Makefile               |   1 +
>>>  arch/arm/boot/dts/sun6i-a31s-primo81.dts | 255 +++++++++++++++++++++++++++++++
>>>  2 files changed, 256 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/sun6i-a31s-primo81.dts
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index c00b72e750ab..78ade1a5e886 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -612,6 +612,7 @@ dtb-$(CONFIG_MACH_SUN6I) += \
>>>       sun6i-a31-m9.dtb \
>>>       sun6i-a31-mele-a1000g-quad.dtb \
>>>       sun6i-a31s-cs908.dtb \
>>> +     sun6i-a31s-primo81.dtb \
>>>       sun6i-a31s-sina31s.dtb \
>>>       sun6i-a31s-sinovoip-bpi-m2.dtb \
>>>       sun6i-a31s-yones-toptech-bs1078-v2.dtb
>>> diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
>>> new file mode 100644
>>> index 000000000000..2d4250b1faf8
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
>>> @@ -0,0 +1,255 @@
>>> +/*
>>> + * Copyright 2014 Siarhei Siamashka <siarhei.siamashka@gmail.com>
>>> + * Copyright 2015 Karsten Merker <merker@debian.org>
>>> + * Copyright 2015 Chen-Yu Tsai <wens@csie.org>
>>> + *
>>> + * This file is dual-licensed: you can use it either under the terms
>>> + * of the GPL or the X11 license, at your option. Note that this dual
>>> + * licensing only applies to this file, and not this project as a
>>> + * whole.
>>> + *
>>> + *  a) This file is free software; you can redistribute it and/or
>>> + *     modify it under the terms of the GNU General Public License as
>>> + *     published by the Free Software Foundation; either version 2 of the
>>> + *     License, or (at your option) any later version.
>>> + *
>>> + *     This file is distributed in the hope that it will be useful,
>>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + *     GNU General Public License for more details.
>>> + *
>>> + * Or, alternatively,
>>> + *
>>> + *  b) Permission is hereby granted, free of charge, to any person
>>> + *     obtaining a copy of this software and associated documentation
>>> + *     files (the "Software"), to deal in the Software without
>>> + *     restriction, including without limitation the rights to use,
>>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>>> + *     sell copies of the Software, and to permit persons to whom the
>>> + *     Software is furnished to do so, subject to the following
>>> + *     conditions:
>>> + *
>>> + *     The above copyright notice and this permission notice shall be
>>> + *     included in all copies or substantial portions of the Software.
>>> + *
>>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>> + *     OTHER DEALINGS IN THE SOFTWARE.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +#include "sun6i-a31s.dtsi"
>>> +#include "sunxi-common-regulators.dtsi"
>>> +
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/input/input.h>
>>> +#include <dt-bindings/pinctrl/sun4i-a10.h>
>>> +
>>> +/ {
>>> +     model = "MSI Primo81 tablet";
>>> +     compatible = "msi,primo81", "allwinner,sun6i-a31s";
>>> +};
>>> +
>>> +&cpu0 {
>>> +     cpu-supply = <&reg_dcdc3>;
>>> +};
>>> +
>>> +&ehci0 {
>>> +     /* rtl8188etv wifi is connected here */
>>> +     status = "okay";
>>> +};
>>> +
>>> +&i2c0 {
>>> +     /* pull-ups and device VDDIO use AXP221 DLDO3 */
>>> +     pinctrl-names = "default";
>>> +     pinctrl-0 = <&i2c0_pins_a>;
>>> +     status = "failed";
>>> +};
>>> +
>>> +&i2c1 {
>>> +     pinctrl-names = "default";
>>> +     pinctrl-0 = <&i2c1_pins_a>;
>>> +     status = "okay";
>>> +
>>> +     ctp@5d {
>>> +             pinctrl-names = "default";
>>> +             pinctrl-0 = <&gt911_int_primo81>;
>>> +             compatible = "goodix,gt911";
>>> +             reg = <0x5d>;
>>> +             interrupt-parent = <&pio>;
>>> +             interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>; /* PA3 */
>>
>> I'd like to add a
>>
>>                 touchscreen-swapped-x-y = "true";

You don't need the '="true"' part. Boolean properties mean true
if they exist, and false if they aren't.

>>
>> as described in
>> Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>> here, as the display is in portrait mode while the touchscreen is
>> in landscape mode and needs to have the x and y axes swapped to
>> work in the same coordinate system as the display.
>>
>> Regarding the driver side: the goodix driver in kernel 4.3
>> doesn't yet support this property, but patches to add support for
>> it are on the linux-input list and should hopefully make it into
>> kernel 4.4.
>
> The DTS is already in Maxime's tree, and in sunxi-next. Feel free to
> send a follow-up patch adding them. I was waiting for those patches
> to be merged.

Sorry, spoke too soon. Maxime hasn't pushed it out yet. Could you send
a patch adding touchscreen-swapped-x-y for Maxime to squash in?

My tablet is at my office. I won't be able to test it over the weekend.

Thanks
ChenYu
