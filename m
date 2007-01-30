From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
Date: Tue, 30 Jan 2007 01:16:57 +0100
Message-ID: <200701300116.57606.arnd@arndb.de>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<200701260513.24010.arnd@arndb.de>
	<Pine.LNX.4.62.0701291611300.19906@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBggg-0006bK-Pn for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Jan 2007 16:17:27 -0800
Received: from moutng.kundenserver.de ([212.227.126.186])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBggf-00011C-5H
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Jan 2007 16:17:26 -0800
In-Reply-To: <Pine.LNX.4.62.0701291611300.19906@pademelon.sonytel.be>
Content-Disposition: inline
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
Cc: linuxppc-dev@ozlabs.org, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Paul Mackerras <paulus@samba.org>

On Monday 29 January 2007 16:14, Geert Uytterhoeven wrote:
> 
> > You should probably use the provided pr_debug or (better) dev_dbg
> > macros to do that now.
> 
> Except that it's difficult to get a struct device * in drivers/ps3/ps3av_cmd.c.
> And I prefer not to make ps3av_dev (which is currently static) global.

Ok, as I said, dev_dbg is the preferred way, but of course it only
works when you carry a device along. If you don't have one, use
pr_debug().

	Arnd <><

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
