From: Jurriaan <thunder7@xs4all.nl>
Subject: Re: [PATCH] fix radeonfb panning and make it play nice with copyarea()
Date: Thu, 17 Jun 2004 07:19:31 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040617051931.GA1378@middle.of.nowhere>
References: <20040616182415.GA8286@middle.of.nowhere> <20040617022100.GA11774@havoc.gtf.org>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BapJV-00053z-D6
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 22:19:49 -0700
Received: from smtp-out5.xs4all.nl ([194.109.24.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BapJU-0002F4-Ra
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 22:19:49 -0700
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-out5.xs4all.nl (8.12.10/8.12.10) with ESMTP id i5H5JhUa022823
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Jun 2004 07:19:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20040617022100.GA11774@havoc.gtf.org>
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
To: David Eger <eger@havoc.gtf.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, akpm@osdl.org

From: David Eger <eger@havoc.gtf.org>
Date: Wed, Jun 16, 2004 at 10:21:00PM -0400
> 
> /me looks at vanilla 2.6.7
> 
> I believe the following patch will fix the bug you describe.
> (part of this patch I sent to benh before, but it never made it to 2.6.7)
> 
> Please try the following bugfix.  It works for me.
> If it works for you, I'll ask Andrew/James to merge.
> 
> -dte
> 
> 
> radeonfb: fix panning corruption on a large virtual screen,
>   Make panning and copyarea() play nicely with each other.
> 
> Signed-off-by: David Eger <eger@havoc.gtf.org>
> 
> # drivers/video/aty/radeon_base.c
> #   2004/06/17 03:47:12+02:00 eger@rosencrantz.theboonies.us +13 -0
> #   add some fifo_wait()s to lick this corruption problem
> # 
> # drivers/video/aty/radeon_accel.c
> #   2004/06/17 03:47:12+02:00 eger@rosencrantz.theboonies.us +2 -2
> #   make radeon accel play nice when the user wants to have a large virtual
> #   screen to pan on.  fix previous drain bramage.
> # 

Unfortunately, this doesn't fix it for me.

horizontal scrolling in angband is still very broken, and vertical
scrolling (even as simple as recalling previous command-lines in bash)
is also still broken.

For example, recalling the previous commandline goes OK the first time,
and the second time, part of the line is shifted some 120 characters to
the right.

Sorry,
Jurriaan
-- 
Cole's Law:
  Thinly sliced cabbage.
Debian (Unstable) GNU/Linux 2.6.7 2x6078 bogomips load 0.14


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
