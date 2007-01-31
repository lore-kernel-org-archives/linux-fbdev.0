From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 0/6] RFC Cell SPE logos
Date: Wed, 31 Jan 2007 12:44:14 +1100
Message-ID: <1170207854.26655.358.camel@localhost.localdomain>
References: <Pine.LNX.4.62.0701301854060.2509@pademelon.sonytel.be>
	<200701310219.00795.arnd@arndb.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HC4Wf-0002VB-QE for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 17:44:41 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX19c2gIA+dmVVVqdXdx4kl6YQOpBnplQm+Q=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HC4Wd-0000hV-SU
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 17:44:41 -0800
In-Reply-To: <200701310219.00795.arnd@arndb.de>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, cbe-oss-dev@ozlabs.org

On Wed, 2007-01-31 at 02:19 +0100, Arnd Bergmann wrote:
> On Tuesday 30 January 2007 19:00, Geert Uytterhoeven wrote:
> > The Cell Broadband Engine contains a 64-bit PowerPC core with 2 hardware
> > threads (called PPEs) and 8 Synergistic Processing Engines (called SPEs).
> > When booting Linux, 2 penguins logos are shown on the graphical console.
> > 
> > To emphasize the existence of the SPEs (which can be used under Linux), we
> > added a second row of (smaller) helper Penguin logos, one for each SPE.
> 
> I love the small penguins, they're cute!
> 
> You should probably run this patch set through linux-kernel@vger though,
> so see if there are people around there objecting to the idea. The patches
> all look good from a technical point, except for the fact that the existing
> fb boot logo is a gross hack to start with, but I don't think anyone is
> arguing for getting rid of that.

Well, the fb boot logo might be a gross hack but didnt Geert write it in
the first place ? :-)

Ben.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
