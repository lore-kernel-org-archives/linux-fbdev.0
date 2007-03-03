From: James Simmons <jsimmons@infradead.org>
Subject: Re: 2.6.21-rc2 radeon backlight
Date: Sat, 3 Mar 2007 16:23:12 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0703031619360.5722@pentafluge.infradead.org>
References: <20070301184531.b3aeafe3.akpm@linux-foundation.org> 
	<87tzx35zkc.fsf@sycorax.lbl.gov>
	<20070302122920.a2967ebf.akpm@linux-foundation.org>
	<20070302.123514.35465791.davem@davemloft.net> 
	<Pine.LNX.4.64.0703022131310.6960@pentafluge.infradead.org> 
	<20070302135841.fbfc1e32.akpm@linux-foundation.org>
	<1172878812.11149.207.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HNX0w-0003tj-D5 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 03 Mar 2007 08:23:18 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HNX0v-0007fZ-0i
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 03 Mar 2007 08:23:18 -0800
In-Reply-To: <1172878812.11149.207.camel@localhost.localdomain>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, romosan@sycorax.lbl.gov, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>


> > Sorry, but my confidence level on this one is very low.  We've had heaps
> > and heaps of Kconfig-related build errors in exactly this area.  I'd prefer
> > that a patch like this one have a lot of testing and review (and a
> > changelog?) before we let it near a tree.
> 
> Agreed, I can tell from what I've seen so far this will at least break
> the PMAC users...
> 
> See my proposed patch, if that doesn't work, we should revert the
> problematic change.

I will ask work if I can take home a LCD monitor with a backlight to 
find the real problem and fix. I wouldn't be able to do that until next 
weekend. So take what ever patch Rich sends.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
