From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [RFC 2.6.28 1/2] fbdev: add ability to set
	damage
Date: Thu, 15 Jan 2009 19:29:10 +0900
Message-ID: <aec7e5c30901150229g3e262adeje1776fc22cac1d64@mail.gmail.com>
References: <12319779622958-git-send-email-jayakumar.lkml@gmail.com>
	<1232011502.900.107.camel@tubuntu>
	<45a44e480901150153ta1fbe5fk5480dc5630cf1d6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <magnus.damm@gmail.com>) id 1LNPTS-0007NI-FD
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Jan 2009 10:29:18 +0000
Received: from mail-bw0-f21.google.com ([209.85.218.21])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LNPTN-0001Mc-8C for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Jan 2009 10:29:18 +0000
Received: by bwz14 with SMTP id 14so2956709bwz.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 15 Jan 2009 02:29:11 -0800 (PST)
In-Reply-To: <45a44e480901150153ta1fbe5fk5480dc5630cf1d6b@mail.gmail.com>
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

Hi Jaya,

I agree with Tomi about the memory allocation.

On Thu, Jan 15, 2009 at 6:53 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> Acknowledging that kzalloc is definitely not appropriate for all
> drivers, I propose the following changes to the implementation.
>
> a) allow userspace to determine optimal number of rectangles
> FBIO_GETDAMAGE
> which would allow the driver to report back (in the same fb_damage
> structure) the optimal number of rectangles that it can support.
>
> b) allow drivers to handle memory allocation as desired themselves
> Instead of doing the copy_from_user and kzalloc in the higher level
> fb_set_damage, we pass that user pointer directly to the driver. Thus,
> it would be:
> int (*fb_set_damage)(struct fb_info *info, struct fb_damage_user *damage);
>
> and the driver can handle according to its needs.

I wonder how fine grained control that is needed. It's not an exact
science, right? If a slightly larger area is updated than what is
needed then we will take a performance hit, but things should work as
expected apart from that right?

I'm a big fan of simple things like bitmaps. I wonder if it's a good
idea to divide the entire frame buffer into equally sized X*Y tiles
and have a bitmap of dirty bits. A "1" in the bitmap means tile is
dirty and needs update and a "0" means no need to update. The best
tile size is application specific. The size of the bitmap varies of
course with the tile size.

For a 1024x768 display using 32x32 tiles we need 24 32-bit words.
That's pretty small and simple, no?

Cheers,

/ magnus

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
