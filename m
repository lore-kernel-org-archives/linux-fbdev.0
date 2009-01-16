From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.28 1/2] fbdev: add ability to set
	damage
Date: Sat, 17 Jan 2009 06:14:54 +0800
Message-ID: <45a44e480901161414r7f0d0bc4x582c1597d439d116@mail.gmail.com>
References: <12319779622958-git-send-email-jayakumar.lkml@gmail.com>
	<1232011502.900.107.camel@tubuntu>
	<45a44e480901150153ta1fbe5fk5480dc5630cf1d6b@mail.gmail.com>
	<aec7e5c30901150229g3e262adeje1776fc22cac1d64@mail.gmail.com>
	<45a44e480901150308l63b4ea97rd2fbfe4fa9e2cbb4@mail.gmail.com>
	<aec7e5c30901151909k1374ae65rf52c031e5b25387f@mail.gmail.com>
	<45a44e480901160124g54547437pf5eca85c8ee52be6@mail.gmail.com>
	<aec7e5c30901160308l3f3830c7gc53717ab8cce649e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LNxfV-0003Dv-QA
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Jan 2009 23:00:01 +0000
Received: from wf-out-1314.google.com ([209.85.200.171])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LNxfU-0000jt-0q for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Jan 2009 23:00:01 +0000
Received: by wf-out-1314.google.com with SMTP id 27so2139643wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 16 Jan 2009 14:59:58 -0800 (PST)
In-Reply-To: <aec7e5c30901160308l3f3830c7gc53717ab8cce649e@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, armbru@redhat.com, lethal@linux-sh.org, Geert Uytterhoeven <geert@linux-m68k.org>

On Fri, Jan 16, 2009 at 7:08 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Fri, Jan 16, 2009 at 6:24 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>> I think I understand your meaning. Okay, I think I might have a
>> relevant example. I ran xeyes (which uses shape) on my test setup on
>> broadsheetfb (btw, if it is of interest, I've put a demo video clip of
>> this here: http://www.youtube.com/watch?v=q_mLKQXcsgY ) and if I
>> remember correctly it generated about 10+ damage rectangles so I
>> suspect that it must have actually coalesced some of the damage area
>> in a lossy way. Another case would be drawing a diagonal line across
>> the screen. How many rectangles should that generate to be optimal? If
>> the hardware prefers single large transfers, then it would be optimal
>> to just do a full screen update. If the hardware exhibits a high
>> penalty per pixel transferred than it would be optimal to split the
>> transfers in order to reduce the total pixels transferred. So to
>> summarize, yes, I agree with you that a lossy conversion to a larger
>> area is okay. I'll go further and say that I think userspace apps like
>> Xfbdev and vnc must be doing that in order to optimize their pixmaps
>> and bitcopies.
>
> Nice clip. =)
>
> Right, user space applications may optimize things for us. Optimizing
> to not redraw the same area twice sounds good, but if user space is
> expanding the area then we may see a performance hit...

In general, I agree. I would expect userspace to ensure that it
doesn't give us duplicate regions, subset regions, or overlapped
regions (as you raised before). If they do, I see that as a problem
similar to filesystems where an application misbehaves by doing
seek/write the same thing repeatedly. Now, you mentioned if userspace
expands the area, we may see a performance hit. Yes, I think I agree.
To be more elaborate about this, I would raise the issue of drawing a
diagonal line across the entire screen. Userspace has a decision to
make whether it sends us one big rectangle to represent the whole
screen or whether it breaks that up into multiple rectangular blocks.
In real life, I think this one is non-optimally but simply handled by
saying hardware supports max 10 rectangles at at time, so just break
up the diagonal write to 10 rectangles.

