From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
Date: Mon, 29 Jan 2007 17:15:02 +0100
Message-ID: <20070129161502.GA32313@lst.de>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251846460.24610@pademelon.sonytel.be>
	<20070126031236.GG18537@lst.de>
	<Pine.LNX.4.62.0701291442530.19906@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBZAV-0003pI-4V for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Jan 2007 08:15:43 -0800
Received: from verein.lst.de ([213.95.11.210] helo=mail.lst.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBZAR-0003xc-36
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Jan 2007 08:15:42 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0701291442530.19906@pademelon.sonytel.be>
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
Cc: Paul Mackerras <paulus@samba.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>, Christoph Hellwig <hch@lst.de>, Linux/PPC Development <linuxppc-dev@ozlabs.org>

On Mon, Jan 29, 2007 at 03:10:16PM +0100, Geert Uytterhoeven wrote:
> On Fri, 26 Jan 2007, Christoph Hellwig wrote:
> > Btw, the Kconfig and/or top of file comment really needs a better
> > explanation what this "driver" is for.  I also wonder why it's
> 
> What about `PS3 AV settings driver library' instead of `PS3 AV controller
> support'?

Makes a little more sense, yes.

> We can make FB_PS3 (and SND_PS3 later) select PS3_PS3AV. Is that better?
> I prefer not to make it unconditional, as people who want to run their PS3s
> headless don't need it.

Ok.  Even better would be handling it on the makefile level, by doing

obj-$(CONFIG_FB_PS3)	+= ps3_av.o
obj-$(CONFIG_SND_PS3)	+= ps3_av.o

> I guess you want us to do the same for the virtual uart, i.e. let PS3_PS3AV and
> PS3_SYS_MANAGER select PS3_VUART?

Yes, that probably makes sense aswell.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
