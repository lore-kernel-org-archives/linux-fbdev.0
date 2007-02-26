From: James Simmons <jsimmons@infradead.org>
Subject: Re: tdfx framebuffer garbles display in 2.6.19.5
Date: Mon, 26 Feb 2007 15:24:38 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702261520420.27244@pentafluge.infradead.org>
References: <20070226144744.GA3615@DervishD>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLhiW-00019b-Rl for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Feb 2007 07:24:44 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HLhiV-0005Sm-G9
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Feb 2007 07:24:44 -0800
In-Reply-To: <20070226144744.GA3615@DervishD>
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
To: DervishD <privado@dervishd.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux-kernel <linux-kernel@vger.kernel.org>


>     Hi all :)
> 
>     From time to time, the tdfxfb driver from 2.6.19.5 (sorry, I cannot
> test in 2.6.20.x because it doesn't compile, the infamous BDF negative
> offset problem) garbles the display, leaving only a lot of thin lines,
> just like sync was lost. The display can be repaired by switching to
> another console, but this is annoying. This happens with a Voodoo 3
> 3000, using 800x600x8@100 mode.
> 
>     Anyone has this problem? Can it be solved changing anything?

Does not compile? Can you post the compile error. For my setup it does 
compile. 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
