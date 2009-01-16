From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.28 1/2] fbdev: add ability to set
	damage
Date: Fri, 16 Jan 2009 04:24:35 -0500
Message-ID: <45a44e480901160124g54547437pf5eca85c8ee52be6@mail.gmail.com>
References: <12319779622958-git-send-email-jayakumar.lkml@gmail.com>
	<1232011502.900.107.camel@tubuntu>
	<45a44e480901150153ta1fbe5fk5480dc5630cf1d6b@mail.gmail.com>
	<aec7e5c30901150229g3e262adeje1776fc22cac1d64@mail.gmail.com>
	<45a44e480901150308l63b4ea97rd2fbfe4fa9e2cbb4@mail.gmail.com>
	<aec7e5c30901151909k1374ae65rf52c031e5b25387f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LNkwU-0005b7-6G
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Jan 2009 09:24:42 +0000
Received: from wf-out-1314.google.com ([209.85.200.173])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LNkwP-0008Q7-E1 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Jan 2009 09:24:42 +0000
Received: by wf-out-1314.google.com with SMTP id 27so1585522wfd.5
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 16 Jan 2009 01:24:35 -0800 (PST)
In-Reply-To: <aec7e5c30901151909k1374ae65rf52c031e5b25387f@mail.gmail.com>
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

On Thu, Jan 15, 2009 at 10:09 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Thu, Jan 15, 2009 at 8:08 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>> On Thu, Jan 15, 2009 at 5:29 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> needed then we will take a performance hit, but things should work as
>>> expected apart from that right?
>>
>> I'm not sure I understood this. Why do you say "If a large area is
>> updated, then we will take a performance hit."? I think that statement
>> depends on the device, right? I agree that if a lot of pixels are
>> updated, then there is a lot of data to transfer, but beyond that it
>> is very much dependent on the device, whether it uses DMA, what kind
>> of update latency it has, what kind of partial update capability it
>> has, all of which affect how much of a performance hit is taken and
>> what the optimal case would be.
>
> Sorry for my poor selection of words. I agree that it's device
> dependent, but what I was trying to say is that a lossy conversion to
> a larger area is ok if i've understood things correctly.

I think I understand your meaning. Okay, I think I might have a
relevant example. I ran xeyes (which uses shape) on my test setup on
broadsheetfb (btw, if it is of interest, I've put a demo video clip of
this here: http://www.youtube.com/watch?v=q_mLKQXcsgY ) and if I
remember correctly it generated about 10+ damage rectangles so I
suspect that it must have actually coalesced some of the damage area
in a lossy way. Another case would be drawing a diagonal line across
the screen. How many rectangles should that generate to be optimal? If
the hardware prefers single large transfers, then it would be optimal
to just do a full screen update. If the hardware exhibits a high
penalty per pixel transferred than it would be optimal to split the
transfers in order to reduce the total pixels transferred. So to
summarize, yes, I agree with you that a lossy conversion to a larger
area is okay. I'll go further and say that I think userspace apps like
Xfbdev and vnc must be doing that in order to optimize their pixmaps
and bitcopies.

>
> We will have correct behavior but performance degradation if the user
> space program asks to update a small rectangle in the middle of the
> screen but the driver or some layer in between decides to update say
> the entire screen instead. Do you agree with me?

I agree with you. I think that's the situation that we want to avoid
happening. I think we can avoid that by providing upper layers
(userspace) with sufficient information (but kept as generic as
possible) about the capabilities of the underlying layers in order for
userspace and the kernel to optimize its behavior.

>
>>> I'm a big fan of simple things like bitmaps. I wonder if it's a good
>>> idea to divide the entire frame buffer into equally sized X*Y tiles
>>> and have a bitmap of dirty bits. A "1" in the bitmap means tile is
>>> dirty and needs update and a "0" means no need to update. The best
>>> tile size is application specific. The size of the bitmap varies of
>>> course with the tile size.
>>>
>>> For a 1024x768 display using 32x32 tiles we need 24 32-bit words.
>>> That's pretty small and simple, no?
>
> Just trying to pitch my idea a bit harder: The above example would
> need a 96 bytes bitmap which will fit in just a few cache lines. This
> arrangement of the data gives you good performance compared to
> multiple allocations scattered all over the place.

I didn't follow the implication that there has to be multiple
allocations. If we are comparing the bitmap versus rects approach,
then my comparison would be:
a) where the driver preallocated a bitmap that would be updated by a
copy from userspace (same allocation would be done in userspace)
b) where the driver preallocated a fixed number of rectangles which
would be updated by a copy from userspace (same allocation would be
done in userspace)

