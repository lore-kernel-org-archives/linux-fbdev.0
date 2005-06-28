From: James Simmons <jsimmons@www.infradead.org>
Subject: purposed changed to framebuffer_alloc
Date: Tue, 28 Jun 2005 01:07:12 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0506280100510.32329@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dn3dG-00083V-FZ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Jun 2005 17:07:18 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1Dn3dE-0003zK-Nz
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Jun 2005 17:07:18 -0700
Received: from jsimmons (helo=localhost)
	by pentafluge.infradead.org with local-esmtp (Exim 4.43 #1 (Red Hat Linux))
	id 1Dn3dA-0008TE-PU
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 28 Jun 2005 01:07:13 +0100
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Hi!

	I like to purpose a change to framebuffer_alloc to support card 
with more than one framebuffer on board. Currently we have

struct fb_info *framebuffers_alloc(size_t size, struct device *dev)

I purpose to change it to 

struct fb_info **framebuffers_alloc(int num_framebuffers, size_t size, struct device *dev)

I was also thinking of creating a list of struct fb_info. The reason for 
this is so framebuffers_alloc can allocate the memory we need for all 
framebuffer devices and the hardware par. Then we can fill in the par and 
dev for struct fb_info for each framebuffer device in one call.

What do you think?




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
