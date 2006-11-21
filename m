From: James Simmons <jsimmons@infradead.org>
Subject: Re: Siemens sx1: merge framebuffer support
Date: Tue, 21 Nov 2006 15:04:45 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611211503190.32103@pentafluge.infradead.org>
References: <20061118181607.GA15275@elf.ucw.cz>
	<20061120190404.GD4597@atomide.com>
	<ce55079f0611202306l3cd57e48t68fe28e7e076d39a@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GmXBM-0003mh-IK for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 21 Nov 2006 07:05:08 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GmXBL-0006FU-SX
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 21 Nov 2006 07:05:08 -0800
In-Reply-To: <ce55079f0611202306l3cd57e48t68fe28e7e076d39a@mail.gmail.com>
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
To: Vladimir <vovan888@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>


Can you post the framebufer driver to the framebuffer list. We like to do 
peer review. Thank you :-)

On Tue, 21 Nov 2006, Vladimir wrote:

> 2006/11/20, Tony Lindgren <tony@atomide.com>:
> > * Pavel Machek <pavel@ucw.cz> [061118 18:16]:
> > > From: Vladimir Ananiev <vovan888@gmail.com>
> > >
> > > Framebuffer support for Siemens SX1; this is second big patch. (Third
> > > one will be mixer/sound support). Support is simple / pretty minimal,
> > > but seems to work okay (and is somehow important for a cell phone :-).
> > 
> > Pushed to linux-omap. I guess you're planning to send the missing
> > Kconfig + Makefile patch for this?
> > 
> > Also, it would be better to use omap_mcbsp_xmit_word() or
> > omap_mcsbsp_spi_master_xmit_word_poll() instead of OMAP_MCBSP_WRITE as
> > it does not do any checking that it worked. The aic23 and tsc2101
> > audio in linux-omap tree in general has the same problem.
> > 
> > Regards,
> > 
> > Tony
> > 
> 
> Hmm. McBSP3 in SX1 is used in "GPIO mode". The only line used is CLKX,
> so I think OMAP_MCBSP_WRITE would be enough. Am I wrong ?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
