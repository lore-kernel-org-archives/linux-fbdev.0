From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.28 1/1] defio: convert pagelist
	into pagemap
Date: Mon, 19 Jan 2009 22:58:25 +0800
Message-ID: <45a44e480901190658o78353f53x264bca09003b4b21@mail.gmail.com>
References: <12321948953089-git-send-email-jayakumar.lkml@gmail.com>
	<aec7e5c30901181922o65e7eb4avc57a5e93ad517ddf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LOvaF-0008Mq-FR
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jan 2009 14:58:35 +0000
Received: from wf-out-1314.google.com ([209.85.200.170])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LOva6-0003uo-Lm for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jan 2009 14:58:35 +0000
Received: by wf-out-1314.google.com with SMTP id 27so3228636wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 19 Jan 2009 06:58:25 -0800 (PST)
In-Reply-To: <aec7e5c30901181922o65e7eb4avc57a5e93ad517ddf@mail.gmail.com>
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

On Mon, Jan 19, 2009 at 11:22 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Hi Jaya,
>
> On Sat, Jan 17, 2009 at 9:21 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>> Hi Magnus, fbdev friends,
>>
>> As discussed yesterday, this is an attempt to convert pagelist use
>> in defio over to pagemap. If everyone is okay with this, then we will
>> also need to convert over xen-pvfb, sh and any other drivers using
>> defio. Let me know your thoughts.
>
> This is much better. But I really think you should make use of the
> optimized functions in asm/bitops.h and linux/bitmap.h.

Agreed. I thought about it yesterday and was lazy. I'll look at doing
this shortly.

>
> If you use the atomic versions of the bitop set (set_bit() instead of
> __set_bit()) then there is no need for the mutex in
> fb_defio_set_pagemap() - the entire function can maybe be reduced into
> a single set_bit().

Ok, will check it out.

>
> Also, in fb_deferred_io_work() you may want to switch to use the
> find_first_bit() and find_next_bit() to figure out which pages to
> clean.

Good point.

>
> On top of this, it would be great to have another tile based bitmap. I
> have no time to hack on that now, but I'll keep it high on my todo
> list. =)

Cool. Just to check, by tile based bitmap, you mean tiles less than
PAGE_SIZE so I think you're implying we'll need to do double buffering
and differencing to find the modified tiles. Drivers would provide the
minimum tilesize that they're interested in and defio would need to
build the multilevel tilemap to accomodate this granularity. I am
interested in that for broadsheetfb and have a different
implementation that did prewrite buffering. ie: when we get the fault,
I copy the current page into a page pulled from a pool, then continue
on. Then do differencing before the write to detect the minimum data
in the page to transfer to the framebuffer. That approach didn't work
so well for broadsheetfb for performance reasons but maybe a second
look will help.

Thanks,
jaya

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
