From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC: 2.6 patch] remove broken video drivers
Date: Sun, 19 Nov 2006 12:46:41 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0611191246150.31733@pademelon.sonytel.be>
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
	id 1Gll8Q-0005az-Lc for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 19 Nov 2006 03:46:54 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gll8Q-0001e1-9w
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 19 Nov 2006 03:46:54 -0800
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
Cc: linux-m68k@vger.kernel.org, James Simmons <jsimmons@infradead.org>, Roman Zippel <zippel@linux-m68k.org>, Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>, Linux Kernel Development <linux-kernel@vger.kernel.org>, adaplas@pol.net, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 18 Nov 2006, Adrian Bunk wrote:
> On Sat, Nov 18, 2006 at 11:34:41AM +0100, Michael Schmitz wrote:
> > On Sat, 18 Nov 2006, Adrian Bunk wrote:
> Are any of the following Atari options that are also on my
> "BROKEN since at least 2.6.0" list also being revived?
> 
> - HADES (arch/m68k/Kconfig)
> - ATARI_ACSI (drivers/net/Kconfig)
> - ATARI_BIONET (drivers/net/Kconfig)
> - ATARI_PAMSNET (drivers/net/Kconfig)
> - ATARI_SCSI (drivers/scsi/Kconfig)

AFAIK, Michael is also working on ATARI_SCSI.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
