From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: 2.6.12-rc3 compile failure in tgafb.c, tgafb not working anymore
Date: Fri, 22 Apr 2005 18:44:35 +0100 (BST)
Message-ID: <Pine.LNX.4.61L.0504221840180.27531@blysk.ds.pg.gda.pl>
References: <20050421185034.GS607@vega.lnet.lut.fi> <20050421204354.GF3828@stusta.de>
 <20050422072858.GU607@vega.lnet.lut.fi> <20050422112030.GW607@vega.lnet.lut.fi>
 <20050422144047.GY607@vega.lnet.lut.fi> <Pine.LNX.4.58.0504221024470.2344@ppc970.osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DP2Cd-0007zM-IP
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Apr 2005 10:44:31 -0700
Received: from pollux.ds.pg.gda.pl ([153.19.208.7] ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DP2Cc-0004Qn-1h
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Apr 2005 10:44:31 -0700
In-Reply-To: <Pine.LNX.4.58.0504221024470.2344@ppc970.osdl.org>
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
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tomi Lapinlampi <lapinlam@vega.lnet.lut.fi>, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, rth@twiddle.net, adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net

On Fri, 22 Apr 2005, Linus Torvalds wrote:

> Most people don't have tga hardware. I don't think even most alpha users 
> have it, and I think it's unheard of outside of alpha. So I'm afraid that 
> there's not a lot of people around who can debug it without having a very 
> clear starting point..

 JFTR, a few of the TURBOchannel variations of the TGA are supported for 
MIPS, but regrettably the necessary code hasn't been ported from 2.4 to 
2.6 yet.

  Maciej


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
