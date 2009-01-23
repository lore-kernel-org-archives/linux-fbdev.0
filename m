From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing Unit DMA and IRQ drivers
Date: Fri, 23 Jan 2009 11:34:06 +0000
Message-ID: <20090123113406.GG26184@n2100.arm.linux.org.uk>
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
Content-Disposition: inline
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
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Dan Williams <dan.j.williams@intel.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

On Fri, Jan 23, 2009 at 12:22:50PM +0100, Valentin Longchamp wrote:
> Guennadi Liakhovetski wrote:
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

This is not an instruction, it is an address.  Notice that c00141e8 is
your address of ipu_init, as c0014c94 is the address of ipu_init for
Guennadi.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
