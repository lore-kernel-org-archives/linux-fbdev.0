From: Denis Oliver Kropp <dok@directfb.org>
Subject: Re: [directfb-dev] [directfb-users] DirectFB
 without FBDev
Date: Sat, 31 May 2008 08:08:54 +0200
Message-ID: <4840EB76.6040506@directfb.org>
References: <483D7344.6030503@directfb.org>
	<Pine.LNX.4.64.0805281901300.15083@anakin>
	<483D9453.1080700@directfb.org> <483D9C30.8010301@acdstar.com>
	<483D9F4E.4000707@directfb.org>
	<20080529165452.GA7708@powerlinux.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2KGu-0005Hb-JN for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 23:08:56 -0700
Received: from directfb.org ([212.227.87.76] helo=www.directfb.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K2KGt-0005VE-3q
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 23:08:56 -0700
In-Reply-To: <20080529165452.GA7708@powerlinux.fr>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Sven Luther <sven@powerlinux.fr>
Cc: directfb-users@directfb.org, "Brian G. Rhodes" <bgr@acdstar.com>, linux-fbdev-devel@lists.sourceforge.net, directfb-dev@directfb.org, Geert Uytterhoeven <geert@linux-m68k.org>

Sven Luther wrote:
> On Wed, May 28, 2008 at 08:07:10PM +0200, Denis Oliver Kropp wrote:
>> Brian G. Rhodes wrote:
>> I don't think a new kernel graphics interface should be added, instead using
>> UIO to access MMIO, DMA and IRQs would be enough and implement most of the
>> graphics driver in user space. Downside is to loose the kernel console which
>> you usually don't need on an embedded device...
>>
>> For acceleration and DMA/IRQ based programming, I still need to check if a
>> user space approach would be enough. So far I always handled IRQs in kernel
>> space for timing/performance reasons...
> 
> Euh, well, i think the X / OpenGL approach showed us that to do DMA/IRQ,
> you need a kernel module, and what X/OpenGL is the DRI thingy.

In some cases performance might be sufficient if IRQs are just routed to user
space and handled in a real time thread. You can program the DMA engine from
user space, it's just the IRQ that's only arriving in kernel space.

> Would it make sense for directfb to re-use this selfsame infrasturcture,
> which already exists in the kernel, and is used by X, so kind of
> guaranteed to be available for many graphic cards ? 

If there are drivers within this framework that we could use it makes sense,
but for writing support for a new chip one has to consider the overhead of
using a framework vs benefits. Overhead could be in time to develop and/or at
runtime. Benefits could be safety by relying on proven core code, but also saving
time to develop by having to write less code.

> But maybe it is too complex or something ? 

It depends on what you need in kernel space. Have a look at the SH7722 kernel
module. I'm not sure if the benefits of DRI would be that big to compensate for
the overhead or limitations. E.g. this driver manages a self running DMA queue,
where in the ideal case you never have to do any system call, but just append data
to the DMA buffer from user space.

http://git.directfb.org/?p=core/DirectFB.git;a=blob;f=gfxdrivers/sh7722/kernel-module/sh7722gfx.c

This driver handles different interrupt sources, provides DMA for the accelerator
as mentioned above and implements a minor portion of JPEG encoding and decoding with
the rest done in user space.

-- 
Best regards,
   Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
