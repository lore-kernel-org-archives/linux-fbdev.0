From: James Simmons <jsimmons@infradead.org>
Subject: Re: savagefb not working on thinkpad T23 in
 1400x1050
Date: Fri, 8 Dec 2006 20:30:13 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0612082029110.9017@pentafluge.infradead.org>
References: <20061127201146.GA13885@amd64.of.nowhere>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GsmMS-0003QP-80 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Dec 2006 12:30:26 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GsmMR-0003ZG-C3
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Dec 2006 12:30:23 -0800
In-Reply-To: <20061127201146.GA13885@amd64.of.nowhere>
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
To: Jurriaan <thunder7@xs4all.nl>, linux-fbdev-devel@lists.sourceforge.net
Cc: dok@directfb.org, neo@directfb.org


> I got myself a shiny new IBM ThinkPad T23. I've used one for years, and
> it worked fine with savagefb and XFree/X.org. The old one had a 1024x768
> LCD screen, the new one has a 1400x1050 LCD screen.
> 
> Unfortunately, savagefb doesn't work correctly on the new laptop.
> 
> X.org works just fine in 1400x1050.

Can you enable debug in fbmon and post your dmesg. Also what default mode 
is it trying to go to?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
