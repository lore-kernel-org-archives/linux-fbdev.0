From: Christoph Hellwig <hch@lst.de>
Subject: Re: [patch 1/4] ps3fb: thread updates
Date: Fri, 16 Feb 2007 17:36:15 +0100
Message-ID: <20070216163615.GA32051@lst.de>
References: <20070215152301.573853000@sonycom.com>
	<20070215152432.264415000@sonycom.com>
	<20070215175007.GA10817@lst.de>
	<1171575817.5644.44.camel@localhost.localdomain>
	<20070215165916.de546f0d.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HI64k-0006jH-5Y for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Feb 2007 08:36:48 -0800
Received: from verein.lst.de ([213.95.11.210] helo=mail.lst.de)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1HI64j-0006y6-Iy
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Feb 2007 08:36:46 -0800
Content-Disposition: inline
In-Reply-To: <20070215165916.de546f0d.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert.Uytterhoeven@sonycom.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net, Christoph Hellwig <hch@lst.de>, linuxppc-dev@ozlabs.org

On Thu, Feb 15, 2007 at 04:59:16PM -0800, Andrew Morton wrote:
> No, it won't get you out of down_interruptible().  But the code would have
> failed trivial testing so perhaps we're missing something.
> 
> It seems crufty to use semaphores in this manner.  afaict all we're doing
> here is poking a kernel thread and asking it to do a bit of work.  The
> standard way of doing this is to go to sleep on a waitqueue_head.

We don't even need the waitqueue.  Because it's just a single thread
waiting we can simply use wake_up_process.  (.. which you actually
used in the second half of the example, humm..)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
