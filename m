From: Valentin Longchamp <valentin.longchamp@epfl.ch>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing Unit DMA and IRQ drivers
Date: Fri, 23 Jan 2009 14:21:54 +0100
Message-ID: <4979C472.10707@epfl.ch>
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
	<20090123131804.GI26184@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20090123131804.GI26184@n2100.arm.linux.org.uk>
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
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Dan Williams <dan.j.williams@intel.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

Russell King - ARM Linux wrote:
> On Fri, Jan 23, 2009 at 02:12:31PM +0100, Guennadi Liakhovetski wrote:
>> On Fri, 23 Jan 2009, Valentin Longchamp wrote:
>>
>>> Well no miracle is taking place (And I have checked, the kernel I am
>>> running is the correct one according to the build date tag with uname).
>>> For me the initcalls are:
>>>
>>> c0019390 <__initcall_misc_init4>:
>>> c0019394 <__initcall_ipu_init4>:
>>> c0019398 <__initcall_proto_init4>:
>>>
>>> (Not exactly the same addresses as before because I add some pr_debug
>>> calls for debug). But none of them are called. And all of them are
>>> subsys_initcall. Do I have to enable something in my configuration so
>>> that these initcall actually get called ?
>> Let's say, this is the first time that I run into a situation when some 
>> initcalls do not get called, and I never bothered setting any special 
>> config variable for that, and it would surprise me a _lot_ if such a 
>> variable existed... What kernel version is this?

It's 2.6.29-rc2 from Linus's tree.

> 
> Well, the code which runs the initcalls steps through the array of
> function pointers built by the linker one word at a time.  So the
> only way an initcall could be missed in the middle of the array is
> if:
> 
> 1. the linker omitted the call (IOW buggy toolchain)
> 2. something corrupted kernel memory
> 
> I've personally never seen a situation where only some initcalls are
> called, but then I tend to hang on to known reliable toolchains.
> 

OK this may be a problem: I use the toolchain that is built by
OpeneEmbedded. I could give a try to another one. Where can I download
the ones you use Guennadi or Russel ?

Thanks

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
