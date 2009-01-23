From: Valentin Longchamp <valentin.longchamp@epfl.ch>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing
	Unit DMA and IRQ drivers
Date: Fri, 23 Jan 2009 15:51:43 +0100
Message-ID: <4979D97F.7030007@epfl.ch>
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
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <valentin.longchamp@epfl.ch>) id 1LQNNv-0004ol-Qq
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 14:51:51 +0000
Received: from smtp0.epfl.ch ([128.178.224.219])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1LQNNq-0003nJ-Nb for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 14:51:51 +0000
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
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Dan Williams <dan.j.williams@intel.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

Guennadi Liakhovetski wrote:
> On Fri, 23 Jan 2009, Valentin Longchamp wrote:
> 
>>> root@mx31moboard:~# ls -al /sys/bus/platform/drivers
>>> drwxr-xr-x    6 root     root            0 Oct 16 13:50 .
>>> drwxr-xr-x    4 root     root            0 Jan  1  1970 ..
>>> drwxr-xr-x    2 root     root            0 Jan  1  1970 generic-bl
>>> drwxr-xr-x    2 root     root            0 Jan  1  1970 imx-uart
>>> drwxr-xr-x    2 root     root            0 Oct 16 14:05 mx3_sdc_fb
>>> drwxr-xr-x    2 root     root            0 Jan  1  1970 physmap-flash
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

Ok let's get back to this point. The initcall_debug=1 boot option helped
a lot (thanks Russel). So all initcalls correctly are called ipu_init
inclusive (my pr_debug calls did show nothing even with the debug and
dynamic_printk option, so I thought initcalls were not called ... I
don't understand what happened here). But the toolchain is not the
problem, and nor the initcalls.

So I know that ipu_init fails with -ENODEV and I am investigating. Sorry
for all the mails and thanks again all for your help.

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
