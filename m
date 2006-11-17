From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fwd: [Suspend-devel] resume not working
	on	acer ferrari 4005 with radeonfb enabled
Date: Sat, 18 Nov 2006 08:59:28 +1100
Message-ID: <1163800768.5826.21.camel@localhost.localdomain>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com>
	<20061117060758.GB25413@shaftnet.org>
	<20061117154119.GC5158@shaftnet.org>
	<200611172133.50049.chrmhoffmann@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GlBjz-00039M-NP for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 13:59:19 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX19WEY5hYHoxercj1CL7Mnf32fOVDJ1xRqg=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GlBjy-0002GO-Nz
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 13:59:19 -0800
In-Reply-To: <200611172133.50049.chrmhoffmann@gmail.com>
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
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Stuffed Crust <pizza@shaftnet.org>, Pavel Machek <pavel@ucw.cz>


> When I comment out the rinfo->asleep = 0; line, the machine comes back. So it 
> seems that rinfo struct is still corrupted somehow.

No, I don't think the rinfo is corrupted, I think the chip is in a state
the driver can't cope with. Possibly related to some PCI-Express
specific bits or to the memory map.

At this point, we'll need to do register dumps.

Ben.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
