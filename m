From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: Xilinx framebuffer
Date: Thu, 26 Mar 2009 18:50:30 +0100
Message-ID: <20090326185030.24a466a0.krzysztof.h1@poczta.fm>
References: <20090326122800.1txn5bh4lps044g0@correoweb.uvigo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1LmtiF-00082z-3B
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Mar 2009 17:49:55 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LmtiB-0001H7-8r for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Mar 2009 17:49:55 +0000
In-Reply-To: <20090326122800.1txn5bh4lps044g0@correoweb.uvigo.es>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: pcolodron@uvigo.es
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Pablo,


On Thu, 26 Mar 2009 12:28:00 +0100
pcolodron@uvigo.es wrote:

> Hi all,
> 
> My name is Pablo and I am a new subscriber of this list.
> 
> I have seen many post here related to the framebuffer driver  
> 'xilinxfb.c' and I hope you can solve some doubts that I have about it.
> 
> I am actually trying to generate a uClinux core for my Virtex4  
> development kit, which uses Microblaze and has a Xilinx TFT controller  
> IP core (which I have tested and it works correctly).
> 
> When it comes to boot the kernel, I have used some printk() functions  
> to follow the execution flow because I am quite unexperienced in  
> device drivers. I have seen something strange in silinxfb.c, and I  
> would like you to tell me if this is a common error of begginer users.  
> The issue is that I added printk() in the following parts of  
> 'xilinxfb.c':
> 

(... )
> Checking the message on the console when the system boots, I can see  
> the following:
> 
> io scheduler deadline registered
> io scheduler cfq registered (default)
> step 1
> step 2
> step 3
> step 4
> paso 5
> xgpio0 #0 at 0x81400000 mapped to 0x81400000 device: 10,185 not using IRQ
> xgpio1 #1 at 0x81420000 mapped to 0x81420000 device: 10,186 not using IRQ
> 
> I think this means that the function xilinxfb_platform_probe() in  
> 'xilinxfb.c' is not being executed and, as a consequence, either  
> xilinxfb_assing() is. It seems logic because there are no message  
> about the framebuffer in the boot log (in xilinxfb_assign there are  
> some dev_dbg() functions that should show this information messages).
> 
> Do you have any idea about why this is happening? Other devices like  
> xgpio are recognized by the kernel and the structure of the drivers is  
> similar to the one used in xilinxfb.c. Moreover, in my uClinux system  
> I can see the following:
> 
> # ls sys/bus/platform/drivers/
> i8042        uartlite     xilinx_gpio  xilinxfb
> # ls sys/bus/platform/devices/
> i8042          uartlite.0     xilinx_gpio.0  xilinx_gpio.1
> 

The xilinxfb_init function is called if only the xilinxfb driver is loaded or during kernel boot if 
it is compiled into the kernel.

The xilinxfb_probe function is called if you registered a correct xilinxfb platform device.
Can you post a part of your device definition file which contains  a definition of the xilinxfb 
platform device?

The error seems to be in your platform definition. You have to register a correct platform device
for the xilinxfb. Then the probe function will be called.

Regards,
Krzysztof


----------------------------------------------------------------------
Udar sloneczny prezesa Kaczynskiego... >>> http://link.interia.pl/f2083


------------------------------------------------------------------------------