>
>>> We will have correct behavior but performance degradation if the user
>>> space program asks to update a small rectangle in the middle of the
>>> screen but the driver or some layer in between decides to update say
>>> the entire screen instead. Do you agree with me?
>>
>> I agree with you. I think that's the situation that we want to avoid
>> happening. I think we can avoid that by providing upper layers
>> (userspace) with sufficient information (but kept as generic as
>> possible) about the capabilities of the underlying layers in order for
>> userspace and the kernel to optimize its behavior.
>
> Sure, good plan.
>
>>>>> I'm a big fan of simple things like bitmaps. I wonder if it's a good
>>>>> idea to divide the entire frame buffer into equally sized X*Y tiles
>>>>> and have a bitmap of dirty bits. A "1" in the bitmap means tile is
>>>>> dirty and needs update and a "0" means no need to update. The best
>>>>> tile size is application specific. The size of the bitmap varies of
>>>>> course with the tile size.
>>>>>
>>>>> For a 1024x768 display using 32x32 tiles we need 24 32-bit words.
>>>>> That's pretty small and simple, no?
>>>
>>> Just trying to pitch my idea a bit harder: The above example would
>>> need a 96 bytes bitmap which will fit in just a few cache lines. This
>>> arrangement of the data gives you good performance compared to
>>> multiple allocations scattered all over the place.
>>
>> I didn't follow the implication that there has to be multiple
>> allocations. If we are comparing the bitmap versus rects approach,
>> then my comparison would be:
>> a) where the driver preallocated a bitmap that would be updated by a
>> copy from userspace (same allocation would be done in userspace)
>> b) where the driver preallocated a fixed number of rectangles which
>> would be updated by a copy from userspace (same allocation would be
>> done in userspace)
>
> Sorry for not being clear enough. I meant to compare collecting
> kmalloced rectangles on the damagelist vs marking dirty tiles in a
> static bitmap. The interface to user space remains unchanged, just the
> dirty area backing store is different.

Okay, understood. No disagreement here. If driver aggregates rects via
kmalloc and has the discussed characteristics, its resource
utilization versus bitmap approach will be poor.

>
>>> Also, using a bitmap makes it at least half-easy to do a lossy OR
>>> operation of all damage rectangles. Who is taking care of overlapping
>>> updates otherwise - some user space library?
>>
>> I may not have fully understood above. I'm not sure that overlapping
>> updates must be avoided for all devices. Some devices would fail if
>> overlapping DMAs are done, but others would have no issues there. So
>> we would benefit from exposing that information to userspace so that
>> it could ensure overlaps are resolved if the underlying hardware
>> requires (or benefits from) it.
>
> I'm not sure if overlapping updates will cause any problems, I merely
> thought of it as a performance optimization. If you draw the same
> circle 10 times in one update we want to make sure the screen only is
> updated once. User space may solve that for us already though, but I
> don't think so since the deferred io is a driver property. Or have I
> misunderstood?

I now see your point about overlaps. You are right that userspace does
not necessarily solve the problem for us. If they give us duplicate
rects or subset rects or overlapping rects, then these are all
immediately negative for performance. Further, if we are aggregating
rects and duplicates/subset/overlaps occur due to the aggregation,
then this is also negative for performance. I think we'll need to add
basic support functions to do checks and corrections for these
scenarios.

About the deferred IO part, okay, let me come back to that below.

>
>> From our discussion so far, I've realized that we would benefit from
>> providing 3 things to userspace:
>> a) can_overlap flag
>> b) alignment constraint
>> c) max rectangle count
>
> I'm more for letting user space select whatever max rectangle count it
> wants and let the kernel code go through all rectangles and do an OR
> operation on some dirty backing store data area. That way user space
> can be flexible and we make sure we don't update the same area more
> than once.

Okay, lets discuss that a bit more. I mean that the driver reports
back to userspace via GETDAMAGE a value for its preferred rectangle
count (call that max rectangle count). Userspace may choose to ignore
the max (it may not even if picked up that data via GETDAMAGE) and
send 100 rects. The driver can choose whether to -EINVAL or it can
choose to go through the rects and perform optimization based on its
preferred structure as you suggested.

>
>>> I'd say we would benefit from managing the OR operation within the
>>> kernel since deferred io may collect a lot of overlapping areas over
>>
>> I think there's an assumption there. I think you've associated
>> deferred IO with this damage API. Although the two can be related,
>> they don't have to be. I agree that it will very likely be deferred IO
>> drivers that are likely to benefit the most from this API but they can
>> also be completely separate.
>
> Any examples of non deferred io use cases? =)