>
> Also, using a bitmap makes it at least half-easy to do a lossy OR
> operation of all damage rectangles. Who is taking care of overlapping
> updates otherwise - some user space library?

I may not have fully understood above. I'm not sure that overlapping
updates must be avoided for all devices. Some devices would fail if
overlapping DMAs are done, but others would have no issues there. So
we would benefit from exposing that information to userspace so that
it could ensure overlaps are resolved if the underlying hardware
requires (or benefits from) it.

From our discussion so far, I've realized that we would benefit from
providing 3 things to userspace:
a) can_overlap flag
b) alignment constraint
c) max rectangle count

>
> I'd say we would benefit from managing the OR operation within the
> kernel since deferred io may collect a lot of overlapping areas over

I think there's an assumption there. I think you've associated
deferred IO with this damage API. Although the two can be related,
they don't have to be. I agree that it will very likely be deferred IO
drivers that are likely to benefit the most from this API but they can
also be completely separate.

> time. Actually, we sort of do that already by touching the pages in
> the deferred io mmap handling code. If we won't do any OR operation

Some questions here. Help me understand the "touching the pages in the
mmap handling code" part. I do not do that in deferred IO. fb_defio
does not write a page on its own, only userspace writes a page and
then this gets mkcleaned by defio when the client driver is done. Is
that your meaning, ie: we clean the pages?

> within the kernel for deferred io, then how are we supposed to handle
> long deferred io delays? Just keep on kmallocing rectangles? Or
> expanding the rectangles?

That's a good question. Here's my thoughts. Lets say we have a display
device with 10s latency (a scenario that exists in real life). As you
correctly pointed out, it would be bad if that driver kept aggregating
rectangles, as that would consume a significant amount of resources.
In that scenario, I recommend that the driver should convert the list
of rectangles into a bitmap. It is direct to convert from a rectangle
list to a bitmap as it is a linear mathematical operation. It can then
OR that with its existing bitmap.

I believe it is a more complex operation to convert from a bitmap to a
rectangle list or DMA transfer sequence. I'm trying to sketch the
function that would coalesce a bitmap of written pages into a sequence
of dma transfers. It requires heuristics and policy in order to
coalesce optimally. It would be similar to a Karnaugh map minimization
problem. I think that kind of operation would be a better fit to do in
userspace. That would fit the needs of a userspace framebuffer client
that kept its damage list as a bitmap. (Note, I'm not aware of any
examples of the latter yet.)

>
> Or maybe we are discussing apples and oranges? Is your damage API is

I think we are thinking about the same problems and have different
approaches for the solution. That is a good thing. It makes us think
harder about the API selection and I think we all benefit. I'm open to
the ideas you've raised and they are having an impact on the code I am
writing.

> meant to force a screen update so there is no need for in-kernel OR

No, the damage API is not meant to force the driver to update the
screen. The driver can decide what to do and when.

> operation? We have a need for in-kernel OR operation with deferred io
> already I think, so there is some overlap in my opinion.

I'm not sure I've understood your full meaning when you say "in-kernel
OR operation". Could you elaborate on that?

> .
>> Okay, I just realized that I neglected to mention the XDamage
>> extension which had a big influence on me. I think the following page:
>> http://www.freedesktop.org/wiki/Software/XDamage
>> and:
>> http://www.opensource.apple.com/darwinsource/Current/X11proto-15.1/damageproto/damageproto-1.1.0/damageproto.txt
>> explain a lot of thinking that has gone into solving similar issues.
>>
>> I think the fact that Xfbdev and Xorg utilize that rectangle and
>> rectangle count based infrastructure would push us towards retaining
>> the same concepts. In my mind, Xfbdev/Xorg would be the prime
>> candidate for this API.
>
> Thanks for the pointers. I'm not saying that using rectangles is a bad
> thing, I just wonder if there are better data structures available for
> backing the dirty screen area.
>
> I'd say that a combination of rectangle based user space damage API
> _and_ (maybe tile based) in-kernel dirty area OR operation is the best
> approach. This because XDamage is rectangle based and the deferred io
> delay (ie amount of time to collect dirty areas) is a kernel driver
> property.

I understand your point. I propose this: A driver that prefers a
bitmap can provide a flag in fb_info. Our in-kernel API can then use
that to decide whether to pass the rectangle list or to  generate the
bitmap from the rectangle list and then pass that to the driver. I'm
happy to implement that as I think it is a reasonable idea and
straightforward to achieve.

Thanks,
jaya

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
