From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [RFC] Video Mode Handling
Date: Mon, 9 Aug 2004 15:59:17 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408091559.18436.adaplas@hotpop.com>
References: <20040809035002.65812.qmail@web14924.mail.yahoo.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bu549-00080d-OO
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Aug 2004 00:59:33 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bu549-0005Tl-63
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Aug 2004 00:59:33 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 847A5105C910
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  9 Aug 2004 07:32:55 +0000 (UTC)
In-Reply-To: <20040809035002.65812.qmail@web14924.mail.yahoo.com>
Content-Disposition: inline
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
To: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>

On Monday 09 August 2004 11:50, Jon Smirl wrote:
> There was a lot of discussion about mode handling at OLS. Here's some
> of the lwn coverage...
>
> http://lwn.net/Articles/94202/
> http://lwn.net/Articles/94763/
>


> I'll attach a list of points discussed. Mode setting needs to cover
> multihead cards, and devices that only use the BIOS for mode setting.
> There also needs to be coordinated memory management when multiple
> heads are involved. Point 7 talks about a design where most of the mode
> setting code is moved to user space via hotplug.
>
> Can your design be adjusted to work in the framework outlined below?
>

Sure, if I correctly understand the pertinent parts of the discussion,
they mostly pertain to moving mode handling to userspace.  The patches
that I submitted are just that, move more of the mode handling away from
the kernel and let userspace determine the numbers to give to the kernel.
The job of the driver is to de-normalize the numbers, and write them to the
registers.

Currently, the main problem is "are the values coming from userspace safe to
use?" The fbdev drivers have a check_var() that does the verification.
However the function is severely limited because not all details are known
about the hardware and the display/s.  Drivers take different approaches,
accept everything as gospel truth, be paranoid and reject everything, or
check the numbers to varying degrees of effectivity (by using EDID, kernel
boot options, etc).

I guess most people will agree that writing to the hardware belongs in the
kernel, while choosing the correct values to write belongs to userspace.  The
unanswered question is the middle part, who does the verification?

As for hardware that depends on the BIOS for mode setting, this is basically
unsupported in the current fbdev framework (vesafb).  Either we allow BIOS
code to run in the kernel (search for vesafb-tng) or run BIOS code in
userspace (search for vm86d, vesafbd). 

Multi-head cards can be configured as multiple fb_info's sharing a single par
if each output is independent from the other (in which case each head has
its own private mode list) or a single fb_info with multiple pars if each
output are dependent on each other (in which case they share a common
mode list which are filtered so all entries will work for all heads).

As for memory management, yes, that's needed.  The i810fb for example explicitly
avoids the framebuffer address that is used by X/DRI.  It's also fortunate that
the i810 hardware has 2 ringbuffers, one is used by X/DRI, one by i810fb.  Add
another application that needs the ringbuffers, and the hardware will definitely
crash.

Tony 




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
