From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/9] ps3: Preallocate bootmem memory
	for ps3fb
Date: Tue, 30 Jan 2007 20:08:36 +1100
Message-ID: <1170148116.26655.328.camel@localhost.localdomain>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<1170124157.19887.116.camel@concordia.ozlabs.ibm.com>
	<Pine.LNX.4.62.0701300914580.4728@pademelon.sonytel.be>
	<200701300927.52087.arnd@arndb.de>
	<Pine.LNX.4.62.0701300934270.4728@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBp1B-0006iU-Fk for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 01:11:09 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX19Gsv5VQIdkSXZ8VqQuJx9C4Jg2zZrOoAA=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HBp1A-0001SM-TU
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 01:11:09 -0800
In-Reply-To: <Pine.LNX.4.62.0701300934270.4728@pademelon.sonytel.be>
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
Cc: James Simmons <jsimmons@infradead.org>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Arnd Bergmann <arnd@arndb.de>

On Tue, 2007-01-30 at 09:36 +0100, Geert Uytterhoeven wrote:
> On Tue, 30 Jan 2007, Arnd Bergmann wrote:
> > On Tuesday 30 January 2007 09:16, Geert Uytterhoeven wrote:
> > > We have a similar problem with the storage driver, which needs a block of 256
> > > KiB of contiguous memory.
> > 
> > I guess at least that one should be solveable. If the 256kb is only
> > internal flash access, it is should not be part of the storage driver
> > but of whatever else is used to drive this.
> 
> If we convert the FLASH part to a character device driver, the 256 KiB will be
> internal to the character device driver.
> 
> > Assuming the module gets loaded shortly after boot, you can still allocate
> > 256kb practically always, using get_free_pages().
> 
> I'm afraid that assumption is usually false, as you only need to access the
> FLASH when you want to change boot flags or update the boot loader.

At the same time, flash doesn't have to be fast... can't we use a
smaller bounce buffer (a page) and divide the transfer ?

Ben.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
