From: David Miller <davem@davemloft.net>
Subject: Re: no backlight on radeon after recent kernel
 "upgrade"s
Date: Thu, 22 Feb 2007 09:28:12 -0800 (PST)
Message-ID: <20070222.092812.112620509.davem@davemloft.net>
References: <Pine.LNX.4.64.0702220109450.17121@pentafluge.infradead.org>
	<20070222020951.GR7920@ca-server1.us.oracle.com>
	<Pine.LNX.4.64.0702221549530.29542@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKHjx-00083r-5F for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 09:28:21 -0800
Received: from [74.93.104.97] (helo=sunset.davemloft.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKHjs-0000KQ-T0
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 09:28:17 -0800
In-Reply-To: <Pine.LNX.4.64.0702221549530.29542@pentafluge.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: jsimmons@infradead.org
Cc: linux-fbdev-devel@lists.sourceforge.net, Joel.Becker@oracle.com, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, akpm@linux-foundation.org, lists@onerussian.com

From: James Simmons <jsimmons@infradead.org>
Date: Thu, 22 Feb 2007 15:55:24 +0000 (GMT)

> I just tested various confirations of backlight support. Backlight is 
> ALWAYS selected by default when you select a particular fbdev driver that 
> has backlight support. You just have the option to turn it off if you 
> want. These problems are showing up because of stale .config files.

BTW, enabling the backlight option broke things for me with
Radeon on sparc64 too, FWIW.

And when the option was presented to me for the first time,
the default was yes, so that's what I gave it.

This is what a lot of users would see.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
