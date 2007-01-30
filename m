From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/9] ps3: Preallocate bootmem memory
	for ps3fb
Date: Tue, 30 Jan 2007 11:44:41 +0100
Message-ID: <200701301144.42120.arnd@arndb.de>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701300934270.4728@pademelon.sonytel.be>
	<1170148116.26655.328.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBqUa-0007ag-4D for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 02:45:36 -0800
Received: from moutng.kundenserver.de ([212.227.126.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBqUX-0007ks-S9
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 02:45:36 -0800
In-Reply-To: <1170148116.26655.328.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linuxppc-dev@ozlabs.org, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>

On Tuesday 30 January 2007 10:08, Benjamin Herrenschmidt wrote:
> 
> > I'm afraid that assumption is usually false, as you only need to access the
> > FLASH when you want to change boot flags or update the boot loader.
> 
> At the same time, flash doesn't have to be fast... can't we use a
> smaller bounce buffer (a page) and divide the transfer ?

No, the problem is that the flash interface only supports an hcall
for 'erase+write', but not separately, so the writes need to do
in erase block size, even if the physical medium can probably
handle smaller writes after a block was erased.

	Arnd <><

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
