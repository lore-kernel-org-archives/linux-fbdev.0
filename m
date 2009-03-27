From: pcolodron@uvigo.es
Subject: Re: Xilinx framebuffer
Date: Fri, 27 Mar 2009 10:51:53 +0100
Message-ID: <20090327105153.g55s75ug0gc8skww@correoweb.uvigo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <pcolodron@uvigo.es>) id 1Ln8jQ-0006qf-V0
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Mar 2009 09:52:08 +0000
Received: from cebola.uvigo.es ([193.146.32.124])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ln8jH-0005tq-4B
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Mar 2009 09:52:03 +0000
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Krzysztof,

First of all, thanks for replying so fast, I was starting to think  =

that nobody could help with this...

Due to my unexperience in this field I will have to ask you some basic  =

questions. What do you mean when you say 'device definition file'? I  =

have been reading some things about platform devices and drivers but I  =

still don't know where can I find the file which defines the features  =

of my platform device.

Could be the problem that I am not configuring properly the parameters  =

REG_FB_ADDR and REG_CTRL? As far as I know, these values are the  =

addresses of the control registers of my TFT controller. In my case,  =

the values are 0x86e00000 and 0x86e00004. Inside the first register,  =

the starting address of the framebuffer can be found (which is  =

0x8FC00000). Is this right or should I define the parameter  =

REG_FB_ADDR as the physical address of the framebuffer directly  =

(0x8FC00000)?

Thank you so much for your help Krzysztof.

Regards,

Pablo


Krzysztof Helt escribi=F3:
> Hi Pablo,
>
>
> On Thu, 26 Mar 2009 12:28:00 +0100
> pcolodron@uvigo.es wrote:
>
>> Hi all,
>>
>> My name is Pablo and I am a new subscriber of this list.
>>
>> I have seen many post here related to the framebuffer driver   =

>> 'xilinxfb.c' and I hope you can solve some doubts that I have about  =

>> it.
>>
>> I am actually trying to generate a uClinux core for my Virtex4   =

>> development kit, which uses Microblaze and has a Xilinx TFT  =

>> controller  IP core (which I have tested and it works correctly).
>>
>> When it comes to boot the kernel, I have used some printk()  =

>> functions  to follow the execution flow because I am quite  =

>> unexperienced in  device drivers. I have seen something strange in  =

>> silinxfb.c, and I  would like you to tell me if this is a common  =

>> error of begginer users.  The issue is that I added printk() in the  =

>> following parts of  'xilinxfb.c':
>>
>
> (... )
>> Checking the message on the console when the system boots, I can  =

>> see  the following:
>>
>> io scheduler deadline registered
>> io scheduler cfq registered (default)
>> step 1
>> step 2
>> step 3
>> step 4
>> paso 5
>> xgpio0 #0 at 0x81400000 mapped to 0x81400000 device: 10,185 not using IRQ
>> xgpio1 #1 at 0x81420000 mapped to 0x81420000 device: 10,186 not using IRQ
>>
>> I think this means that the function xilinxfb_platform_probe() in   =

>> 'xilinxfb.c' is not being executed and, as a consequence, either   =

>> xilinxfb_assing() is. It seems logic because there are no message   =

>> about the framebuffer in the boot log (in xilinxfb_assign there are  =

>>  some dev_dbg() functions that should show this information  =

>> messages).
>>
>> Do you have any idea about why this is happening? Other devices  =

>> like  xgpio are recognized by the kernel and the structure of the  =

>> drivers is  similar to the one used in xilinxfb.c. Moreover, in my  =

>> uClinux system  I can see the following:
>>
>> # ls sys/bus/platform/drivers/
>> i8042        uartlite     xilinx_gpio  xilinxfb
>> # ls sys/bus/platform/devices/
>> i8042          uartlite.0     xilinx_gpio.0  xilinx_gpio.1
>>
>
> The xilinxfb_init function is called if only the xilinxfb driver is  =

> loaded or during kernel boot if it is compiled into the kernel.
>
> The xilinxfb_probe function is called if you registered a correct  =

> xilinxfb platform device.
> Can you post a part of your device definition file which contains  a  =

> definition of the xilinxfb platform device?
>
> The error seems to be in your platform definition. You have to  =

> register a correct platform device
> for the xilinxfb. Then the probe function will be called.
>
> Regards,
> Krzysztof
>
>
> ----------------------------------------------------------------------
> Udar sloneczny prezesa Kaczynskiego... >>> http://link.interia.pl/f2083
>
>



---------------------------------------------------------------------------=
---
