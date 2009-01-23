From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing
	Unit DMA and IRQ drivers
Date: Fri, 23 Jan 2009 10:46:11 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0901231040420.4463@axis700.grange>
References: <Pine.LNX.4.64.0901081850280.6387@axis700.grange>
	<Pine.LNX.4.64.0901081857170.6387@axis700.grange>
	<4978C01B.8080707@epfl.ch>
	<Pine.LNX.4.64.0901221959100.7935@axis700.grange>
	<4978CD75.70203@epfl.ch>
	<Pine.LNX.4.64.0901222122150.7935@axis700.grange>
	<49798E4A.4030709@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <g.liakhovetski@gmx.de>) id 1LQIcC-0003jr-Tt
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 09:46:16 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1LQIc9-0003Oi-1F for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 09:46:16 +0000
In-Reply-To: <49798E4A.4030709@epfl.ch>
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

> > root@mx31moboard:~# ls -al /sys/bus/platform/drivers
> > drwxr-xr-x    6 root     root            0 Oct 16 13:50 .
> > drwxr-xr-x    4 root     root            0 Jan  1  1970 ..
> > drwxr-xr-x    2 root     root            0 Jan  1  1970 generic-bl
> > drwxr-xr-x    2 root     root            0 Jan  1  1970 imx-uart
> > drwxr-xr-x    2 root     root            0 Oct 16 14:05 mx3_sdc_fb
> > drwxr-xr-x    2 root     root            0 Jan  1  1970 physmap-flash
> 
> So the devices are registered fine. My problem is that the driver is not
> registered for me: This should be done by the subsys_initcall but
> ipu_init is never called.

Are you sure you have CONFIG_MX3_IPU=y?... sorry, I don't see any other 
possibility why a subsys_initcall() would not be called. You can also 
check if it's being compiled and linked, and if you do

arm-linux-objdump -Dr vmlinux |grep ipu_init

you should see something like

c0014c94 <ipu_init>:
c0014c94:       e1a0c00d        mov     ip, sp
--
c0019c70 <__initcall_ipu_init4>:
c0019c70:       c0014c94        mulgt   r1, r4, ip

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
