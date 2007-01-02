From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb: add support for newer
	cards
Date: Tue, 02 Jan 2007 11:14:13 +1100
Message-ID: <1167696853.23340.156.camel@localhost.localdomain>
References: <20070101212551.GA19598@dreamland.darkstar.lan>
	<20070101214442.GA21950@dreamland.darkstar.lan>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H1XIK-0006D4-25 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 16:14:20 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1+ODWY0l+RR1Y4XDPACwBOKNOiqBRS53OM=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H1XIJ-0004lb-Ia
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 16:14:20 -0800
In-Reply-To: <20070101214442.GA21950@dreamland.darkstar.lan>
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
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Solomon Peachy <pizza@shaftnet.org>, linux-kernel@vger.kernel.org

On Mon, 2007-01-01 at 22:44 +0100, Luca Tettamanti wrote:
> Il Mon, Jan 01, 2007 at 10:25:51PM +0100, Luca Tettamanti ha scritto: 
> > Hi Ben, Andrew,
> > I've rebased 'ATOM BIOS patch' from Solomon Peachy to apply to 2.6.20.
> > The patch adds support for newer Radeon cards and is mainly based on
> > X.Org code.
> 
> And - for an easier review - this is the diff between
> radeonfb-atom-2.6.19-v6a.diff from Solomon and my patch (whitespace-only
> changes not included).

Ah good, what I was asking for :-) I'll try to get a new patch combining
everything out asap.

Ben.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
