From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] eink_apollofb: new driver for
 Apollo eInk controller.
Date: Tue, 23 Sep 2008 17:01:54 -0700
Message-ID: <20080923170154.3a2ab52c.akpm@linux-foundation.org>
References: <1215787849-25580-1-git-send-email-jekhor@gmail.com>
	<1215788071-25764-1-git-send-email-jekhor@gmail.com>
	<1215788071-25764-2-git-send-email-jekhor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1KiHpY-00070o-3z
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Sep 2008 00:02:08 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1KiHpP-00007C-8p
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Sep 2008 00:02:08 +0000
In-Reply-To: <1215788071-25764-2-git-send-email-jekhor@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Yauhen Kharuzhy <jekhor@gmail.com>
Cc: mingo@redhat.com, linux-fbdev-devel@lists.sourceforge.net

On Fri, 11 Jul 2008 17:54:31 +0300
Yauhen Kharuzhy <jekhor@gmail.com> wrote:

> Add a new driver for eInk Apollo controller. This
> controller is used in various bookreaders with eInk
> displays.

I thought the consensus was that this functionality would be added to
the hecubafb driver, but there doesn't seem to have been any movement
along those lines?

The driver is causing some problems on arm:

drivers/video/eink_apollofb.c:36:32: asm/arch/regs-gpio.h: No such file or directory
drivers/video/eink_apollofb.c:37:26: asm/hardware.h: No such file or directory

So I'll drop it.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
