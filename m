From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Subject: Re: [RFC: 2.6 patch] remove broken video drivers
Date: Mon, 20 Nov 2006 10:17:28 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0611201014280.24134@xplor.biophys.uni-duesseldorf.de>
References: <20061118000235.GV31879@stusta.de>
	<Pine.LNX.4.58.0611181132230.7667@xplor.biophys.uni-duesseldorf.de>
	<20061118195519.GZ31879@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gm5Ho-0004Kn-4l for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Nov 2006 01:17:56 -0800
Received: from opal.biophys.uni-duesseldorf.de ([134.99.176.7])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gm5Hl-0001SW-8m
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Nov 2006 01:17:55 -0800
In-Reply-To: <20061118195519.GZ31879@stusta.de>
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
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-m68k@vger.kernel.org, James Simmons <jsimmons@infradead.org>, linux-fbdev-devel@lists.sourceforge.net, zippel@linux-m68k.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, adaplas@pol.net, Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>

> > > - FB_ATARI
> >
> > FB_ATARI has just been revived. Geert has a preliminary patch; I'll send
> > the final one soonish.
>
> Thanks for this information.
>
> Are any of the following Atari options that are also on my
> "BROKEN since at least 2.6.0" list also being revived?
>
> - HADES (arch/m68k/Kconfig)
> - ATARI_ACSI (drivers/net/Kconfig)
> - ATARI_BIONET (drivers/net/Kconfig)

These three I can try to 'revive' without actually being able to test
them.

> - ATARI_PAMSNET (drivers/net/Kconfig)
> - ATARI_SCSI (drivers/scsi/Kconfig)

These two (assuming PAMSNET is the VME ethercard) I can even test myself.
So you can mark them 'being worked on'...

	Michael

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
