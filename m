From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.28 1/2] fbdev: add ability to set
	damage
Date: Thu, 15 Jan 2009 06:08:11 -0500
Message-ID: <45a44e480901150308l63b4ea97rd2fbfe4fa9e2cbb4@mail.gmail.com>
References: <12319779622958-git-send-email-jayakumar.lkml@gmail.com>
	<1232011502.900.107.camel@tubuntu>
	<45a44e480901150153ta1fbe5fk5480dc5630cf1d6b@mail.gmail.com>
	<aec7e5c30901150229g3e262adeje1776fc22cac1d64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LNQ5C-0003qP-SP
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Jan 2009 11:08:18 +0000
Received: from wf-out-1314.google.com ([209.85.200.170])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LNQ56-0002Ub-2L for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Jan 2009 11:08:18 +0000
Received: by wf-out-1314.google.com with SMTP id 27so1207986wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 15 Jan 2009 03:08:11 -0800 (PST)
In-Reply-To: <aec7e5c30901150229g3e262adeje1776fc22cac1d64@mail.gmail.com>
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

On Thu, Jan 15, 2009 at 5:29 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Hi Jaya,
>
> I agree with Tomi about the memory allocation.

Yes, I agree with that too. :-) I proposed pushing that decision into
the driver so that it could decide for itself whether it wants to
allocate a buffer or retain a fixed structure.

>
> On Thu, Jan 15, 2009 at 6:53 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>> Acknowledging that kzalloc is definitely not appropriate for all
>> drivers, I propose the following changes to the implementation.
>>
>> a) allow userspace to determine optimal number of rectangles
>> FBIO_GETDAMAGE
>> which would allow the driver to report back (in the same fb_damage
>> structure) the optimal number of rectangles that it can support.
>>
>> b) allow drivers to handle memory allocation as desired themselves
>> Instead of doing the copy_from_user and kzalloc in the higher level
>> fb_set_damage, we pass that user pointer directly to the driver. Thus,
>> it would be:
>> int (*fb_set_damage)(struct fb_info *info, struct fb_damage_user *damage);
>>
>> and the driver can handle according to its needs.
>
> I wonder how fine grained control that is needed. It's not an exact
> science, right? If a slightly larger area is updated than what is

Agreed that it is not a one-approach fits all scenario.

> needed then we will take a performance hit, but things should work as
> expected apart from that right?

I'm not sure I understood this. Why do you say "If a large area is
updated, then we will take a performance hit."? I think that statement
depends on the device, right? I agree that if a lot of pixels are
updated, then there is a lot of data to transfer, but beyond that it
is very much dependent on the device, whether it uses DMA, what kind
of update latency it has, what kind of partial update capability it
has, all of which affect how much of a performance hit is taken and
what the optimal case would be.

>
> I'm a big fan of simple things like bitmaps. I wonder if it's a good
> idea to divide the entire frame buffer into equally sized X*Y tiles
> and have a bitmap of dirty bits. A "1" in the bitmap means tile is
> dirty and needs update and a "0" means no need to update. The best
> tile size is application specific. The size of the bitmap varies of
> course with the tile size.
>
> For a 1024x768 display using 32x32 tiles we need 24 32-bit words.
> That's pretty small and simple, no?

Okay, I just realized that I neglected to mention the XDamage
extension which had a big influence on me. I think the following page:
http://www.freedesktop.org/wiki/Software/XDamage
and:
http://www.opensource.apple.com/darwinsource/Current/X11proto-15.1/damageproto/damageproto-1.1.0/damageproto.txt
explain a lot of thinking that has gone into solving similar issues.

I think the fact that Xfbdev and Xorg utilize that rectangle and
rectangle count based infrastructure would push us towards retaining
the same concepts. In my mind, Xfbdev/Xorg would be the prime
candidate for this API.

Thanks,
jaya

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
