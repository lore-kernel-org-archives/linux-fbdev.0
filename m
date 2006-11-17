From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fwd: [Suspend-devel] resume not
	working	onacer ferrari 4005 with radeonfb enabled
Date: Sat, 18 Nov 2006 09:34:42 +1100
Message-ID: <1163802883.5826.51.camel@localhost.localdomain>
References: <000701c70a94$1d9c2b40$6700a8c0@r2d2>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GlCIA-0006g6-NQ for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 14:34:38 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX18NSDFgXtcQ9BMXzu4DN15tof9Njc1veyo=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GlCI9-00056P-Jh
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 14:34:38 -0800
In-Reply-To: <000701c70a94$1d9c2b40$6700a8c0@r2d2>
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
To: Christian Hoffmann <email@christianhoffmann.info>
Cc: 'Andrew Morton' <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, 'Christian Hoffmann' <Christian.Hoffmann@wallstreetsystems.com>, 'LKML' <linux-kernel@vger.kernel.org>, "'Rafael J. Wysocki'" <rjw@sisk.pl>, 'Stuffed Crust' <pizza@shaftnet.org>, 'Pavel Machek' <pavel@ucw.cz>


> Sorry, but how do I do that? 
> 
> Chris
> 
> BTW: yes, it's a PCI-express card.

You need to wit a bit for me to check wether we have added the PCI-E
specific registers to radeontool dump :-)

Ben.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
