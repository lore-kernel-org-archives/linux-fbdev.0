From: Jurriaan <thunder7@xs4all.nl>
Subject: Re: why does radeonfb work fine in 2.6, but not in 2.4.29-pre1?
Date: Tue, 30 Nov 2004 07:55:55 +0100
Message-ID: <20041130065555.GA20972@middle.of.nowhere>
References: <20041128184606.GA2537@middle.of.nowhere> <20041129213510.GA9551@dreamland.darkstar.lan>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZ1vS-0006sX-6B
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Nov 2004 22:55:50 -0800
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CZ1vQ-0004Rk-Oz
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Nov 2004 22:55:49 -0800
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-vbr4.xs4all.nl (8.12.11/8.12.11) with ESMTP id iAU6tha7041026
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 30 Nov 2004 07:55:47 +0100 (CET)
	(envelope-from jurriaan@rivierenland.xs4all.nl)
Content-Disposition: inline
In-Reply-To: <20041129213510.GA9551@dreamland.darkstar.lan>
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
Content-Transfer-Encoding: 7bit
To: Kronos <kronos@people.it>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Kronos <kronos@people.it>
Date: Mon, Nov 29, 2004 at 10:35:10PM +0100
> Il Sun, Nov 28, 2004 at 07:46:06PM +0100, Jurriaan ha scritto: 
> > The same radeonfb-setup works fine in every 2.6 kernel I can remember
> > (last tested with 2.6.10-rc2-mm3) but give the dreaded 'cannot map FB'
> > in 2.4.29-pre1.
> > 
> > The card has 128 Mb of ram, and my system has 3 Mb of RAM.
> > 
> > Is there any reason the ioremap() call works on 2.6, but doesn't on 2.4?
> 
> Driver in 2.6 only ioremap()s the memory needed for the framebuffer,
> while the one in 2.4 ioremap()s all the VRAM (and fails).
> 
> > Is there any way to test 2.4 with my radeonfb and all of my memory?
> 
> I proposed the following patch some time ago (for 2.4.28-pre2 IIRC) as a
> quick fix:
> 
Thanks. I found that patch on google. Problem is: when I look through
the radeonfb in 2.6, I don't see any assignments to rinfo->video_ram
that indicate it maps less than the full amount.

> 
> Problem is that fix->smem_len is used both by FBIOGET_FSCREENINFO to
> report the amount of VRAM to userspace and by read/write/mmap on fb
> for bounds checking. So with my patch FBIOGET_FSCREENINFO reports mapped
> VRAM instead of physical VRAM.
> 
> smem_len should be splitted in (say) smem_mapped (for read/write/mmap)
> and smem_total_vram (for FBIOGET_FSCREENINFO). I'll code something
> tomorrow... -ENEEDSLEEP ;)
> 
Thanks,
Jurriaan
-- 
All wiyht. Rho sritched mg kegtops awound?
Debian (Unstable) GNU/Linux 2.6.10-rc2-mm3 2x6078 bogomips load load 0.24


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
