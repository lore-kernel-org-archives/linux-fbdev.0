From: "Peter Geoghegan" <peter.geoghegan86@gmail.com>
Subject: Re: Freeze when calling ioctl with VT_ACTIVATE
	request code number on intelfb
Date: Thu, 23 Oct 2008 11:07:10 +0100
Message-ID: <db471ace0810230307g1cc012c7h10dd0a6612f5d89f@mail.gmail.com>
References: <db471ace0810221552k158829d0te481c8f4483754fa@mail.gmail.com>
	<Pine.LNX.4.64.0810230907560.7533@anakin>
	<db471ace0810230150m710f2adfif38f16df584e858d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <peter.geoghegan86@gmail.com>) id 1KsyQQ-0008Sj-Ak
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 23 Oct 2008 11:32:22 +0000
Received: from mail-gx0-f19.google.com ([209.85.217.19])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KsyME-0001cq-6X for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 23 Oct 2008 11:32:22 +0000
Received: by gxk12 with SMTP id 12so1010405gxk.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 23 Oct 2008 04:28:01 -0700 (PDT)
In-Reply-To: <db471ace0810230150m710f2adfif38f16df584e858d@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>

Quick follow up.

I find that by specifying the virtual console in use, /dev/tty1,
rather than using the default /dev/tty, I can now change virtual
console, so it's no longer necessary to restart. Now, if I Ctrl, alt
F1 to /dev/tty1, I can see a dump of the data Tslib is receiving.

Despite this, the problem of the framebuffer interface never changing
remains. However, I now see a flashing white underscore in the top
left hand of the framebuffer. This is the same as the white underscore
that appears (over black) in place of my ubuntu splash screen, ever
since I changed my /boot/grub/menu.lst to boot with the kernel
argument vga=788 in order to get the damn framebuffer working in the
first place! The only difference is the underscore that appears at
boot time doesn't flash.

I guess it is a framebuffer problem, but I've had other framebuffer
using applications run without incident.

Does this make any clearer what the problem might be?

Thanks,
Peter

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
