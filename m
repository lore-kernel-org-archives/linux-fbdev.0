From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] Fix colors in mach64 accelerator
	(fwd)
Date: Wed, 7 Oct 2009 08:13:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0910070808170.29225@hs20-bc2-1.build.redhat.com>
References: <Pine.LNX.4.64.0910061219510.16200@hs20-bc2-1.build.redhat.com>
	<19148.5908.101231.251201@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpatocka@redhat.com>) id 1MvVom-0002VC-Rc
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Oct 2009 12:40:32 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MvVog-00017b-Fe for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Oct 2009 12:40:32 +0000
In-Reply-To: <19148.5908.101231.251201@cargo.ozlabs.ibm.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Paul Mackerras <paulus@samba.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 7 Oct 2009, Paul Mackerras wrote:

> Mikulas Patocka writes:
> 
> > In the previous kernel cycle I sent you this patch, you acknowledged it 
> > but didn't put it to the kernel.
> > 
> > Did you forget it? Do you want to add it in this cycle?
> > 
> > The patch fixes mach64 fill rect routine for 15 and 16-bit modes.
> 
> Huh?  Are you talking to me?  Why did you think I was responsible for
> this driver?
>
> Paul.

There's a line in the MAINTAINERS file:

RAGE128 FRAMEBUFFER DISPLAY DRIVER
M:      Paul Mackerras <paulus@samba.org>
L:      linux-fbdev-devel@lists.sourceforge.net (moderated for non-subscribers) S:      Maintained
F:      drivers/video/aty/aty128fb.c

This patch is for aty/mach64.c but you're closest to that, there is no 
entry for aty/mach64.c in Maintainers.

Mikulas

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
