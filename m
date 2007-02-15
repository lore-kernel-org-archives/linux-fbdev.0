From: Christoph Hellwig <hch@lst.de>
Subject: Re: [patch 1/4] ps3fb: thread updates
Date: Thu, 15 Feb 2007 18:50:07 +0100
Message-ID: <20070215175007.GA10817@lst.de>
References: <20070215152301.573853000@sonycom.com>
	<20070215152432.264415000@sonycom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HHkkT-0007MO-VX for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 09:50:26 -0800
Received: from verein.lst.de ([213.95.11.210] helo=mail.lst.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HHkkP-0002ZM-8G
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 09:50:25 -0800
Content-Disposition: inline
In-Reply-To: <20070215152432.264415000@sonycom.com>
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
To: Geert.Uytterhoeven@sonycom.com
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net

On Thu, Feb 15, 2007 at 04:23:02PM +0100, Geert.Uytterhoeven@sonycom.com wrote:
> +	do {
> +		try_to_freeze();
> +		error = down_interruptible(&ps3fb.sem);
> +		if (!error && !atomic_read(&ps3fb.ext_flip))
>  			ps3fb_sync(0);	/* single buffer */

this still can deadlock when calling kthread_stop.  You really want
to use wake_up_process to kick this thread or use a workqueue.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
