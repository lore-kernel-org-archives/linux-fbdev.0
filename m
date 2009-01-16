From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [RFC 2.6.28 1/2] fbdev: add ability to set
	damage
Date: Fri, 16 Jan 2009 12:09:15 +0900
Message-ID: <aec7e5c30901151909k1374ae65rf52c031e5b25387f@mail.gmail.com>
References: <12319779622958-git-send-email-jayakumar.lkml@gmail.com>
	<1232011502.900.107.camel@tubuntu>
	<45a44e480901150153ta1fbe5fk5480dc5630cf1d6b@mail.gmail.com>
	<aec7e5c30901150229g3e262adeje1776fc22cac1d64@mail.gmail.com>
	<45a44e480901150308l63b4ea97rd2fbfe4fa9e2cbb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <magnus.damm@gmail.com>) id 1LNf5E-0004TL-Rs
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Jan 2009 03:09:20 +0000
Received: from fg-out-1718.google.com ([72.14.220.153])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LNf5C-0004KR-4H for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Jan 2009 03:09:20 +0000
Received: by fg-out-1718.google.com with SMTP id d23so678297fga.32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 15 Jan 2009 19:09:16 -0800 (PST)
In-Reply-To: <45a44e480901150308l63b4ea97rd2fbfe4fa9e2cbb4@mail.gmail.com>
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

On Thu, Jan 15, 2009 at 8:08 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> On Thu, Jan 15, 2009 at 5:29 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> I agree with Tomi about the memory allocation.
>
> Yes, I agree with that too. :-) I proposed pushing that decision into
> the driver so that it could decide for itself whether it wants to
> allocate a buffer or retain a fixed structure.

Sure, letting the driver decide things depending on the type of
hardware sounds like a good plan.

>> I wonder how fine grained control that is needed. It's not an exact
>> science, right? If a slightly larger area is updated than what is
>
> Agreed that it is not a one-approach fits all scenario.
>
>> needed then we will take a performance hit, but things should work as
>> expected apart from that right?
>
> I'm not sure I understood this. Why do you say "If a large area is
> updated, then we will take a performance hit."? I think that statement
> depends on the device, right? I agree that if a lot of pixels are
> updated, then there is a lot of data to transfer, but beyond that it
> is very much dependent on the device, whether it uses DMA, what kind
> of update latency it has, what kind of partial update capability it
> has, all of which affect how much of a performance hit is taken and
> what the optimal case would be.

Sorry for my poor selection of words. I agree that it's device
dependent, but what I was trying to say is that a lossy conversion to
a larger area is ok if i've understood things correctly.

We will have correct behavior but performance degradation if the user
space program asks to update a small rectangle in the middle of the
screen but the driver or some layer in between decides to update say
the entire screen instead. Do you agree with me?

>> I'm a big fan of simple things like bitmaps. I wonder if it's a good
>> idea to divide the entire frame buffer into equally sized X*Y tiles
>> and have a bitmap of dirty bits. A "1" in the bitmap means tile is
>> dirty and needs update and a "0" means no need to update. The best
>> tile size is application specific. The size of the bitmap varies of
>> course with the tile size.
>>
>> For a 1024x768 display using 32x32 tiles we need 24 32-bit words.
>> That's pretty small and simple, no?

Just trying to pitch my idea a bit harder: The above example would
need a 96 bytes bitmap which will fit in just a few cache lines. This
arrangement of the data gives you good performance compared to
multiple allocations scattered all over the place.

Also, using a bitmap makes it at least half-easy to do a lossy OR
operation of all damage rectangles. Who is taking care of overlapping
updates otherwise - some user space library?

I'd say we would benefit from managing the OR operation within the
kernel since deferred io may collect a lot of overlapping areas over
time. Actually, we sort of do that already by touching the pages in
the deferred io mmap handling code. If we won't do any OR operation
within the kernel for deferred io, then how are we supposed to handle
long deferred io delays? Just keep on kmallocing rectangles? Or
expanding the rectangles?

Or maybe we are discussing apples and oranges? Is your damage API is
meant to force a screen update so there is no need for in-kernel OR
operation? We have a need for in-kernel OR operation with deferred io
already I think, so there is some overlap in my opinion.
.
> Okay, I just realized that I neglected to mention the XDamage
> extension which had a big influence on me. I think the following page:
> http://www.freedesktop.org/wiki/Software/XDamage
> and:
> http://www.opensource.apple.com/darwinsource/Current/X11proto-15.1/damageproto/damageproto-1.1.0/damageproto.txt
> explain a lot of thinking that has gone into solving similar issues.
>
> I think the fact that Xfbdev and Xorg utilize that rectangle and
> rectangle count based infrastructure would push us towards retaining
> the same concepts. In my mind, Xfbdev/Xorg would be the prime
> candidate for this API.

Thanks for the pointers. I'm not saying that using rectangles is a bad
thing, I just wonder if there are better data structures available for
backing the dirty screen area.

I'd say that a combination of rectangle based user space damage API
_and_ (maybe tile based) in-kernel dirty area OR operation is the best
approach. This because XDamage is rectangle based and the deferred io
delay (ie amount of time to collect dirty areas) is a kernel driver
property.

Cheers,

/ magnus

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
