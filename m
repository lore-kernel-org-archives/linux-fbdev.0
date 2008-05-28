From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: [directfb-users] DirectFB without FBDev
Date: Wed, 28 May 2008 14:24:28 -0400
Message-ID: <a728f9f90805281124y53df86e7n7ae1918ac97907fc@mail.gmail.com>
References: <483D7344.6030503@directfb.org>
	<Pine.LNX.4.64.0805281901300.15083@anakin>
	<483D9453.1080700@directfb.org> <483D9C30.8010301@acdstar.com>
	<483D9F4E.4000707@directfb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1QK5-0005w0-0H for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 11:24:29 -0700
Received: from rv-out-0708.google.com ([209.85.198.251])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K1QK4-000870-K7
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 11:24:28 -0700
Received: by rv-out-0708.google.com with SMTP id f25so2900316rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 28 May 2008 11:24:28 -0700 (PDT)
In-Reply-To: <483D9F4E.4000707@directfb.org>
Content-Disposition: inline
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
Cc: directfb-users@directfb.org, "Brian G. Rhodes" <bgr@acdstar.com>, linux-fbdev-devel@lists.sourceforge.net, directfb-dev@directfb.org, Geert Uytterhoeven <geert@linux-m68k.org>

On Wed, May 28, 2008 at 2:07 PM, Denis Oliver Kropp <dok@directfb.org> wrote:
> Brian G. Rhodes wrote:
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
>>
>> I don't think the solution to abstracting access to multiple hardware
>> planes which can be located in at dynamic memory addresses to be
>> implemented by adding complexity to the framebuffer driver.  It is
>> supposed to be just a dumb chunk of memory and storage for hardware
>> timings.
>
> Adding the byte offset and pitch fits into this as well and would save
> it from being removed from DirectFB.
>
>> Considering video, and the amount of data which has to be shuffled
>> around for higher resolution/bitrate files it does not make sense to
>> require sending rendered frames off directly to a framebuffer device.
>
> I was not talking about copying any data back and forth, but just keep
> a queue of start addresses assigned to future sync counters, being taken
> care of in IRQs.
>
>> It is too inefficient and in cases with hardware-assist (other than
>> coprocessors), likely unnecessary.  The answer probably isn't using
>> Video4Linux directly either.  Perhaps a DirectFB kernel component which
>> can standardize an interface and provide a better architecture than v4l2
>> does.  An application where, as mentioned above, you are using video
>> memory for multiple buffers as a implementation for queuing seems too
>> specialized to me to ever be done in a linuxfb driver.
>
> It's not special regarding the hardware. Every driver with an interrupt
> handler could support it.
>
>> Has any thought been given to designing a DirectFB kernel-space
>> component which abstracts that access at the kernel level?  Seems to me
>> that it would make direct interaction from directfb with specialized
>> hardware much easier.
>
> I don't think a new kernel graphics interface should be added, instead using
> UIO to access MMIO, DMA and IRQs would be enough and implement most of the
> graphics driver in user space. Downside is to loose the kernel console which
> you usually don't need on an embedded device...
>
> For acceleration and DMA/IRQ based programming, I still need to check if a
> user space approach would be enough. So far I always handled IRQs in kernel
> space for timing/performance reasons...

As you may or may not be aware, the drm is slowly getting modesetting
support including support for multiple crtcs and outputs and better
memory management.  Development is currently focusing on intel, but
AMD support will follow soon.  It even provides a legacy fbdev compat
layer.

http://cgit.freedesktop.org/mesa/drm/log/?h=modesetting-101

Alex

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
