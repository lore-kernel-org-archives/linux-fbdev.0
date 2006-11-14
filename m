From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fwd: [Suspend-devel] resume not working
	on	acer ferrari 4005 with radeonfb enabled
Date: Wed, 15 Nov 2006 09:07:13 +1100
Message-ID: <1163542033.5940.156.camel@localhost.localdomain>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com>
	<200611140008.55059.rjw@sisk.pl>
	<200611142247.55137.chrmhoffmann@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gk6R9-0001AH-Tv for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 14:07:24 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX18u+orYDemGPSmlDAZTs4bk3uK6WPEQMUg=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gk6R8-00066r-3Y
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 14:07:23 -0800
In-Reply-To: <200611142247.55137.chrmhoffmann@gmail.com>
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
To: Christian Hoffmann <chrmhoffmann@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Solomon Peachy <pizza@shaftnet.org>, Pavel Machek <pavel@ucw.cz>


> 
> I tried that patch, but the last message I see over netconsole (using tg3) is:
> Suspending console(s)
> and then nothing. Nothing on resume at all :(
> 
> Adding some printks in the radeonfb_pci_suspend and radeonfb_pci_resume 
> (radeon_pm.c) didn't help: I don't see them. But I am not a kernel programmer 
> at all, so I might do something wrong or in the wrong place.

Does it resume if you make radeon_pci_resume() a nop ? 

Of course, the fbdev will not come back, but will the machine overall
resume ?

Ben.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
