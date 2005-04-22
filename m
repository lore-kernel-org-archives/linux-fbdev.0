From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: 2.6.12-rc3 compile failure in tgafb.c,
 tgafb not working anymore
Date: Fri, 22 Apr 2005 21:51:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0504221954410.24170@numbat.sonytel.be>
References: <20050421185034.GS607@vega.lnet.lut.fi> <20050421204354.GF3828@stusta.de>
 <20050422072858.GU607@vega.lnet.lut.fi> <20050422112030.GW607@vega.lnet.lut.fi>
 <20050422144047.GY607@vega.lnet.lut.fi> <Pine.LNX.4.58.0504221024470.2344@ppc970.osdl.org>
 <Pine.LNX.4.61L.0504221840180.27531@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.58.0504221051240.2344@ppc970.osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DP4Bm-0006dP-0r
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Apr 2005 12:51:46 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DP4Bh-0008Q1-DY
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Apr 2005 12:51:45 -0700
In-Reply-To: <Pine.LNX.4.58.0504221051240.2344@ppc970.osdl.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Tomi Lapinlampi <lapinlam@vega.lnet.lut.fi>, Adrian Bunk <bunk@stusta.de>, Linux Kernel Development <linux-kernel@vger.kernel.org>, rth@twiddle.net, adaplas@pol.net

On Fri, 22 Apr 2005, Linus Torvalds wrote:
> On Fri, 22 Apr 2005, Maciej W. Rozycki wrote:
> >  JFTR, a few of the TURBOchannel variations of the TGA are supported for 
> > MIPS, but regrettably the necessary code hasn't been ported from 2.4 to 
> > 2.6 yet.
> 
> Ok, so that would have increased the testing base by, what? One person or 
> two? I think we're still in single digits ;)

All the DEC UDB (`Multia') machines have builtin TGA.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
