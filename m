From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/4 (updated)] ps3fb: thread updates
Date: Fri, 16 Feb 2007 17:38:11 +0100
Message-ID: <20070216163811.GB32051@lst.de>
References: <20070215152301.573853000@sonycom.com>
	<20070215152432.264415000@sonycom.com>
	<20070215175007.GA10817@lst.de>
	<1171575817.5644.44.camel@localhost.localdomain>
	<20070215165916.de546f0d.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0702161658530.8263@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HI66H-00073W-LI for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Feb 2007 08:38:21 -0800
Received: from verein.lst.de ([213.95.11.210] helo=mail.lst.de)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1HI66H-0007Wp-3W
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Feb 2007 08:38:21 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0702161658530.8263@pademelon.sonytel.be>
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, Christoph Hellwig <hch@lst.de>, linuxppc-dev@ozlabs.org

> +	DEFINE_WAIT(wait);
> +	DECLARE_WAIT_QUEUE_HEAD(wq);
> +
> +	while (!kthread_should_stop()) {
> +		prepare_to_wait(&wq, &wait, TASK_INTERRUPTIBLE);
> +		if (!ps3fb.is_kicked)
> +			schedule();
> +		finish_wait(&wq, &wait);
> +		ps3fb.is_kicked = 0;
> +		ps3fb_sync(0);	/* single buffer */

should probably be just:

	while (!kthread_should_stop()) {
		ps3fb_sync(0);
		schedule();
	}

given that you don't need a waitqueue and a spurious wakeup here
seems harmless.
		

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