Yes, I'm glad you asked. The first one that came to mind is the NO-MMU
case. As you know, defio is MMU only today and I have no hopes of
removing that. I had damage in mind especially for these NO-MMU cases
(btw, if any vendor of such devices/cpus/boards is reading, please
drop me a mail, i would like to help support this ).

Okay, so the above was the easy answer. There are also others I have
in mind but it is debatable whether they should use damage API or
whether they should use deferred IO. I would like to discuss the range
of scenarios here:

a) Tomi raised omapfb at the start of this thread. He or she mentioned:
OMAPFB_UPDATE_WINDOW
I looked thru the code and saw:

+static int omapfb_update_window(struct fb_info *fbi,
+               u32 x, u32 y, u32 w, u32 h)

[ btw, interesting to see use of u32 above, why not just u16? ]

I noticed dsi_update_screen_dispc. After reading this code, I formed
the following conclusion:
- this is to support the use of externally buffered displays. that is,
there is an external sdram being handled by a separate controller,
probably a MIPI-DSI controller
- basically omapfb wants to know exactly what and when stuff is
written from userspace because it has to push that manually through
the MIPI-DSI interface

That driver currently uses a private ioctl to achieve that through the
transfer of a single rectangle from userspace. It could, I believe,
achieve the same effect using deferred IO since it has an MMU but lets
leave that to one side for now. This kind of driver would be able to
use the damage API with little change. They would add a GETDAMAGE
handler that reports back their max rectangles (1) and then a
PUTDAMAGE handler that does what they already do today.

b) non-snooping LCDCs with external ram
I have seen SoCs where the LCD controller is not aware of memory
writes on the host memory bus. As a result, it doesn't actually know
when the framebuffer has been modified and it most cases it can't
benefit from that anyway due to buffering constraints. It just
repetitively DMAs from host memory to its input fifo (line buffer)
that then gets palettized/dithered/etc before hitting the display
output buffer which backs the output pins. I believe pxafb is an
example of this, you'll notice it has code to setup dma period
according to the pixel clock.

Now, if it talks directly to a standard LCD, then there's no benefit
it can gain from damage or deferred IO as it always has to perform
that DMA anyway. But in some scenarios, it is interfaced to an
external controller that has its own sdram (so that the host cpu can
be completely suspended and still have a display showing content ) in
which scenario it would benefit from being able to choose between:
i) reduce or tune its dma rate
ii) issue a more specific dma update
iii) issue dma-s only when needed
This could be achieved using either damage or defio with tradeoffs
between either approach.

>
>>> time. Actually, we sort of do that already by touching the pages in
>>> the deferred io mmap handling code. If we won't do any OR operation
>>
>> Some questions here. Help me understand the "touching the pages in the
>> mmap handling code" part. I do not do that in deferred IO. fb_defio
>> does not write a page on its own, only userspace writes a page and
>> then this gets mkcleaned by defio when the client driver is done. Is
>> that your meaning, ie: we clean the pages?
>
> I meant how fb_deferred_io_mkwrite() + page_mkclean() work. First time
> a page is touched it is put on the list, second time and after nothing
> happens until the delayed work happens when we clean the page and
> start over waiting for a touch again.
>
> Looks like an OR operation to me. =) Instead of putting the page on a
> list we may mark a tile dirty in a bitmap instead. The bitmap code
> scales O(1) which is pretty nice. I think we could avoid the list

Agreed.

> looping in fb_deferred_io_mkwrite() with a bitmap which would make the
> code scale much better. I'm not 100% sure though.

This was raised here too by Tony:
http://marc.info/?l=linux-fbdev-devel&m=117230487100960&w=2
Eventually, I had written a patch to do bitmap instead of pagelist but
never finished changing the drivers. I think it definitely performed
better in the defio case on hecubafb and metronomefb. I would claim
that intuitively it:
- completely removes list overhead and loop overhead on the defio side
- drivers still have to loop through the bitmap of course but it is
faster compared to the list iteration

performance naturally varies based on typical application behavior. If
they're updating lots of pages, then bitmap wins, if they're updating
a few, then not such a big win. But I agree it is a better approach. I
will be happy to resurrect this patch and switch defio to a bitmap as
you suggest. But I will need assistance converting all the drivers. I
can do hecubafb, metronomefb and broadsheetfb but am a bit wary of
updating the others.

