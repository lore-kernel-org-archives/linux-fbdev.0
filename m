From: "Brian G. Rhodes" <bgr@acdstar.com>
Subject: Re: [directfb-users]  DirectFB without FBDev
Date: Wed, 28 May 2008 13:55:51 -0500
Message-ID: <483DAAB7.6080208@acdstar.com>
References: <483D7344.6030503@directfb.org>	<Pine.LNX.4.64.0805281901300.15083@anakin>	<483D9453.1080700@directfb.org>
	<483D9C30.8010301@acdstar.com> <483D9F4E.4000707@directfb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1Qno-0000cW-0I for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 11:55:12 -0700
Received: from mailfront2.g2host.com ([208.42.176.213] helo=g2host.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K1Qnm-0002NB-JK
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 11:55:12 -0700
In-Reply-To: <483D9F4E.4000707@directfb.org>
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
>   
>>> Furthermore, the pan_display functionality could be enhanced to allow 
>>> a kernel side queue
>>> for frame accurate display of several buffers, e.g. video playback 
>>> with five or more buffers
>>> pre-rendered. A frame/sync counter and some new flags would be enough 
>>> to be added for this.
>>>   Ville Syrjala once did an extension like FBIO_FLIP or similar, maybe 
>>> he can elaborate.
>>>
>>> I'm also seeing the need to have one pool of memory used by different 
>>> frame buffer devices
>>> or some other way to support multiple layers without statically 
>>> partitioning memory that could
>>> be managed more intelligently.
>>>
>>> And how about such capabilities like layer opacity, alpha ramps...?
>>>
>>> I know all this was not required to run the kernel based terminal 
>>> emulation that the frame
>>> buffer device has been invented for :)
>>>
>>>   
>>>       
>> I don't think the solution to abstracting access to multiple hardware 
>> planes which can be located in at dynamic memory addresses to be 
>> implemented by adding complexity to the framebuffer driver.  It is 
>> supposed to be just a dumb chunk of memory and storage for hardware 
>> timings.
>>     
>
> Adding the byte offset and pitch fits into this as well and would save
> it from being removed from DirectFB.
>
>   

Seems like an end-run around supporting windows in framebuffer memory 
and using pan to jump back and forth.  This obviously was not the 
original intention of panning.   I have seen it used quite a bit for 
buffering and it seems like a pretty inelegant method for accessing the 
memory.  So you add a byte offset and a pitch so that you can pull out 
your next screen buffer.  Now you also need to add flags for the fb 
driver to tell the user-space implementation that it supports this 
functionality.  Pretty soon it's not a framebuffer driver.  Not that 
it's terribly atrocious what you suggest...  I didn't mean to come off 
as such.  I would just prefer that there is an intermediary interface to 
the fb driver which understands the hardware better and can manage these 
line-width writes better.

>> Considering video, and the amount of data which has to be shuffled 
>> around for higher resolution/bitrate files it does not make sense to 
>> require sending rendered frames off directly to a framebuffer device.  
>>     
>
> I was not talking about copying any data back and forth, but just keep
> a queue of start addresses assigned to future sync counters, being taken
> care of in IRQs.
>
>   
>> It is too inefficient and in cases with hardware-assist (other than 
>> coprocessors), likely unnecessary.  The answer probably isn't using 
>> Video4Linux directly either.  Perhaps a DirectFB kernel component which 
>> can standardize an interface and provide a better architecture than v4l2 
>> does.  An application where, as mentioned above, you are using video 
>> memory for multiple buffers as a implementation for queuing seems too 
>> specialized to me to ever be done in a linuxfb driver.
>>     
>
> It's not special regarding the hardware. Every driver with an interrupt
> handler could support it.
>
>   
No, it's not special with respect to the hardware.  It's special because 
you're turning your framebuffer into a fifo.
>> Has any thought been given to designing a DirectFB kernel-space 
>> component which abstracts that access at the kernel level?  Seems to me 
>> that it would make direct interaction from directfb with specialized 
>> hardware much easier.
>>     
>
> I don't think a new kernel graphics interface should be added, instead using
> UIO to access MMIO, DMA and IRQs would be enough and implement most of the
> graphics driver in user space. Downside is to loose the kernel console which
> you usually don't need on an embedded device...
> For acceleration and DMA/IRQ based programming, I still need to check if a
> user space approach would be enough. So far I always handled IRQs in kernel
> space for timing/performance reasons...
>
>   
I wouldn't want to signal userspace from an ISR to handle work.  All the 
unnecessary context switches just seem wasteful.  Or is there a better 
method now for waking up userspace from the kernel now?

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
