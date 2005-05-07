From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Mapping the framebuffer into kernel space
Date: Sat, 7 May 2005 11:08:36 +0800
Message-ID: <200505071108.36733.adaplas@hotpop.com>
References: <9e473391050428205517f3c8c0@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUFlu-00069s-7b
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 06 May 2005 20:14:30 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DUFls-0008Oc-PV
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 06 May 2005 20:14:30 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id F19451008712
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat,  7 May 2005 03:14:15 +0000 (UTC)
In-Reply-To: <9e473391050428205517f3c8c0@mail.gmail.com>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Jon Smirl <jonsmirl@gmail.com>

On Friday 29 April 2005 11:55, Jon Smirl wrote:
> I looked at a few fbdev drivers and they are mapping the framebuffer
> into kernel space.
>
> Example from radeonfb:
>   rinfo->mapped_vram = min_t(unsigned long, MAX_MAPPED_VRAM,
> rinfo->video_ram); do {
>      rinfo->fb_base = ioremap (rinfo->fb_base_phys,
>                                        rinfo->mapped_vram);
>
> Isn't the only consumer of this kernel mapping fbconsole? If so
> shouldn't fbconsole be doing the mapping instead of doing it in the
> drivers? Doing it in fbconsole would let us map exactly the amount of
> VRAM needed for the console. Right now the driver has to guess the
> maximum consumption.  This would minimize the amount of kernel address
> space consumed by fbdev. It could also remove a bunch of redundant
> code.

It can be done but not without difficulty.  A few drivers use sections of
the framebuffer space for the cursor, DMA buffer and whatever.  So
when fbcon starts mapping the framebuffer space, it must make sure
that it does not overlap with the driver's, or the space left to the driver
is of the correct size and alignment.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
