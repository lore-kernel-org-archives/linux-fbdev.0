From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] tgafb accelerated code
Date: Fri, 2 Mar 2007 19:14:08 +0000 (GMT)
Message-ID: <Pine.LNX.4.64N.0703021911270.5941@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64.0703021753450.6236@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HNDDm-00078J-AW for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Mar 2007 11:15:14 -0800
Received: from pollux.ds.pg.gda.pl ([153.19.208.7] ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HNDDh-0000dw-Qn
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Mar 2007 11:15:11 -0800
In-Reply-To: <Pine.LNX.4.64.0703021753450.6236@pentafluge.infradead.org>
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
To: Andrew Morton <akpm@osdl.org>, James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2 Mar 2007, James Simmons wrote:

> This patch adds accelerated panning and accelerated color and mono image 
> drawing. Please apply.
> 
> Signed-off-by: James Simmons <jsimmons@infradead.org>

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

 Tested with a 24-plane and a 8-plane TURBOchannel board.

  Maciej

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
