From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/9] ps3: Preallocate bootmem memory
	for ps3fb
Date: Tue, 30 Jan 2007 09:27:51 +0100
Message-ID: <200701300927.52087.arnd@arndb.de>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<1170124157.19887.116.camel@concordia.ozlabs.ibm.com>
	<Pine.LNX.4.62.0701300914580.4728@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBoLk-0002aM-0a for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 00:28:20 -0800
Received: from moutng.kundenserver.de ([212.227.126.188])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBoLj-0005pg-FV
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 00:28:19 -0800
In-Reply-To: <Pine.LNX.4.62.0701300914580.4728@pademelon.sonytel.be>
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
To: linuxppc-dev@ozlabs.org
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Michael Ellerman <michael@ellerman.id.au>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>

On Tuesday 30 January 2007 09:16, Geert Uytterhoeven wrote:
> We have a similar problem with the storage driver, which needs a block of 256
> KiB of contiguous memory.

I guess at least that one should be solveable. If the 256kb is only
internal flash access, it is should not be part of the storage driver
but of whatever else is used to drive this.

Assuming the module gets loaded shortly after boot, you can still allocate
256kb practically always, using get_free_pages().

	Arnd <><

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
