From: David Miller <davem@davemloft.net>
Subject: Re: 2.6.21-rc2 radeon backlight
Date: Fri, 02 Mar 2007 13:40:05 -0800 (PST)
Message-ID: <20070302.134005.55727374.davem@davemloft.net>
References: <20070302.123514.35465791.davem@davemloft.net>
	<20070302210157.GA11786@khazad-dum.debian.net>
	<87mz2v5oj0.fsf@sycorax.lbl.gov>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HNFTz-0005a5-8D for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Mar 2007 13:40:07 -0800
Received: from [74.93.104.97] (helo=sunset.davemloft.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HNFTy-0007Fk-QY
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Mar 2007 13:40:07 -0800
In-Reply-To: <87mz2v5oj0.fsf@sycorax.lbl.gov>
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
To: romosan@sycorax.lbl.gov
Cc: rpurdie@rpsys.net, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, hmh@hmh.eng.br

From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: Fri, 02 Mar 2007 13:22:27 -0800

> if i don't enable the radeon backlight support the backlight works and
> i can turn it on and off using radeontool. if i enable the radeon
> backlight support the screen stays dark (although i can log on my
> laptop remotely). if i try to use radeontool to turn the backlight on
> nothing happens. so, at least on the thinkpad, the radeon backlight
> support disables some other kind of backlight support that works
> otherwise.

Right, that's the crux of the problem.

The Radeon backlight support conflicts somehow with the
way the ACPI code programs the same hardware, and until
we figure out exactly what's going on, this is a regression.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
