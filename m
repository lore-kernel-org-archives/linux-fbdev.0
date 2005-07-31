From: Jochen Hein <jochen@jochen.org>
Subject: Re: bugzilla bugs 4312, 4386
Date: Sun, 31 Jul 2005 22:10:41 +0200
Message-ID: <873bpud9dq.fsf@echidna.jochen.org>
References: <42ECA8F8.5020803@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DzS5r-0006FW-GS
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 31 Jul 2005 21:40:03 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1DzP0H-0003Vy-WD
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 31 Jul 2005 18:22:06 -0700
Received: from k1.dinoex.de ([80.237.200.138] ident=root)
	by externalmx-1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DzKFv-000083-N6
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 31 Jul 2005 13:17:56 -0700
Received: from k1.dinoex.de (uucp@k1.dinoex.de [80.237.200.138])
	by k1.dinoex.de (8.13.3/8.13.3) with ESMTP id j6VKFRGV021973
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 31 Jul 2005 22:15:32 +0200 (CEST)
	(envelope-from jochen@jochen.org)
Received: (from uucp@localhost)
	by k1.dinoex.de (8.13.3/8.13.3/Submit) with UUCP id j6VKFR2O021972
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 31 Jul 2005 22:15:27 +0200 (CEST)
	(envelope-from jochen@jochen.org)
Received: from echidna.jochen.org (jochen@localhost [127.0.0.1])
	by echidna.jochen.org (8.13.4/8.13.4/Debian-3) with ESMTP id j6VKAgcb030652
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 31 Jul 2005 22:10:42 +0200
In-Reply-To: <42ECA8F8.5020803@t-online.de> (Knut Petersen's message of "Sun,
	31 Jul 2005 12:33:28 +0200")
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
To: linux-fbdev-devel@lists.sourceforge.net

Knut Petersen <Knut_Petersen@t-online.de> writes:

> Bug #4312

I've updated http://bugzilla.kernel.org/show_bug.cgi?id=4312 with your comment.

> Most important is CRTC register 2f, signal quality is also improved for 
> higher vclk values
> by changing set_vclk() according to the X drivers and cyblafb.c

Can you provide a patch for mainline?  As long as cyblafb isn't
included it might be useful.

Jochen

-- 
#include <~/.signature>: permission denied


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
