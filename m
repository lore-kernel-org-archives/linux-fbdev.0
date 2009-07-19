From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH 1/2] ep93xx framebuffer driver
Date: Sun, 19 Jul 2009 22:30:59 +1200
Message-ID: <4A62F5E3.2000208@bluewatersys.com>
References: <4A5FF431.2000308@bluewatersys.com>
	<4A5FF6BB.4000700@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901AC1FF7@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901AC1FF7@mi8nycmail19.Mi8.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: arm kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, Daniele Venzano <d.venzano@motronica.com>

H Hartley Sweeten wrote:
> On Thursday, July 16, 2009 8:58 PM, Ryan Mallon wrote:
>> diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
>> index a11ae77..33765fa 100644
>> --- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
>> +++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
>> @@ -70,6 +70,7 @@
>>  #define EP93XX_USB_PHYS_BASE		(EP93XX_AHB_PHYS_BASE + 0x00020000)
>>  #define EP93XX_USB_BASE			EP93XX_AHB_IOMEM(0x00020000)
>>  
>> +#define EP93XX_RASTER_PHYS_BASE		(EP93XX_AHB_PHYS_BASE + 0x00030000)
>>  #define EP93XX_RASTER_BASE		EP93XX_AHB_IOMEM(0x00030000)
>>  
>>  #define EP93XX_GRAPHICS_ACCEL_BASE	EP93XX_AHB_IOMEM(0x00040000)
>> @@ -206,13 +207,17 @@
>>  #define EP93XX_SYSCON_DEVCFG_ADCPD	(1<<2)
>>  #define EP93XX_SYSCON_DEVCFG_KEYS	(1<<1)
>>  #define EP93XX_SYSCON_DEVCFG_SHENA	(1<<0)
>> +#define EP93XX_SYSCON_VIDCLKDIV		EP93XX_SYSCON_REG(0x84)
>> +#define EP93XX_SYSCON_CLKDIV_PSEL	(1 << 13)
>> +#define EP93XX_SYSCON_CLKDIV_ESEL	(1 << 14)
>> +#define EP93XX_SYSCON_CLKDIV_ENABLE	(1 << 15)
>> +#define EP93XX_SYSCON_CLKDIV_PDIV_SHIFT	8
>>  #define EP93XX_SYSCON_KEYTCHCLKDIV	EP93XX_SYSCON_REG(0x90)
>>  #define EP93XX_SYSCON_KEYTCHCLKDIV_TSEN	(1<<31)
>>  #define EP93XX_SYSCON_KEYTCHCLKDIV_ADIV	(1<<16)
>>  #define EP93XX_SYSCON_KEYTCHCLKDIV_KEN	(1<<15)
>>  #define EP93XX_SYSCON_KEYTCHCLKDIV_KDIV	(1<<0)
>>  #define EP93XX_SYSCON_SWLOCK		EP93XX_SYSCON_REG(0xc0)
> 
> What tree is this patch based on?  The KEYTCHCLKDIV defines are not in Russell's
> devel branch.

I put the patch to fix the keypad #defines in my tree before rebasing
the driver. I think this order is preferred since the keypad defines
patch is needed for the tree to build without errors.

> If (1 << 13) is preferred over (1<<13) we should eventually update this entire file
> so that the defines are consistent.

I prefer the spaces, but I'll change them in the header file so it is
consistent with the rest of the file. We can do a patch later to change
all of the defines in the header file, but I honestly don't think it
matters as long as it is consistent.

~Ryan


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
