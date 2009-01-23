From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing
	Unit DMA and IRQ drivers
Date: Fri, 23 Jan 2009 14:12:31 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0901231407030.6497@axis700.grange>
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
	<4979BFC1.1070504@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <g.liakhovetski@gmx.de>) id 1LQLpm-0003HU-Cs
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 13:12:30 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1LQLpj-0007Wq-Me for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 13:12:30 +0000
In-Reply-To: <4979BFC1.1070504@epfl.ch>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Valentin Longchamp <valentin.longchamp@epfl.ch>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Dan Williams <dan.j.williams@intel.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

On Fri, 23 Jan 2009, Valentin Longchamp wrote:

> Well no miracle is taking place (And I have checked, the kernel I am
> running is the correct one according to the build date tag with uname).
> For me the initcalls are:
> 
> c0019390 <__initcall_misc_init4>:
> c0019394 <__initcall_ipu_init4>:
> c0019398 <__initcall_proto_init4>:
> 
> (Not exactly the same addresses as before because I add some pr_debug
> calls for debug). But none of them are called. And all of them are
> subsys_initcall. Do I have to enable something in my configuration so
> that these initcall actually get called ?

Let's say, this is the first time that I run into a situation when some 
initcalls do not get called, and I never bothered setting any special 
config variable for that, and it would surprise me a _lot_ if such a 
variable existed... What kernel version is this?

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
> Guennadi's ones had a real ARM assembly instruction.

No, they are just addresses.

> To solve all my
> problems I need to understand why my subsys_initcall do not get called.

Good luck... Try the same with older kernels - even without ipu, just your 
regular kernel, maybe bisect since when your initcalls do not get called? 
Or compare to some running kernel's configuration...

Cheers
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
