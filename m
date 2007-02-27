From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] display class
Date: Tue, 27 Feb 2007 21:46:42 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702272133170.21161@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0702251833500.30828@pentafluge.infradead.org>
	<20070227122531.542a2c33.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMA9t-0004B2-Jb for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Feb 2007 13:46:53 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HMA9r-000670-Pv
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Feb 2007 13:46:53 -0800
In-Reply-To: <20070227122531.542a2c33.akpm@linux-foundation.org>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


> this stuff looks el-crappo in an 80-col display.

Cleaning up....

> This guy can have static scope.
> 
> It's a bit awkward having a fixed size.  I think lib/idr.c would suit for
> this.
>
> Also, we do set_bit() and clear_bit() on this, which are needlessly atomic. 
> If we hold a suitable lock then we can use __set_bit() and __clear_bit().
> 
> And we do need a suitable lock.

Fixing... Never knew about idr. Hum nice :-) I will have a new patch your 
way. I just need to do some teste first.

> Why all the ifdeffery?  I think plain old
> 
> 
> static void __exit display_class_exit(void)
> {
> 	class_destroy(display_class);
> }
> module_exit(display_class_exit);
> module_init(display_class_init);

That is from the hunting of the bug with the broken symlinks in /sys. Will 
go back to sanity.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
