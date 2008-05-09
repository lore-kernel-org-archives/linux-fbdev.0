From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: Debugging pxafb and am200epd
Date: Fri, 9 May 2008 06:22:48 -0400
Message-ID: <45a44e480805090322m2119194paa30dc85fb0376d6@mail.gmail.com>
References: <45a44e480805081306v17421858w3fbde163d43118e8@mail.gmail.com>
	<E913911567467945BBEB9277E27868B0C1CDD5@msiexch01.marvell.com>
	<45a44e480805090317r2a428d82o1f95c3fc73b6163a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JuPkX-0003nC-3B for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 May 2008 03:22:49 -0700
Received: from rv-out-0708.google.com ([209.85.198.240])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JuPkW-00071l-Lt
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 May 2008 03:22:49 -0700
Received: by rv-out-0708.google.com with SMTP id f25so1173236rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 09 May 2008 03:22:48 -0700 (PDT)
In-Reply-To: <45a44e480805090317r2a428d82o1f95c3fc73b6163a@mail.gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Eric Miao <ymiao3@marvell.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, May 9, 2008 at 6:17 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> On Fri, May 9, 2008 at 5:20 AM, Eric Miao <ymiao3@marvell.com> wrote:
>> Hi Jaya,
>>
>>> -----Original Message-----
>>> From: Jaya Kumar [mailto:jayakumar.lkml@gmail.com]
>>> Sent: Friday, May 09, 2008 4:07 AM
>>> To: Eric Miao
>>> Cc: Linux Frame Buffer Device Development
>>> Subject: Debugging pxafb and am200epd
>>>
>>> Hi Eric,
>>>
>>> Just some quick questions and notes while trying to implement am200epd
>>> sharing pxafb's framebuffer.
>>>
>>> 1. pxafb_init is set to __devinit, but it is only called from
>>> module_init. Is my understanding correct that it should be __init?
>>
>> Yes indeed, it is not a HOTPLUG device obviously, there are some
>> variables associated, like g_options[], so will have another look
>> into this.
>>
>>> 2. pxafb currently doesn't implement module unloading support.  Is
>>> there a reason for this?
>>>
>>
>> From technical, I don't think so, yet there might be some if u want :)
>>  - this driver really has a long history, and
>>  - most uses it as builtin and never unload it
>
> I see. The reason I encountered it was because I was debugging and it
> was troublesome to reboot each time after testing. If you like, I can
> try to add the exit and remove code. It'll be useful if anyone else
> wants to do more weird stuff like am200epd. :-)
>
>>
>>> 3. I'm seeing weird behavior with insmod of am200epd on my test system
>>> on a gumstix. Probably something that I'm doing wrong but I wanted to
>>> ask advice here anyway. Here's what I'm doing:
>>> # insmod drivers/video/cfbcopyarea.ko && insmod
>>> drivers/video/cfbfillrect.ko && insmod drivers/video/cfbimgblt.ko
>>> # insmod drivers/video/syscopyarea.ko && insmod
>>> drivers/video/sysfillrect.ko && insmod drivers/video/sysimgblt.ko &&
>>> insmod drivers/video/fb_sys_fops.ko
>>> # insmod drivers/video/metronomefb.ko ; insmod drivers/video/pxafb.ko
>>> # grep pxafb_probe /proc/kallsyms
>>> bf014000 t pxafb_probe  [pxafb]
>>> # grep bf014000 /proc/kallsyms
>>> bf014000 t pxafb_probe  [pxafb]
>>> bf014000 t $a   [pxafb]
>>>
>>> The reason I was debugging this was because platform_device_add was
>>> failing from am200epd when am200epd is trying to add pxa2xx-fb. It
>>> would fail from platform_drv_probe. I found that it was because the
>>> pxafb's probe routine somehow gets replaced by other stuff. I was
>>> worried if it was due to am200epd so I then took out all the code from
>>> am200epd's init_module so it does nothing other than return 0. So the
>>> following insmod is of am200epd that has a completely empty
>>> init_module.
>>>
>>> # insmod arch/arm/mach-pxa/am200epd.ko
>>>
>>> # grep pxafb_probe /proc/kallsyms
>>> bf014000 t pxafb_probe  [pxafb]
>>>
>>> # grep bf014000 /proc/kallsyms
>>> bf014000 t am200_exit   [am200epd]
>>> bf014000 t $a   [am200epd]
>>> bf014000 t cleanup_module       [am200epd]
>>> bf014000 t pxafb_probe  [pxafb]
>>> bf014000 t $a   [pxafb]
>>>
>>> The above doesn't make sense to me. I don't understand why am200_exit
>>> is overloaded at the same address as pxafb_probe. Any suggestions on
>>> how to debug this?
>>>
>>
>> doesn't make sense to me either :), but check your am200epd.ko which I
>> wonder if it has included the pxafb.o already to avoid duplication code
>> being inserted (insmod should complain but I'm not sure)
>
> I've moved am200epd.ko to arch/arm/mach-pxa. The build for that says:
> obj-y                           += clock.o devices.o generic.o irq.o dma.o \
>                                   time.o gpio.o
> obj-$(CONFIG_MACH_AM200EPD)     += am200epd.o

the exact compile line that is generated by kbuild is:

  arm-linux-gcc -Wp,-MD,arch/arm/mach-pxa/.am200epd.o.d  -nostdinc
-isystem /home/jaya/metronome/gumstix-buildroot/build_arm_nofpu/staging_dir/lib/gcc/arm-linux-uclibcgnueabi/4.1.1/include
-D__KERNEL__ -Iinclude  -include include/linux/autoconf.h
-mlittle-endian -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
-fno-strict-aliasing -fno-common -Werror-implicit-function-declaration
-Os   -fno-stack-protector -marm -fno-omit-frame-pointer -mapcs
-mno-sched-prolog -mabi=aapcs-linux -mno-thumb-interwork
-D__LINUX_ARM_ARCH__=5 -march=armv5te -mtune=xscale -Wa,-mcpu=xscale
-msoft-float -Uarm -fno-omit-frame-pointer -fno-optimize-sibling-calls
-Wdeclaration-after-statement -Wno-pointer-sign    -DMODULE
-D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(am200epd)"
-D"KBUILD_MODNAME=KBUILD_STR(am200epd)" -c -o
arch/arm/mach-pxa/am200epd.o arch/arm/mach-pxa/am200epd.c

  arm-linux-ld -EL -r    -o arch/arm/mach-pxa/am200epd.ko
arch/arm/mach-pxa/am200epd.o arch/arm/mach-pxa/am200epd.mod.o



>
> It doesn't include pxafb.o. I even took out #include pxafb.h to see if
> that was the cause but it still happens. I just tested something
> different which was to load the empty am200epd first. Then load pxafb.
> When I do that, the overlap doesn't occur. But if I load pxafb first,
> and then load am200epd, then the overlap happens. I'm really confused
> why. I think I'll sleep on it and see what I can figure out this
> weekend. If anyone has any suggestions, that would be greatly
> appreciated.
>
> Thanks,
> jaya
>

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
