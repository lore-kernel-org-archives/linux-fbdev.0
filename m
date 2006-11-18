From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC: 2.6 patch] remove broken video drivers
Date: Sat, 18 Nov 2006 20:55:19 +0100
Message-ID: <20061118195519.GZ31879@stusta.de>
References: <20061118000235.GV31879@stusta.de>
	<Pine.LNX.4.58.0611181132230.7667@xplor.biophys.uni-duesseldorf.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GlWIR-0004ZB-6v for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 18 Nov 2006 11:56:15 -0800
Received: from emailhub.stusta.mhn.de ([141.84.69.5]
	helo=mailout.stusta.mhn.de)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GlWIO-00046w-Jh
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 18 Nov 2006 11:56:15 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0611181132230.7667@xplor.biophys.uni-duesseldorf.de>
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
To: Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de>
Cc: linux-m68k@vger.kernel.org, James Simmons <jsimmons@infradead.org>, linux-fbdev-devel@lists.sourceforge.net, zippel@linux-m68k.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, adaplas@pol.net

On Sat, Nov 18, 2006 at 11:34:41AM +0100, Michael Schmitz wrote:
> On Sat, 18 Nov 2006, Adrian Bunk wrote:
> 
> > This patch removes video drivers that:
> > - had already been marked as BROKEN in 2.6.0 three years ago and
> > - are still marked as BROKEN.
> >
> > These are the following drivers:
> > - FB_CYBER
> > - FB_VIRGE
> > - FB_RETINAZ3
> > - FB_ATARI
> 
> FB_ATARI has just been revived. Geert has a preliminary patch; I'll send
> the final one soonish.

Thanks for this information.

Are any of the following Atari options that are also on my
"BROKEN since at least 2.6.0" list also being revived?

- HADES (arch/m68k/Kconfig)
- ATARI_ACSI (drivers/net/Kconfig)
- ATARI_BIONET (drivers/net/Kconfig)
- ATARI_PAMSNET (drivers/net/Kconfig)
- ATARI_SCSI (drivers/scsi/Kconfig)

> 	Michael

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
