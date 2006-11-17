From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fwd: [Suspend-devel] resume not working
	on	acer ferrari 4005 with radeonfb enabled
Date: Sat, 18 Nov 2006 08:57:55 +1100
Message-ID: <1163800675.5826.19.camel@localhost.localdomain>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com>
	<200611151109.06956.rjw@sisk.pl>
	<200611162317.30880.chrmhoffmann@gmail.com>
	<200611162344.41622.rjw@sisk.pl> <20061117052755.GA23831@shaftnet.org>
	<1163744220.5940.443.camel@localhost.localdomain>
	<20061117143658.GB5158@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GlBiV-0002xo-Oe for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 13:57:47 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1+9SnzIbAmBRjOgtHgYPHO7AkD4PWwWetE=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GlBiT-00039Y-G6
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 13:57:47 -0800
In-Reply-To: <20061117143658.GB5158@shaftnet.org>
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


> If I understand what you're saying correctly, if we re-write a valid set
> of pci registers, we'll trash the radeon state?   Why _wouldn't_ a D3 
> resume be trashed?

No, we determine in advance what we support. On resume, we don't want to
do a full reset of the chip if it was not powered down. (Among others,
this isn't tested and we might not be doing it properly from a non
poweron-reset state).

Ben.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