>
>>> within the kernel for deferred io, then how are we supposed to handle
>>> long deferred io delays? Just keep on kmallocing rectangles? Or
>>> expanding the rectangles?
>>
>> That's a good question. Here's my thoughts. Lets say we have a display
>> device with 10s latency (a scenario that exists in real life). As you
>> correctly pointed out, it would be bad if that driver kept aggregating
>> rectangles, as that would consume a significant amount of resources.
>> In that scenario, I recommend that the driver should convert the list
>> of rectangles into a bitmap. It is direct to convert from a rectangle
>> list to a bitmap as it is a linear mathematical operation. It can then
>> OR that with its existing bitmap.
>
> So why not doing that directly instead of keeping your pages / dirty
> rectangles on a list? =)

Okay, that's a fair question. In the above case, I would adjust my
previous answer a bit. The driver could use a bitmap to detect
overlaps/subsets and then handle them suitably but retain a fixed
pre-allocated rect list so that it can schedule its dma (or other
mechanism) transfers normally. You are right that it could instead
only keep the bitmap and then generate the dma transfer list from the
bitmap but I worry about the complexity and ability to get good
results there.

>
>> I believe it is a more complex operation to convert from a bitmap to a
>> rectangle list or DMA transfer sequence. I'm trying to sketch the
>> function that would coalesce a bitmap of written pages into a sequence
>> of dma transfers. It requires heuristics and policy in order to
>> coalesce optimally. It would be similar to a Karnaugh map minimization
>> problem. I think that kind of operation would be a better fit to do in
>> userspace. That would fit the needs of a userspace framebuffer client
>> that kept its damage list as a bitmap. (Note, I'm not aware of any
>> examples of the latter yet.)
>
> I agree that this is the tricky part, but I'm not sure if it is so
> complex that it has to be done in user space. Remember my patch
> related to fillrect/copyarea/imageblit and deferred io? They would
> benefit from filling in the dirty bitmap as well - but not in user
> space. =)

Good point. Okay, will think about this some more.

>
> I'm not sure about the best way to convert the bitmap to a sequence of
> DMA requests. I propose transferring tile by tile and letting displays
> with low bandwidth use a small tile size. Displays with high bandwidth
> and high setup cost can use larger tile size.

I'm also not sure. I guess we should look at the use cases and see
what's desirable.

>
>>> Or maybe we are discussing apples and oranges? Is your damage API is
>>
>> I think we are thinking about the same problems and have different
>> approaches for the solution. That is a good thing. It makes us think
>> harder about the API selection and I think we all benefit. I'm open to
>> the ideas you've raised and they are having an impact on the code I am
>> writing.
>
> I think so too.
>
>>> meant to force a screen update so there is no need for in-kernel OR
>>
>> No, the damage API is not meant to force the driver to update the
>> screen. The driver can decide what to do and when.
>>
>>> operation? We have a need for in-kernel OR operation with deferred io
>>> already I think, so there is some overlap in my opinion.
>>
>> I'm not sure I've understood your full meaning when you say "in-kernel
>> OR operation". Could you elaborate on that?
>
> The fillrect/copyarea/imageblit may want to hook into the dirty area bitmap.

Yup, I agree that can be beneficial.

>
>>> I'd say that a combination of rectangle based user space damage API
>>> _and_ (maybe tile based) in-kernel dirty area OR operation is the best
>>> approach. This because XDamage is rectangle based and the deferred io
>>> delay (ie amount of time to collect dirty areas) is a kernel driver
>>> property.it
>>
>> I understand your point. I propose this: A driver that prefers a
>> bitmap can provide a flag in fb_info. Our in-kernel API can then use
>> that to decide whether to pass the rectangle list or to  generate the
>> bitmap from the rectangle list and then pass that to the driver. I'm
>> happy to implement that as I think it is a reasonable idea and
>> straightforward to achieve.
>
> That's ok, but I'm fine with just a rect user space interface. The
> kernel fbdev interface is fine too, but I think it would be
> interesting to work on handling the dirty information inside the
> kernel more efficiently.

Ok, understood. Will think about this some more.

>
> Thanks for your comments. Have a good weekend!
>

Thanks, u2,
jaya

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
