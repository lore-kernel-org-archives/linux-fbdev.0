From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC: 2.6 patch] remove broken video drivers
Date: Mon, 20 Nov 2006 21:02:27 +0100
Message-ID: <20061120200227.GZ31879@stusta.de>
References: <20061118000235.GV31879@stusta.de>
	<Pine.LNX.4.58.0611181132230.7667@xplor.biophys.uni-duesseldorf.de>
	<20061118195519.GZ31879@stusta.de>
	<Pine.LNX.4.58.0611201014280.24134@xplor.biophys.uni-duesseldorf.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GmFLg-0006zq-BH for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Nov 2006 12:02:36 -0800
Received: from emailhub.stusta.mhn.de ([141.84.69.5]
	helo=mailout.stusta.mhn.de)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GmFLe-0001c5-SE
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Nov 2006 12:02:35 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0611201014280.24134@xplor.biophys.uni-duesseldorf.de>
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

On Mon, Nov 20, 2006 at 10:17:28AM +0100, Michael Schmitz wrote:
> > > > - FB_ATARI
> > >
> > > FB_ATARI has just been revived. Geert has a preliminary patch; I'll send
> > > the final one soonish.
> >
> > Thanks for this information.
> >
> > Are any of the following Atari options that are also on my
> > "BROKEN since at least 2.6.0" list also being revived?
> >
> > - HADES (arch/m68k/Kconfig)
> > - ATARI_ACSI (drivers/net/Kconfig)
> > - ATARI_BIONET (drivers/net/Kconfig)
> 
> These three I can try to 'revive' without actually being able to test
> them.
> 
> > - ATARI_PAMSNET (drivers/net/Kconfig)
> > - ATARI_SCSI (drivers/scsi/Kconfig)
> 
> These two (assuming PAMSNET is the VME ethercard) I can even test myself.
> So you can mark them 'being worked on'...

Thanks, I've removed them from my death row.

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
