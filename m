From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Proper backlight selection for
 fbdev drivers
Date: Wed, 13 Dec 2006 11:25:08 -0800
Message-ID: <20061213112508.e1bad3fa.akpm@osdl.org>
References: <Pine.LNX.4.64.0612071757230.949@pentafluge.infradead.org>
	<20061213000029.edd9c91e.akpm@osdl.org>
	<Pine.LNX.4.64.0612131442440.4484@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GuZjV-00045t-KR for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Dec 2006 11:25:37 -0800
Received: from smtp.osdl.org ([65.172.181.25])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GuZjU-0003oe-Qe
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Dec 2006 11:25:37 -0800
In-Reply-To: <Pine.LNX.4.64.0612131442440.4484@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 13 Dec 2006 14:58:26 +0000 (GMT)
James Simmons <jsimmons@infradead.org> wrote:

> The problem is the overlap of the patches 
> 
> fbdev-update-after-backlight-argument-change.diff
> proper-backlight-selection-forfbdev-drivers.patch
> 
> The machine_is change is in the argument change patch. It should be in 
> this patch. I can send updates of both patches.

oh ok, I wondered why -mm1 worked OK.  Let me put things back...

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
