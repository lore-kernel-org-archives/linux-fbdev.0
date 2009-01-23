From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing Unit DMA and IRQ drivers
Date: Fri, 23 Jan 2009 13:08:05 +0000
Message-ID: <20090123130805.GH26184@n2100.arm.linux.org.uk>
References: <Pine.LNX.4.64.0901081857170.6387@axis700.grange>
	<4978C01B.8080707@epfl.ch>
	<Pine.LNX.4.64.0901221959100.7935@axis700.grange>
	<4978CD75.70203@epfl.ch>
	<Pine.LNX.4.64.0901222122150.7935@axis700.grange>
	<49798E4A.4030709@epfl.ch>
	<Pine.LNX.4.64.0901231040420.4463@axis700.grange>
	<4979A88A.5010102@epfl.ch>
	<Pine.LNX.4.64.0901231308040.4463@axis700.grange>
	<4979BFC1.1070504@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <4979BFC1.1070504@epfl.ch>
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

On Fri, Jan 23, 2009 at 02:01:53PM +0100, Valentin Longchamp wrote:
> However, they all have the same "look" so to say: no real ARM assembly
> instruction but only addresses as Russel pointed it before:
> 
> > c0019390 <__initcall_misc_init4>:
> > c0019390:       c001349c        .word   0xc001349c
> > 
> > c0019394 <__initcall_ipu_init4>:
> > c0019394:       c0014258        .word   0xc0014258
> > 
> > c0019398 <__initcall_proto_init4>:
> > c0019398:       c00143e4        .word   0xc00143e4
> 
> This may be the reason why these initcall are not actually called:
> Guennadi's ones had a real ARM assembly instruction. To solve all my
> problems I need to understand why my subsys_initcall do not get called.

You really haven't understood the point.  In both cases, they are
ADDRESSES not INSTRUCTIONS.  They _must_ always be addresses since
they are _pointers_ _to_ _functions_.

So there's nothing wrong with what you show above.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
