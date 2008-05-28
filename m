From: Denis Oliver Kropp <dok-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Linux-fbdev-devel] DirectFB without FBDev
Date: Wed, 28 May 2008 21:11:20 +0200
Message-ID: <483DAE58.4020300@directfb.org>
References: <483D7344.6030503@directfb.org>	<Pine.LNX.4.64.0805281901300.15083@anakin>	<483D9453.1080700@directfb.org>
	<483D9C30.8010301@acdstar.com> <483D9F4E.4000707@directfb.org>
	<483DAAB7.6080208@acdstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <directfb-users-bounces-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <483DAAB7.6080208-3mWahjwryh5BDgjK7y7TUQ@public.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://mail.directfb.org/cgi-bin/mailman/listinfo/directfb-users>,
	<mailto:directfb-users-request-iGvX3keArt1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://mail.directfb.org/pipermail/directfb-users>
List-Post: <mailto:directfb-users-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:directfb-users-request-iGvX3keArt1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <http://mail.directfb.org/cgi-bin/mailman/listinfo/directfb-users>,
	<mailto:directfb-users-request-iGvX3keArt1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Sender: directfb-users-bounces-iGvX3keArt1g9hUCZPvPmw@public.gmane.org
Errors-To: directfb-users-bounces-iGvX3keArt1g9hUCZPvPmw@public.gmane.org
To: "Brian G. Rhodes" <bgr-3mWahjwryh5BDgjK7y7TUQ@public.gmane.org>
Cc: directfb-users-iGvX3keArt1g9hUCZPvPmw@public.gmane.org, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, directfb-dev-iGvX3keArt1g9hUCZPvPmw@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Brian G. Rhodes wrote:
> 
> 
> Denis Oliver Kropp wrote:
>> Brian G. Rhodes wrote:
>>> I don't think the solution to abstracting access to multiple hardware 
>>> planes which can be located in at dynamic memory addresses to be 
>>> implemented by adding complexity to the framebuffer driver.  It is 
>>> supposed to be just a dumb chunk of memory and storage for hardware 
>>> timings.
>>>     
>>
>> Adding the byte offset and pitch fits into this as well and would save
>> it from being removed from DirectFB.
>>
>>   
> 
> Seems like an end-run around supporting windows in framebuffer memory 
> and using pan to jump back and forth.  This obviously was not the 
> original intention of panning.   I have seen it used quite a bit for 

Yep, panning wasn't meant for buffer swapping initially :)

> buffering and it seems like a pretty inelegant method for accessing the 
> memory.  So you add a byte offset and a pitch so that you can pull out 
> your next screen buffer.  Now you also need to add flags for the fb 
> driver to tell the user-space implementation that it supports this 
> functionality.  Pretty soon it's not a framebuffer driver.  Not that 
> it's terribly atrocious what you suggest...  I didn't mean to come off 
> as such.  I would just prefer that there is an intermediary interface to 
> the fb driver which understands the hardware better and can manage these 
> line-width writes better.

You want to put something between fb driver and user space?

>>> It is too inefficient and in cases with hardware-assist (other than 
>>> coprocessors), likely unnecessary.  The answer probably isn't using 
>>> Video4Linux directly either.  Perhaps a DirectFB kernel component 
>>> which can standardize an interface and provide a better architecture 
>>> than v4l2 does.  An application where, as mentioned above, you are 
>>> using video memory for multiple buffers as a implementation for 
>>> queuing seems too specialized to me to ever be done in a linuxfb driver.
>>>     
>>
>> It's not special regarding the hardware. Every driver with an interrupt
>> handler could support it.
>>
>>   
> No, it's not special with respect to the hardware.  It's special because 
> you're turning your framebuffer into a fifo.

No, it's just a FIFO between kernel and user space to set display offsets
within the frame buffer.

>>> Has any thought been given to designing a DirectFB kernel-space 
>>> component which abstracts that access at the kernel level?  Seems to 
>>> me that it would make direct interaction from directfb with 
>>> specialized hardware much easier.
>>>     
>>
>> I don't think a new kernel graphics interface should be added, instead 
>> using
>> UIO to access MMIO, DMA and IRQs would be enough and implement most of 
>> the
>> graphics driver in user space. Downside is to loose the kernel console 
>> which
>> you usually don't need on an embedded device...
>> For acceleration and DMA/IRQ based programming, I still need to check 
>> if a
>> user space approach would be enough. So far I always handled IRQs in 
>> kernel
>> space for timing/performance reasons...
>>
>>   
> I wouldn't want to signal userspace from an ISR to handle work.  All the 
> unnecessary context switches just seem wasteful.  Or is there a better 
> method now for waking up userspace from the kernel now?

I agree. It would be nice to have some cheap context switch from kernel to user
space, or some way to create a less privileged kernel thread with less overhead
during switching, but the ability to execute non-root user's code. I don't care
about the overhead from user to kernel (system call), but kernel to user (real time
thread for IRQs) should be optimized. Just dropping some privileges only sounds
simple in that case though :)

-- 
Best regards,
   Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"
