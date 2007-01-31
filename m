From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [PATCH 0/6] RFC Cell SPE logos
Date: Wed, 31 Jan 2007 02:19:00 +0100
Message-ID: <200701310219.00795.arnd@arndb.de>
References: <Pine.LNX.4.62.0701301854060.2509@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HC480-00008J-SZ for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 17:19:16 -0800
Received: from moutng.kundenserver.de ([212.227.126.186])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HC480-0003mR-BE
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 17:19:12 -0800
In-Reply-To: <Pine.LNX.4.62.0701301854060.2509@pademelon.sonytel.be>
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
To: cbe-oss-dev@ozlabs.org
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

On Tuesday 30 January 2007 19:00, Geert Uytterhoeven wrote:
> The Cell Broadband Engine contains a 64-bit PowerPC core with 2 hardware
> threads (called PPEs) and 8 Synergistic Processing Engines (called SPEs).
> When booting Linux, 2 penguins logos are shown on the graphical console.
> 
> To emphasize the existence of the SPEs (which can be used under Linux), we
> added a second row of (smaller) helper Penguin logos, one for each SPE.

I love the small penguins, they're cute!

You should probably run this patch set through linux-kernel@vger though,
so see if there are people around there objecting to the idea. The patches
all look good from a technical point, except for the fact that the existing
fb boot logo is a gross hack to start with, but I don't think anyone is
arguing for getting rid of that.

	Arnd <><

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
