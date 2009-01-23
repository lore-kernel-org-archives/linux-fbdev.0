From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing Unit DMA and IRQ drivers
Date: Fri, 23 Jan 2009 13:13:26 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0901231308040.4463@axis700.grange>
References: <Pine.LNX.4.64.0901081850280.6387@axis700.grange>
	<Pine.LNX.4.64.0901081857170.6387@axis700.grange>
	<4978C01B.8080707@epfl.ch>
	<Pine.LNX.4.64.0901221959100.7935@axis700.grange>
	<4978CD75.70203@epfl.ch>
	<Pine.LNX.4.64.0901222122150.7935@axis700.grange>
	<49798E4A.4030709@epfl.ch>
	<Pine.LNX.4.64.0901231040420.4463@axis700.grange>
	<4979A88A.5010102@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <4979A88A.5010102@epfl.ch>
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
To: Valentin Longchamp <valentin.longchamp@epfl.ch>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Dan Williams <dan.j.williams@intel.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 23 Jan 2009, Valentin Longchamp wrote:

> Guennadi Liakhovetski wrote:
> > On Fri, 23 Jan 2009, Valentin Longchamp wrote:
> >> So the devices are registered fine. My problem is that the driver is not
> >> registered for me: This should be done by the subsys_initcall but
> >> ipu_init is never called.
> > 
> > Are you sure you have CONFIG_MX3_IPU=y?... sorry, I don't see any other 
> > possibility why a subsys_initcall() would not be called. You can also 
> > check if it's being compiled and linked, and if you do
> > 
> > arm-linux-objdump -Dr vmlinux |grep ipu_init
> > 
> > you should see something like
> > 
> > c0014c94 <ipu_init>:
> > c0014c94:       e1a0c00d        mov     ip, sp
> > --
> > c0019c70 <__initcall_ipu_init4>:
> > c0019c70:       c0014c94        mulgt   r1, r4, ip
> > 
> 
> Well I have all of them ... Taht's why I really don't understand what's
> going on.
> 
> However I don't have the same asm instruction for the initcall:
> 
> c00192b4 <__initcall_ipu_init4>:
> c00192b4:       c00141e8        .word   0xc00141e8
> 
> But that's the address of my ipu_init
> c00141e8 <ipu_init>:
> c00141e8:       e1a0c00d        mov     ip, sp
> c00141ec:       e92dd800        push    {fp, ip, lr, pc}
> c00141f0:       e24cb004        sub     fp, ip, #4      ; 0x4
> 
> I think something is working badly with the initcall (subsys). Has
> someone already experienced something similar ?

Strange, try to look which initcalls are before and after ipu_init in your 
kernel:

arm-linux-objdump -Dr vmlinux |grep __initcall_ |less

which on my kernel produces

...
c0019c6c <__initcall_input_init4>:
c0019c70 <__initcall_ipu_init4>:
c0019c74 <__initcall_proto_init4>:
...

and see whether those other two initcalls get called, if they do, then 
either you're running a different kernel from the one you're looking at, 
or it _does_ get called and you're debugging wrongly, or you have a very 
selective memory corruption, or... a miracle is taking place.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
