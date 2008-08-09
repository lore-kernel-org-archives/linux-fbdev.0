From: Frans Pop <elendil@planet.nl>
Subject: Re: Framebuffer drivers that break the boot on
	systemswithout the hardware
Date: Sat, 9 Aug 2008 23:19:42 +0200
Message-ID: <200808092319.43139.elendil@planet.nl>
References: <489DFACC.6030009@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KRvr3-0001Cc-7B for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 09 Aug 2008 14:20:05 -0700
Received: from hpsmtp-eml20.kpnxchange.com ([213.75.38.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KRvr1-0004Mt-2H
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 09 Aug 2008 14:20:05 -0700
In-reply-To: <489DFACC.6030009@keyaccess.nl>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: akpm@osdl.org, mingo@elte.hu, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

Rene Herman wrote:
> Ingo Molnar posted a list of drivers he found to break the boot during
> testing of randconfig kernels and among them are a number of FB drivers:
> 
> FB_VESA

This one is set to "y" in the kernel configs for the generic Debian 
kernels for i386 and x86_64 and is used by default for the graphical 
version of the Debian Installer, so I'd be very surprised if it broke 
very many systems...
AFAIK it is only actually enabled if the 'vga=' boot parameter is passed.

Ingo's mail also lists FRAMEBUFFER_CONSOLE which again is set to "y" in 
Debian's standard kernel configs for x86 (and probably most other 
arches).

> (and FB_VIRTUAL)

This one should be fixed with 2.6.27-rc1. The commit that fixes it is:
  commit b604838ac6d233fd6bffc0e758a818133a01ff22
  Author: Frans Pop <elendil@planet.nl>
  Date:   Wed Jul 23 21:31:26 2008 -0700
    vfb: only enable if explicitly requested when compiled in

Cheers,
FJP

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
