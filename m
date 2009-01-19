From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [RFC 2.6.28 1/2] fbdev: add ability to set
	damage
Date: Mon, 19 Jan 2009 13:44:47 +0900
Message-ID: <aec7e5c30901182044x2fbd49f2ve0aa1b433bb4ce14@mail.gmail.com>
References: <12319779622958-git-send-email-jayakumar.lkml@gmail.com>
	<1232011502.900.107.camel@tubuntu>
	<45a44e480901150153ta1fbe5fk5480dc5630cf1d6b@mail.gmail.com>
	<aec7e5c30901150229g3e262adeje1776fc22cac1d64@mail.gmail.com>
	<45a44e480901150308l63b4ea97rd2fbfe4fa9e2cbb4@mail.gmail.com>
	<aec7e5c30901151909k1374ae65rf52c031e5b25387f@mail.gmail.com>
	<45a44e480901160124g54547437pf5eca85c8ee52be6@mail.gmail.com>
	<aec7e5c30901160308l3f3830c7gc53717ab8cce649e@mail.gmail.com>
	<45a44e480901161414r7f0d0bc4x582c1597d439d116@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <magnus.damm@gmail.com>) id 1LOm0L-0005Jo-9S
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jan 2009 04:44:53 +0000
Received: from yw-out-1718.google.com ([74.125.46.154])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LOm0H-0001sL-3f for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jan 2009 04:44:53 +0000
Received: by yw-out-1718.google.com with SMTP id 6so1060685ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 18 Jan 2009 20:44:48 -0800 (PST)
In-Reply-To: <45a44e480901161414r7f0d0bc4x582c1597d439d116@mail.gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, armbru@redhat.com, lethal@linux-sh.org, Geert Uytterhoeven <geert@linux-m68k.org>

On Sat, Jan 17, 2009 at 7:14 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> On Fri, Jan 16, 2009 at 7:08 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> Right, user space applications may optimize things for us. Optimizing
>> to not redraw the same area twice sounds good, but if user space is
>> expanding the area then we may see a performance hit...
>
> In general, I agree. I would expect userspace to ensure that it
> doesn't give us duplicate regions, subset regions, or overlapped
> regions (as you raised before). If they do, I see that as a problem
> similar to filesystems where an application misbehaves by doing
> seek/write the same thing repeatedly. Now, you mentioned if userspace
> expands the area, we may see a performance hit. Yes, I think I agree.
> To be more elaborate about this, I would raise the issue of drawing a
> diagonal line across the entire screen. Userspace has a decision to
> make whether it sends us one big rectangle to represent the whole
> screen or whether it breaks that up into multiple rectangular blocks.
> In real life, I think this one is non-optimally but simply handled by
> saying hardware supports max 10 rectangles at at time, so just break
> up the diagonal write to 10 rectangles.

So say that use space plays nice and breaks it up into 10 rectangles.
That sounds easy for the generic case, but if this framebuffer is
using deferred io, then how are dirty pages handled? All of a sudden
you may have 11 rectangles.

Also sorry for being a bit slow, but I don't understand how the damage
call works together with deferrec io and fsync(). Today fsync flushes
dirty pages to the display. With damage, both dirty pages _and_ damage
rectangles are flushed? Or does the damage information replace the
dirty pages?

As for the diagonal line, i like your example. Applying this to the
dirty tile bitmap, having one bit per pixel would be the most accurate
representation, but larger tile size is most likely more efficient. =)

Your damage interface is exporting the maximum rectangle count to user
space and letting it do it's best to work efficiently with the
hardware. I think that sounds straight forward and simple. But is it
enough information?

What if we would let user space describe the dirty data as accurate as
possible instead? Then let the kernel take this information (and
information from other sources) and feed that to the graphics hardware
somehow. Exactly how is a bit tricky - maybe too difficult. I'm not
sure.

I guess the main question is how the user space interface should look
like. Should it export hardware capabilities?

>> I'm not sure if overlapping updates will cause any problems, I merely
>> thought of it as a performance optimization. If you draw the same
>> circle 10 times in one update we want to make sure the screen only is
>> updated once. User space may solve that for us already though, but I
>> don't think so since the deferred io is a driver property. Or have I
>> misunderstood?
>
> I now see your point about overlaps. You are right that userspace does
> not necessarily solve the problem for us. If they give us duplicate
> rects or subset rects or overlapping rects, then these are all
> immediately negative for performance. Further, if we are aggregating
> rects and duplicates/subset/overlaps occur due to the aggregation,
> then this is also negative for performance. I think we'll need to add
> basic support functions to do checks and corrections for these
> scenarios.

We could check and correct, or we could aggregate all rects from
different sources.

> About the deferred IO part, okay, let me come back to that below.

Yeah, this is the tricky part in my opinion. =)

>>
>>> From our discussion so far, I've realized that we would benefit from
>>> providing 3 things to userspace:
>>> a) can_overlap flag
>>> b) alignment constraint
>>> c) max rectangle count
>>
>> I'm more for letting user space select whatever max rectangle count it
>> wants and let the kernel code go through all rectangles and do an OR
>> operation on some dirty backing store data area. That way user space
>> can be flexible and we make sure we don't update the same area more
>> than once.
>
> Okay, lets discuss that a bit more. I mean that the driver reports
> back to userspace via GETDAMAGE a value for its preferred rectangle
> count (call that max rectangle count). Userspace may choose to ignore
> the max (it may not even if picked up that data via GETDAMAGE) and
> send 100 rects. The driver can choose whether to -EINVAL or it can
> choose to go through the rects and perform optimization based on its
> preferred structure as you suggested.

