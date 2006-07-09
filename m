From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH]: frame buffer driver for 2700G LCD
 controller
Date: Mon, 10 Jul 2006 07:21:12 +0800
Message-ID: <44B18F68.2080802@gmail.com>
References: <44AD2B75.6050302@compulab.co.il> <44ADC4AE.2040903@gmail.com>
	<44B11542.7010402@compulab.co.il>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FziaZ-0005H1-2M for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 09 Jul 2006 16:21:23 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FziaY-0001gQ-6z
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 09 Jul 2006 16:21:22 -0700
Received: by py-out-1112.google.com with SMTP id n25so3283329pyg
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 09 Jul 2006 16:21:21 -0700 (PDT)
In-Reply-To: <44B11542.7010402@compulab.co.il>
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
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-fbdev-devel@lists.sourceforge.net

Mike Rapoport wrote:
> Antonino A. Daplas wrote:
> 
>> Mike Rapoport wrote:
>>  
>>
>>> This patch adds frame buffer driver for 2700G LCD controller present on
>>> CompuLab CM-X270 computer module.
>>> This pacth is versus current Linus git tree.
>>>
>>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>>>
>>>
>>>   
>>
>>  
>>
>>> +
>>> +static int
>>> +mbxfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
>>> +           u_int trans, struct fb_info *info)
>>>   
>>
>> Coding style, "static int" and "mbxfb_setcolreg" in one line.
>>
>>  
>>
> I've tried hard to remove all the coding styles mistakes and misprints,
> but some maybe still in there.
> 
>>> +{
>>> +    uint val, ret = 1;
>>>   
>>
>> If you can, avoid u_int and family and just use u32 and family.
>>
>>  
>>
> Done
> 
>>> +
>>> +    if ( regno < 255 ) {
>>> +        val = (red & 0xff) << 16;
>>> +        val |= (green & 0xff) << 8;
>>> +        val |= (blue & 0xff) << 0;
>>> +        GPLUT = Gplut_Lutadr(regno) | Gplut_Lutdata(val);
>>> +        udelay(1000);
>>> +        ret = 0;
>>>   
>>
>> If you want this to work as a console driver, make sure you also
>> write 'val' to info->pseudo_palette (for bpp 16 and above) and only
>> for regno's 0-15.
>>  
>>
>>
> I've tried to use this driver as console, but all I see is a blank
> screen. So, at least for now it cannot be used as a console :(

It's because you don't have an info->pseudo_palette. And if you accidentally
load the framebuffer console, your kernel will just crash because the
drawing functions (cfb_{fillrect,imageblit}) unconditionally refers to that
array.

So you have to do either one:

1. Create a properly filled up info->pseudo_palette; or
2. Do not use the cfb_* functions, and instead write one for your
own. It can be just dummy functions that don't do anything.

> 
>>> +#include "mbxsysfs.c"
>>> +
>>> +#define res_size(_r) (((_r)->end - (_r)->start) + 1)
>>>   
>>
>> No arch-specific function/macro's to determine the resource length?
>>  
>>
> I searched for one but in vain.

Okay, just wondering.

> 
>>> +static struct platform_driver mbxfb_driver = {
>>> +    .probe        = mbxfb_probe,
>>> +    .remove        = mbxfb_remove,
>>> +
>>> +#ifdef CONFIG_PM
>>>   
>>
>> Redundant #ifdef, suspend and resume are already defined as NULL if
>> CONFIG_PM is false.
>>
>>  
>>
>>> +    },
>>> +};
>>> +
>>> diff --git a/drivers/video/mbx/mbxsysfs.c b/drivers/video/mbx/mbxsysfs.c
>>> new file mode 100644
>>> index 0000000..4b9571a
>>> --- /dev/null
>>> +++ b/drivers/video/mbx/mbxsysfs.c
>>> @@ -0,0 +1,129 @@
>>>   
>>
>> Most of the attributes violate the "one file, one value" rule. GregKH
>> won't
>> like it. Try using debugfs if you cannot separate them.
>>
>>  
>>
> Changed to debugfs implementation.

Great :-).

> +/* extern unsigned long virt_base_2700; */
> +#define __REG_2700G(x)	(*(volatile unsigned long*)((x)+virt_base_2700))

BTW, you will need to use generic accessors (readb|w|l, writeb|w|l or
__raw_readb|w|l, __raw_writeb|w|l, etc). This will entail a lot of changes.
Otherwise, this driver won't get past Andrew Morton and Rusty.

See include/asm/io.h.

Tony



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
