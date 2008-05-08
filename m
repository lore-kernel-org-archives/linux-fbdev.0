From: Andres Salomon <dilinger@queued.net>
Subject: lxfb driver regression
Date: Wed, 7 May 2008 21:08:36 -0400
Message-ID: <20080507210836.1eb61b8f@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtuYy-0005re-AK for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 May 2008 18:04:48 -0700
Received: from mail.queued.net ([207.210.101.209])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JtuYv-000586-TT
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 May 2008 18:04:48 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jens Rottmann <JRottmann@LiPPERT-AT.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-geode@bombadil.infradead.org, linux-kernel@vger.kernel.org, jordan.crouse@amd.com, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

Hi,

I noticed that a patch from you went into 2.6.26-rc1 to adjust the PLL table
in the lxfb driver.  Unfortunately, it breaks on OLPC machines (I haven't
tested it on other Geode platforms yet, but I don't have any other Geodes
with panels anyways).  It's this commit:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=3888d4639e78802c4ec1086127124e890461b9e4

Without this patch, I get the following (correct) output from the lxfb
and console code:

[    0.939827] lxfb 0000:00:01.1: 16384 KB of video memory at 0xfd000000
[    1.009194] Console: switching to colour frame buffer device 150x56     

Without it, the cols/width is screwy (and I get a blank white screen):

[   20.706836] lxfb 0000:00:01.1: 16384 KB of video memory at 0xfd000000
[   20.788538] Console: switching to colour frame buffer device 100x40          


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
