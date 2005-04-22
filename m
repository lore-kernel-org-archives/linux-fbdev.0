From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.12-rc3 compile failure in tgafb.c, tgafb not working anymore
Date: Fri, 22 Apr 2005 10:26:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504221024470.2344@ppc970.osdl.org>
References: <20050421185034.GS607@vega.lnet.lut.fi> <20050421204354.GF3828@stusta.de>
 <20050422072858.GU607@vega.lnet.lut.fi> <20050422112030.GW607@vega.lnet.lut.fi>
 <20050422144047.GY607@vega.lnet.lut.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DP1tk-0006v8-Cb
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Apr 2005 10:25:00 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DP1ti-00020i-TV
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Apr 2005 10:25:00 -0700
In-Reply-To: <20050422144047.GY607@vega.lnet.lut.fi>
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
To: Tomi Lapinlampi <lapinlam@vega.lnet.lut.fi>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, rth@twiddle.net, adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net



On Fri, 22 Apr 2005, Tomi Lapinlampi wrote:
> 
> Although the tgafb driver compiles with the above patch, it shows
> similar behaviour as before: The kernel loads, the monitor comes alive
> but the screen stays completely blank.
> The last kernel that worked was 2.6.8.1. I've tested with 2.6.{9,10,11}

Can you try to figure out where in between 2.6.8->2.6.9 things broke? Even 
just a fairly simple binary search on the nightly snapshots should get you 
pretty easily down to within one day or so..

Most people don't have tga hardware. I don't think even most alpha users 
have it, and I think it's unheard of outside of alpha. So I'm afraid that 
there's not a lot of people around who can debug it without having a very 
clear starting point..

		Linus


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
