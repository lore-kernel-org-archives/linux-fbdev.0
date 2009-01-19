From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [RFC 2.6.28 1/1] defio: convert pagelist
	into pagemap
Date: Mon, 19 Jan 2009 12:22:45 +0900
Message-ID: <aec7e5c30901181922o65e7eb4avc57a5e93ad517ddf@mail.gmail.com>
References: <12321948953089-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <magnus.damm@gmail.com>) id 1LOkiw-0002xg-U0
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jan 2009 03:22:50 +0000
Received: from yw-out-1718.google.com ([74.125.46.155])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LOkiu-0000Bw-Bc for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jan 2009 03:22:50 +0000
Received: by yw-out-1718.google.com with SMTP id 6so1053948ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 18 Jan 2009 19:22:45 -0800 (PST)
In-Reply-To: <12321948953089-git-send-email-jayakumar.lkml@gmail.com>
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

On Sat, Jan 17, 2009 at 9:21 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> Hi Magnus, fbdev friends,
>
> As discussed yesterday, this is an attempt to convert pagelist use
> in defio over to pagemap. If everyone is okay with this, then we will
> also need to convert over xen-pvfb, sh and any other drivers using
> defio. Let me know your thoughts.

This is much better. But I really think you should make use of the
optimized functions in asm/bitops.h and linux/bitmap.h.

If you use the atomic versions of the bitop set (set_bit() instead of
__set_bit()) then there is no need for the mutex in
fb_defio_set_pagemap() - the entire function can maybe be reduced into
a single set_bit().

Also, in fb_deferred_io_work() you may want to switch to use the
find_first_bit() and find_next_bit() to figure out which pages to
clean.

On top of this, it would be great to have another tile based bitmap. I
have no time to hack on that now, but I'll keep it high on my todo
list. =)

Cheers,

/ magnus

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
