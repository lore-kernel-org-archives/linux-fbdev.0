From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fwd: [Suspend-devel] resume not working
	on	acer ferrari 4005 with radeonfb enabled
Date: Fri, 17 Nov 2006 17:17:00 +1100
Message-ID: <1163744220.5940.443.camel@localhost.localdomain>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com>
	<200611151109.06956.rjw@sisk.pl>
	<200611162317.30880.chrmhoffmann@gmail.com>
	<200611162344.41622.rjw@sisk.pl> <20061117052755.GA23831@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gkx2L-0008OY-WD for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Nov 2006 22:17:18 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX19ZK814gWw+ahEJB25CdxEwwO6XZLuy3Z4=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gkx2J-0004UE-Fo
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Nov 2006 22:17:17 -0800
In-Reply-To: <20061117052755.GA23831@shaftnet.org>
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
To: Stuffed Crust <pizza@shaftnet.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On Fri, 2006-11-17 at 00:27 -0500, Stuffed Crust wrote:
> On Thu, Nov 16, 2006 at 11:44:40PM +0100, Rafael J. Wysocki wrote:
> > I think the call to radeon_restore_pci_cfg(rinfo) causes the problem to happen.
> 
> radeonfb is still using its own code for saving and restoring PCI 
> registers; I'm in the process of fixing it up to use proper PCI
> subsystem calls.  That will hopefully work better.   
> 
> It's possible there's a good reason (other than "nobody's ported it over 
> yet") that the radeonfb driver is doing it manually, but I don't know 
> why that would be the case.  

Well, radeonfb has code to bring back some cards from D2 or D3 cold (or
hard reset). It differenciates those states by checking if the config
space has been trashed. We should try to find out some better way.

Cheers,
Ben.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
