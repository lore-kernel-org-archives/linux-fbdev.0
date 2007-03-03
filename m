From: James Simmons <jsimmons@infradead.org>
Subject: Re: 2.6.21-rc2 radeon backlight
Date: Sat, 3 Mar 2007 16:06:37 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0703031557570.2901@pentafluge.infradead.org>
References: <87ps7uutsk.fsf@sycorax.lbl.gov>
	<20070301184531.b3aeafe3.akpm@linux-foundation.org>
	<87tzx35zkc.fsf@sycorax.lbl.gov>
	<20070302122920.a2967ebf.akpm@linux-foundation.org>
	<1172878338.11149.198.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HNWl3-0001S2-4H for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 03 Mar 2007 08:06:53 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HNWl1-0003Qi-NY
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 03 Mar 2007 08:06:53 -0800
In-Reply-To: <1172878338.11149.198.camel@localhost.localdomain>
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
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>, Alex Romosan <romosan@sycorax.lbl.gov>, linux-kernel@vger.kernel.org, Yaroslav Halchenko <lists@onerussian.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>


> > Richard, is this actually a bug, or is it a config error or something like that?
> > 
> > And should we track it as a post-2.6.20 regression?
> 
> Its a regression IMO. Arguably its a Kconfig error but a nasty one as
> the defaults cause the problems. Different people seem to have different
> interpretations but to me it appears that the patch from James causes
> backlights to fail to turn on for a variety of devices which worked
> before.

   It is NOT a Kconfig error. The problem is that for many fbdev drivers 
the backlight code is broken. For some magic reason it only works on 
pmacs. Most likely because the firmware properly sets up the backlight. 
Plus we have the conflict with acpi backlight. 
   Think about it. Enabling the backlight code breaks the backlight. 
Without the backlight driver the default behaviour of the backlight works.
Who sets up the default behavior? I don't have a LCD panel with a 
backlight othewise I would track the problem down.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
