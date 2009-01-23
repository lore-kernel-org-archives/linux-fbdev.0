From: Valentin Longchamp <valentin.longchamp@epfl.ch>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing
	Unit DMA and IRQ drivers
Date: Fri, 23 Jan 2009 12:22:50 +0100
Message-ID: <4979A88A.5010102@epfl.ch>
References: <Pine.LNX.4.64.0901081850280.6387@axis700.grange>
	<Pine.LNX.4.64.0901081857170.6387@axis700.grange>
	<4978C01B.8080707@epfl.ch>
	<Pine.LNX.4.64.0901221959100.7935@axis700.grange>
	<4978CD75.70203@epfl.ch>
	<Pine.LNX.4.64.0901222122150.7935@axis700.grange>
	<49798E4A.4030709@epfl.ch>
	<Pine.LNX.4.64.0901231040420.4463@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <valentin.longchamp@epfl.ch>) id 1LQK7m-00052G-0m
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 11:22:58 +0000
Received: from smtp0.epfl.ch ([128.178.224.219])
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1LQK7j-00071r-Jo for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 11:22:57 +0000
In-Reply-To: <Pine.LNX.4.64.0901231040420.4463@axis700.grange>
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
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Dan Williams <dan.j.williams@intel.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Longchamp Valentin <valentin.longchamp@epfl.ch>

Guennadi Liakhovetski wrote:
> On Fri, 23 Jan 2009, Valentin Longchamp wrote:
>> So the devices are registered fine. My problem is that the driver is not
>> registered for me: This should be done by the subsys_initcall but
>> ipu_init is never called.
> 
> Are you sure you have CONFIG_MX3_IPU=y?... sorry, I don't see any other 
> possibility why a subsys_initcall() would not be called. You can also 
> check if it's being compiled and linked, and if you do
> 
> arm-linux-objdump -Dr vmlinux |grep ipu_init
> 
> you should see something like
> 
> c0014c94 <ipu_init>:
> c0014c94:       e1a0c00d        mov     ip, sp
> --
> c0019c70 <__initcall_ipu_init4>:
> c0019c70:       c0014c94        mulgt   r1, r4, ip
> 

Well I have all of them ... Taht's why I really don't understand what's
going on.

However I don't have the same asm instruction for the initcall:

c00192b4 <__initcall_ipu_init4>:
c00192b4:       c00141e8        .word   0xc00141e8

But that's the address of my ipu_init
c00141e8 <ipu_init>:
c00141e8:       e1a0c00d        mov     ip, sp
c00141ec:       e92dd800        push    {fp, ip, lr, pc}
c00141f0:       e24cb004        sub     fp, ip, #4      ; 0x4

I think something is working badly with the initcall (subsys). Has
someone already experienced something similar ?

Thanks

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
