From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb: add support for newer
	cards
Date: Thu, 04 Jan 2007 09:08:42 +1100
Message-ID: <1167862122.6165.164.camel@localhost.localdomain>
References: <20070101212551.GA19598@dreamland.darkstar.lan>
	<20070101214442.GA21950@dreamland.darkstar.lan>
	<1167696853.23340.156.camel@localhost.localdomain>
	<68676e00701011638h55264e00g16504b0e3acdad7f@mail.gmail.com>
	<Pine.LNX.4.64.0701031556370.5730@mtl.rackplans.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H2EI3-0000oz-Ep for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Jan 2007 14:08:55 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1/qAgZufI/unC1m3j/ZRyHj2mYb22KPvCU=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H2EI1-0006v4-VB
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Jan 2007 14:08:55 -0800
In-Reply-To: <Pine.LNX.4.64.0701031556370.5730@mtl.rackplans.net>
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
To: Gerhard Mack <gmack@innerfire.net>
Cc: Andrew Morton <akpm@osdl.org>, Luca <kronos.it@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, Solomon Peachy <pizza@shaftnet.org>, linux-kernel@vger.kernel.org


> Is there a list of cards this adds support for?  I'm waiting on support 
> for the X1600

This is not supported, neither by radeonfb (patches or not) nor by
X.org. X1xxx cards have a new display engine and ATI refuses to provide
any specs for it.

Note: I wonder how much of that is related to M$ new Vista DRM that
basically forbids video or sound card vendors from providing specs or
doing open source or they get "revoked" and never get to see "HD"
content... 

Ben.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