I understand. But how about hardware that only supports a single
rectangle within one DMA operation? I have some here in front of me.
=)

So the user space code can get 1 as rectangle count, but does that
really mean that we want user space to redraw everything if a diagonal
line is drawn across the screen? It may be better to break it up into
two separate DMA operations instead of one single one. And how do we
tell user space about that? By using 2 as rectangle count? =)

Doesn't all this just boil down to max number of rectangles,
throughput and setup cost for a dma transaction?

>>> I think there's an assumption there. I think you've associated
>>> deferred IO with this damage API. Although the two can be related,
>>> they don't have to be. I agree that it will very likely be deferred IO
>>> drivers that are likely to benefit the most from this API but they can
>>> also be completely separate.
>>
>> Any examples of non deferred io use cases? =)
>
> Yes, I'm glad you asked. The first one that came to mind is the NO-MMU
> case. As you know, defio is MMU only today and I have no hopes of
> removing that. I had damage in mind especially for these NO-MMU cases
> (btw, if any vendor of such devices/cpus/boards is reading, please
> drop me a mail, i would like to help support this ).

Yeah, I may actually have such a SuperH dev board in the office. I
think one of our SH2A boards comes with a display.

> Okay, so the above was the easy answer. There are also others I have
> in mind but it is debatable whether they should use damage API or
> whether they should use deferred IO. I would like to discuss the range
> of scenarios here:
>
> a) Tomi raised omapfb at the start of this thread. He or she mentioned:
> OMAPFB_UPDATE_WINDOW
> I looked thru the code and saw:
>
> +static int omapfb_update_window(struct fb_info *fbi,
> +               u32 x, u32 y, u32 w, u32 h)
>
> [ btw, interesting to see use of u32 above, why not just u16? ]
>
> I noticed dsi_update_screen_dispc. After reading this code, I formed
> the following conclusion:
> - this is to support the use of externally buffered displays. that is,
> there is an external sdram being handled by a separate controller,
> probably a MIPI-DSI controller
> - basically omapfb wants to know exactly what and when stuff is
> written from userspace because it has to push that manually through
> the MIPI-DSI interface
>
> That driver currently uses a private ioctl to achieve that through the
> transfer of a single rectangle from userspace. It could, I believe,
> achieve the same effect using deferred IO since it has an MMU but lets
> leave that to one side for now. This kind of driver would be able to
> use the damage API with little change. They would add a GETDAMAGE
> handler that reports back their max rectangles (1) and then a
> PUTDAMAGE handler that does what they already do today.

I understand and agree. I guess the reason for not using deferred io
is that we don't really get any good rectangles out of deferred io
today since one page covers multiple lines. This is the reason why I
think it's good to also have per-tile dirty bits instead of just
relying on the page bits to store dirty damage data.

> b) non-snooping LCDCs with external ram
> I have seen SoCs where the LCD controller is not aware of memory
> writes on the host memory bus. As a result, it doesn't actually know
> when the framebuffer has been modified and it most cases it can't
> benefit from that anyway due to buffering constraints. It just
> repetitively DMAs from host memory to its input fifo (line buffer)
> that then gets palettized/dithered/etc before hitting the display
> output buffer which backs the output pins. I believe pxafb is an
> example of this, you'll notice it has code to setup dma period
> according to the pixel clock.
>
> Now, if it talks directly to a standard LCD, then there's no benefit
> it can gain from damage or deferred IO as it always has to perform
> that DMA anyway. But in some scenarios, it is interfaced to an
> external controller that has its own sdram (so that the host cpu can
> be completely suspended and still have a display showing content ) in
> which scenario it would benefit from being able to choose between:
> i) reduce or tune its dma rate
> ii) issue a more specific dma update
> iii) issue dma-s only when needed
> This could be achieved using either damage or defio with tradeoffs
> between either approach.

This is exactly why I implemented deferred io for the SuperH LCDC
hardware in SYS mode. It's partially implemented now though - we feed
full frame data to the external controller only when needed. Before we
fed full frames regardless of if the screen had been modified or not.
Future work includes partial screen update, but it may be difficult to
implement that and still have flicker free video playback...

There is also vidix code in mplayer (sh_veu vidix driver) that does
dma straight to the framebuffer. It bypasses the deferred io handling
and it needs to do fsync after updating each frame to make sure the
screen gets updated. Using the damage api instead would be better if
only part of the screen is modified.

>> So why not doing that directly instead of keeping your pages / dirty
>> rectangles on a list? =)
>
> Okay, that's a fair question. In the above case, I would adjust my
> previous answer a bit. The driver could use a bitmap to detect
> overlaps/subsets and then handle them suitably but retain a fixed
> pre-allocated rect list so that it can schedule its dma (or other
> mechanism) transfers normally. You are right that it could instead
> only keep the bitmap and then generate the dma transfer list from the
> bitmap but I worry about the complexity and ability to get good
> results there.

Yeah, I understand. I'm not sure which is the best solution when it
comes to this. Exporting maximum rectangle count to user space seems
easy, but I wonder if it is enough information to let user space make
intelligent decisions.

Cheers,

/ magnus

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
