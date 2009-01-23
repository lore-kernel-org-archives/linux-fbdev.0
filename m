From: Valentin Longchamp <valentin.longchamp@epfl.ch>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing Unit DMA and IRQ drivers
Date: Fri, 23 Jan 2009 14:01:53 +0100
Message-ID: <4979BFC1.1070504@epfl.ch>
References: <Pine.LNX.4.64.0901081850280.6387@axis700.grange>
	<Pine.LNX.4.64.0901081857170.6387@axis700.grange>
	<4978C01B.8080707@epfl.ch>
	<Pine.LNX.4.64.0901221959100.7935@axis700.grange>
	<4978CD75.70203@epfl.ch>
	<Pine.LNX.4.64.0901222122150.7935@axis700.grange>
	<49798E4A.4030709@epfl.ch>
	<Pine.LNX.4.64.0901231040420.4463@axis700.grange>
	<4979A88A.5010102@epfl.ch>
	<Pine.LNX.4.64.0901231308040.4463@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.64.0901231308040.4463@axis700.grange>
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
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Longchamp Valentin <valentin.longchamp@epfl.ch>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Dan Williams <dan.j.williams@intel.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

Guennadi Liakhovetski wrote:
> On Fri, 23 Jan 2009, Valentin Longchamp wrote:
>> I think something is working badly with the initcall (subsys). Has
>> someone already experienced something similar ?
> 
> Strange, try to look which initcalls are before and after ipu_init in your 
> kernel:
> 
> arm-linux-objdump -Dr vmlinux |grep __initcall_ |less
> 
> which on my kernel produces
> 
> ...
> c0019c6c <__initcall_input_init4>:
> c0019c70 <__initcall_ipu_init4>:
> c0019c74 <__initcall_proto_init4>:
> ...
> 
> and see whether those other two initcalls get called, if they do, then 
> either you're running a different kernel from the one you're looking at, 
> or it _does_ get called and you're debugging wrongly, or you have a very 
> selective memory corruption, or... a miracle is taking place.
> 

Well no miracle is taking place (And I have checked, the kernel I am
running is the correct one according to the build date tag with uname).
For me the initcalls are:

c0019390 <__initcall_misc_init4>:
c0019394 <__initcall_ipu_init4>:
c0019398 <__initcall_proto_init4>:

(Not exactly the same addresses as before because I add some pr_debug
calls for debug). But none of them are called. And all of them are
subsys_initcall. Do I have to enable something in my configuration so
that these initcall actually get called ?

However, they all have the same "look" so to say: no real ARM assembly
instruction but only addresses as Russel pointed it before:

> c0019390 <__initcall_misc_init4>:
> c0019390:       c001349c        .word   0xc001349c
> 
> c0019394 <__initcall_ipu_init4>:
> c0019394:       c0014258        .word   0xc0014258
> 
> c0019398 <__initcall_proto_init4>:
> c0019398:       c00143e4        .word   0xc00143e4

This may be the reason why these initcall are not actually called:
Guennadi's ones had a real ARM assembly instruction. To solve all my
problems I need to understand why my subsys_initcall do not get called.

Thank you all for your great help

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp@epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
