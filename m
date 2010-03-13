From: Dave Airlie <airlied@gmail.com>
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video 
	mode
Date: Sun, 14 Mar 2010 07:01:04 +1000
Message-ID: <21d7e9971003131301r723f3311p3553ea8a1a86bf0a@mail.gmail.com>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
	<a728f9f91003101005v374b2cacpb307542e65d22d6f@mail.gmail.com>
	<a728f9f91003101010m4fc94398l14c8625d7442100a@mail.gmail.com>
	<1268302426.7444.117.camel@thor.local>
	<a728f9f91003110712l407ed04dl28b86ef77a427218@mail.gmail.com>
	<alpine.LFD.2.00.1003111516540.1912@casper.infradead.org>
	<a5d587fb1003110747j40e5c5f1h70aab0e74f03eef2@mail.gmail.com>
	<alpine.LFD.2.00.1003121332470.10546@casper.infradead.org>
	<21d7e9971003121251v4bef7e96v67f3d98aa9ab384a@mail.gmail.com>
	<alpine.LFD.2.00.1003131421360.12031@casper.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <dri-devel-bounces@lists.sourceforge.net>
In-Reply-To: <alpine.LFD.2.00.1003131421360.12031@casper.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=dri-devel>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: dri-devel-bounces@lists.sourceforge.net
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Paulius Zaleckas <paulius.zaleckas@gmail.com>, =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, Michal Suchanek <hramrach@centrum.cz>, Alex Deucher <alexdeucher@gmail.com>, dri-devel@lists.sourceforge.net

>
> Searching the TTM code I couldn't find the handle code so easily. I see
> that the vmwgfx driver provides a example of using ttm.

So handles are purely a userspace interface, in-kernel we don't use handles
for buffer management, the vmwgfx TTM interface has
vmw_user_surface_lookup_handle
to do the bo lookups.

>
>> > =A0 =A0 =A0 =A0This gets me to point of where to go from here. We have=
 two choices.
>> > The first being we could just make the drm_framebuffer code totally gem
>> > dependent thus we could cleanup the drivers code up by moving gem code
>> > there. The second option is to make the drm_framebuffer code agnostic =
to the gem
>> > layer. So I have been pondering on how to make the second option work.
>> > There is one thing that all these layers do share in common. That is t=
hey
>> > have some sort of drm_hash with a object lookup. Still pondering how t=
hat
>> > would be done.
>>
>> I'm not sure either of these makes sense, can you clearly state the
>> goal and maybe we can work out what you need.
>
> Sorry I should of stated what I was planing to do. I like to see drmfb
> have the ablitiy to change the resolution via fbset. To do that we need to
> be able to create and destory the framebuffer memory if the memory doesn't
> fit the size of the new resolution. Plus it gives us the bonus of being
> able to unpin the memory when the VT is in KD_GRAPHICS mode. The problem
> is that the functions like fb_create are tied to a handle which is not
> present for the internal framebuffer used by fbdev. Sorry for the junk
> above. It just took me awhile to figure out the code. Their is steep
> learning curve. I have patches that should address this coming soon.

Okay first up, there are two sets of codepaths, please ignore vmwgfx
for now, its
_fb implementation is not yet using the drm_fb_helper.c code and it needs t=
o be
converted if possible. Originally all the drivers had their own fb
code, but its was
mostly pointless, the helper allows for drivers to optionally use the
shared code,
ideally we'd like all drivers to use that code so we get consistent
operation across
drivers, so user experience isn't driver dependent unless unavoidable.

The big issue we have with resizing the buffer is userspace mmaps of the fb=
dev
device, and invalidation.
Previous thread of unresolvedness is here.
http://www.mail-archive.com/dri-devel@lists.sourceforge.net/msg41878.html

If you look at the current fb code, when we get a hotplug event in
theory, we try and
reuse the current framebuffer.

I suppose initially it would be worth trying the resize downwards and keep =
the
current fbdev, but the whole mmap area was the cause of most of the problems
and it seemed like a real pain to fix.

Dave.

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--
