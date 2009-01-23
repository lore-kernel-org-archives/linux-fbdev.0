From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing
	Unit DMA and IRQ drivers
Date: Fri, 23 Jan 2009 13:18:04 +0000
Message-ID: <20090123131804.GI26184@n2100.arm.linux.org.uk>
References: <4978C01B.8080707@epfl.ch>
	<Pine.LNX.4.64.0901221959100.7935@axis700.grange>
	<4978CD75.70203@epfl.ch>
	<Pine.LNX.4.64.0901222122150.7935@axis700.grange>
	<49798E4A.4030709@epfl.ch>
	<Pine.LNX.4.64.0901231040420.4463@axis700.grange>
	<4979A88A.5010102@epfl.ch>
	<Pine.LNX.4.64.0901231308040.4463@axis700.grange>
	<4979BFC1.1070504@epfl.ch>
	<Pine.LNX.4.64.0901231407030.6497@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69) (envelope-from
	<linux+linux-fbdev-devel=lists.sourceforge.net@arm.linux.org.uk>)
	id 1LQLvu-0001KL-Kx for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 13:18:50 +0000
Received: from caramon.arm.linux.org.uk ([78.32.30.218])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LQLvl-0002T2-C9
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 13:18:50 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0901231407030.6497@axis700.grange>
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
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Dan Williams <dan.j.williams@intel.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Valentin Longchamp <valentin.longchamp@epfl.ch>

On Fri, Jan 23, 2009 at 02:12:31PM +0100, Guennadi Liakhovetski wrote:
> On Fri, 23 Jan 2009, Valentin Longchamp wrote:
> 
> > Well no miracle is taking place (And I have checked, the kernel I am
> > running is the correct one according to the build date tag with uname).
> > For me the initcalls are:
> > 
> > c0019390 <__initcall_misc_init4>:
> > c0019394 <__initcall_ipu_init4>:
> > c0019398 <__initcall_proto_init4>:
> > 
> > (Not exactly the same addresses as before because I add some pr_debug
> > calls for debug). But none of them are called. And all of them are
> > subsys_initcall. Do I have to enable something in my configuration so
> > that these initcall actually get called ?
> 
> Let's say, this is the first time that I run into a situation when some 
> initcalls do not get called, and I never bothered setting any special 
> config variable for that, and it would surprise me a _lot_ if such a 
> variable existed... What kernel version is this?

Well, the code which runs the initcalls steps through the array of
function pointers built by the linker one word at a time.  So the
only way an initcall could be missed in the middle of the array is
if:

1. the linker omitted the call (IOW buggy toolchain)
2. something corrupted kernel memory

I've personally never seen a situation where only some initcalls are
called, but then I tend to hang on to known reliable toolchains.

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
