From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: Re: [PATCH 1/2] pxa: introduce GPIOxx_LCD_* macros for easier pin
	configuration
Date: Fri, 12 Dec 2008 10:41:43 +0800
Message-ID: <f17812d70812111841o5d2fc957se524ad0dd652f45b@mail.gmail.com>
References: <f17812d70812110104y4b3d9b40i2f1c5d22e97988db@mail.gmail.com>
	<20081211163912.GB4407@excalibur.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20081211163912.GB4407@excalibur.local>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, Jaya Kumar <jayakumar.lkml@gmail.com>, Mike Rapoport <mike@compulab.co.il>, Richard Purdie <rpurdie@rpsys.net>, Ian Molton <spyro@f2s.com>, pHilipp Zabel <philipp.zabel@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Marc Zyngier <maz@misterjones.org>, Juergen Schindele <linux@schindele.name>

On Fri, Dec 12, 2008 at 12:39 AM, Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
> Hello.
>
> On Thu, 2008-12-11 at 17:04, Eric Miao wrote:
>> From ed2c9a22a9653880fad7e22333c7d6155c45c399 Mon Sep 17 00:00:00 2001
>> From: Eric Miao <eric.miao@marvell.com>
>> Date: Thu, 11 Dec 2008 13:34:54 +0800
>> Subject: [PATCH] [ARM] pxa: introduce GPIOxx_LCD_* macros for easier
>> pin configuration
>>
>> For those peripherals with only one possible pin configuration, introduce
>> handy macros of GPIOxx_*, it also avoids potential copy-and-paste errors.
>>
>> Let's start from LCD for PXA25x/PXA27x, depending on the different mode
>> used: passive (STN), active (TFT) and LCD with internal framebuffer (i.e.
>> smart panel), and the actual number of pins used to connect to the LCD
>> panel, the configurations slightly differ.
>>
>> Also, let's fix the issue of LCD pin configurations are missed from some
>> platforms (e.g. am200epd, cm-x270, e400)
>>
>> NOTE: the 18bpp and smart panel are only available on PXA27x.
>
> [SNIP]
>
>> diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
>> index 4f212e1..051fc49 100644
>> --- a/arch/arm/mach-pxa/ezx.c
>> +++ b/arch/arm/mach-pxa/ezx.c
>> @@ -147,6 +147,9 @@ static unsigned long gen1_pin_config[] __initdata = {
>>       /* flip / lockswitch */
>>       GPIO12_GPIO,
>>
>> +     /* LCD */
>> +     GPIOxx_LCD_TFT_16BPP,
>> +
>>       /* bluetooth (bcm2035) */
>>       GPIO14_GPIO | WAKEUP_ON_LEVEL_HIGH,     /* HOSTWAKE */
>>       GPIO48_GPIO,                            /* RESET */
>> @@ -205,6 +208,9 @@ static unsigned long gen2_pin_config[] __initdata = {
>>       /* EOC */
>>       GPIO10_GPIO,
>>
>> +     /* LCD */
>> +     GPIOxx_LCD_TFT_18BPP,
>> +
>>       /* bluetooth (bcm2045) */
>>       GPIO13_GPIO | WAKEUP_ON_LEVEL_HIGH,     /* HOSTWAKE */
>>       GPIO37_GPIO,                            /* RESET */
>
> The ezx.c part looks fine to me. If you like you could put my ACK in, but I
> don't think you need it being a pxa maintainer.
>

Just the opposite, I need your Ack to make sure I'm not breaking anything
that I don't have a chance to test. So this is really appreciated instead.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
