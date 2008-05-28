From: "Brian G. Rhodes" <bgr@acdstar.com>
Subject: Re: [directfb-users]  DirectFB without FBDev
Date: Wed, 28 May 2008 14:38:25 -0500
Message-ID: <483DB4B1.50304@acdstar.com>
References: <483D7344.6030503@directfb.org>	<Pine.LNX.4.64.0805281901300.15083@anakin>	<483D9453.1080700@directfb.org>
	<483D9C30.8010301@acdstar.com> <483D9F4E.4000707@directfb.org>
	<483DAAB7.6080208@acdstar.com> <483DAE58.4020300@directfb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1RSz-00055m-Jc for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 12:37:45 -0700
Received: from mailfront2.g2host.com ([208.42.176.213] helo=g2host.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K1RSz-0003h7-1l
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 12:37:45 -0700
In-Reply-To: <483DAE58.4020300@directfb.org>
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
To: Denis Oliver Kropp <dok@directfb.org>
Cc: directfb-users@directfb.org, linux-fbdev-devel@lists.sourceforge.net, directfb-dev@directfb.org, Geert Uytterhoeven <geert@linux-m68k.org>



Denis Oliver Kropp wrote:
> Brian G. Rhodes wrote:
>>
>>
>> Denis Oliver Kropp wrote:
>>> Brian G. Rhodes wrote:
>>>> I don't think the solution to abstracting access to multiple 
>>>> hardware planes which can be located in at dynamic memory addresses 
>>>> to be implemented by adding complexity to the framebuffer driver.  
>>>> It is supposed to be just a dumb chunk of memory and storage for 
>>>> hardware timings.
>>>>     
>>>
>>> Adding the byte offset and pitch fits into this as well and would save
>>> it from being removed from DirectFB.
>>>
>>>   
>>
>> Seems like an end-run around supporting windows in framebuffer memory 
>> and using pan to jump back and forth.  This obviously was not the 
>> original intention of panning.   I have seen it used quite a bit for 
>
> Yep, panning wasn't meant for buffer swapping initially :)
>
>> buffering and it seems like a pretty inelegant method for accessing 
>> the memory.  So you add a byte offset and a pitch so that you can 
>> pull out your next screen buffer.  Now you also need to add flags for 
>> the fb driver to tell the user-space implementation that it supports 
>> this functionality.  Pretty soon it's not a framebuffer driver.  Not 
>> that it's terribly atrocious what you suggest...  I didn't mean to 
>> come off as such.  I would just prefer that there is an intermediary 
>> interface to the fb driver which understands the hardware better and 
>> can manage these line-width writes better.
>
> You want to put something between fb driver and user space?
>
I would rather have an interface which marries the features of something 
like DirectFB with the functionality of kernel interfaces like linuxfb, 
v4l2 .....  rather than encumbering an interface like fbdev with too 
much intelligence.  Or.. more specifically with interface additions 
which some hardware simply cannot support.
>>>> It is too inefficient and in cases with hardware-assist (other than 
>>>> coprocessors), likely unnecessary.  The answer probably isn't using 
>>>> Video4Linux directly either.  Perhaps a DirectFB kernel component 
>>>> which can standardize an interface and provide a better 
>>>> architecture than v4l2 does.  An application where, as mentioned 
>>>> above, you are using video memory for multiple buffers as a 
>>>> implementation for queuing seems too specialized to me to ever be 
>>>> done in a linuxfb driver.
>>>>     
>>>
>>> It's not special regarding the hardware. Every driver with an interrupt
>>> handler could support it.
>>>
>>>   
>> No, it's not special with respect to the hardware.  It's special 
>> because you're turning your framebuffer into a fifo.
>
> No, it's just a FIFO between kernel and user space to set display offsets
> within the frame buffer.
>
I think that's splitting hairs but sure, a fifo between userspace and 
graphics memory implemented in the framebuffer driver.  The next step 
will be padding this 'fifo' with headers which hold information like, 
PTS,DTS.
>>>> Has any thought been given to designing a DirectFB kernel-space 
>>>> component which abstracts that access at the kernel level?  Seems 
>>>> to me that it would make direct interaction from directfb with 
>>>> specialized hardware much easier.
>>>>     
>>>
>>> I don't think a new kernel graphics interface should be added, 
>>> instead using
>>> UIO to access MMIO, DMA and IRQs would be enough and implement most 
>>> of the
>>> graphics driver in user space. Downside is to loose the kernel 
>>> console which
>>> you usually don't need on an embedded device...
>>> For acceleration and DMA/IRQ based programming, I still need to 
>>> check if a
>>> user space approach would be enough. So far I always handled IRQs in 
>>> kernel
>>> space for timing/performance reasons...
>>>
>>>   
>> I wouldn't want to signal userspace from an ISR to handle work.  All 
>> the unnecessary context switches just seem wasteful.  Or is there a 
>> better method now for waking up userspace from the kernel now?
>
> I agree. It would be nice to have some cheap context switch from 
> kernel to user
> space, or some way to create a less privileged kernel thread with less 
> overhead
> during switching, but the ability to execute non-root user's code. I 
> don't care
> about the overhead from user to kernel (system call), but kernel to 
> user (real time
> thread for IRQs) should be optimized. Just dropping some privileges 
> only sounds
> simple in that case though :)
>

There are 4 cases for decode + display that I can think of.

Software
Software + Coprocessor
Software + DSP
Software + DSP with proprietary firmware interface

The goal would be to make the first and last options work without either 
having to make sacrifices in performance while the application level can 
use a single interface.  Maybe there's a nice way of gating this in 
userspace without dirtying up the kernel.  I have yet to figure it out 
completely.  Not without extending the ioctl interface of the fb driver 
with a bunch of crap specific to each platform. 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
