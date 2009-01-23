From: Valentin Longchamp <valentin.longchamp@epfl.ch>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing
	Unit DMA and IRQ drivers
Date: Fri, 23 Jan 2009 10:30:50 +0100
Message-ID: <49798E4A.4030709@epfl.ch>
References: <Pine.LNX.4.64.0901081850280.6387@axis700.grange>
	<Pine.LNX.4.64.0901081857170.6387@axis700.grange>
	<4978C01B.8080707@epfl.ch>
	<Pine.LNX.4.64.0901221959100.7935@axis700.grange>
	<4978CD75.70203@epfl.ch>
	<Pine.LNX.4.64.0901222122150.7935@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <valentin.longchamp@epfl.ch>) id 1LQINX-0006Av-Jj
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 09:31:07 +0000
Received: from smtp0.epfl.ch ([128.178.224.219])
	by 29vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1LQINT-0007Yo-5a for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 09:31:07 +0000
In-Reply-To: <Pine.LNX.4.64.0901222122150.7935@axis700.grange>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Dan Williams <dan.j.williams@intel.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

Guennadi Liakhovetski wrote:
> On Thu, 22 Jan 2009, Valentin Longchamp wrote:
> 
>> Guennadi Liakhovetski wrote:
>>> On Thu, 22 Jan 2009, Valentin Longchamp wrote:
>>>
>>> You need the patch 4/4 - platform bindings, which is not in that queue and
>>> will only be merged in the next kernel version. You can so far pick it up
>>> here:
>>>
>>> http://marc.info/?l=linux-arm-kernel&m=123143901514438&w=2
>>>
>> I have the platform bindings, the ipu-core platform_device (from patch 4/4) is
>> registered on my system. It's only the ipu-core platform_driver  (from patch
>> 2/4) that is not registered and I don't understand why.
> 
> Ok, you didn't mention this in your previous mail. I don't think the 
> platform-driver is not registered. Can you check whether the ipu_init() 
> function gets called? Looks like the ipu platform device is not registered 
> on your system. Look at patch 4/4. In your board code you do something 
> like
> 
> +	mx3_register_fb(fb_modedb[0].name, fb_modedb, ARRAY_SIZE(fb_modedb));

Yes I do this in my board initialisation code. Yes I have it and it also
works, see below.

> 
> in that function
> 
> +	if (!ipu_registered) {
> +		int ret = platform_device_register(&mx3_ipu);

Yes I also have this in my devices.c file (just as you proposed it in
your 4/4 patch). And if works, see below.

> 
> Do you have the ipu platform device under /sys/devices/platform/?
> 

Yes I do have it. But I do not it under /sys/bus/platform/drivers.

> root@mx31moboard:~# ls -al /sys/devices/platform/
> drwxr-xr-x    8 root     root            0 Oct 16 14:04 .
> drwxr-xr-x    4 root     root            0 Oct 16 14:04 ..
> drwxr-xr-x    2 root     root            0 Oct 16 14:04 imx-uart.0
> drwxr-xr-x    2 root     root            0 Oct 16 14:04 imx-uart.1
> drwxr-xr-x    2 root     root            0 Oct 16 14:04 imx-uart.4
> drwxr-xr-x    2 root     root            0 Oct 16 14:04 ipu_core
> drwxr-xr-x    2 root     root            0 Oct 16 14:04 mx3_sdc_fb
> drwxr-xr-x    2 root     root            0 Oct 16 14:04 physmap-flash.0
> -rw-r--r--    1 root     root         4096 Oct 16 14:04 uevent

> root@mx31moboard:~# ls -al /sys/bus/platform/drivers
> drwxr-xr-x    6 root     root            0 Oct 16 13:50 .
> drwxr-xr-x    4 root     root            0 Jan  1  1970 ..
> drwxr-xr-x    2 root     root            0 Jan  1  1970 generic-bl
> drwxr-xr-x    2 root     root            0 Jan  1  1970 imx-uart
> drwxr-xr-x    2 root     root            0 Oct 16 14:05 mx3_sdc_fb
> drwxr-xr-x    2 root     root            0 Jan  1  1970 physmap-flash

So the devices are registered fine. My problem is that the driver is not
registered for me: This should be done by the subsys_initcall but
ipu_init is never called.

Thanks for your help.

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp@epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne


------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
