From: James Simmons <jsimmons@infradead.org>
Subject: Re: ATI Rage XL biosless init
Date: Wed, 17 Mar 2004 22:06:43 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403172205020.19415-100000@phoenix.infradead.org>
References: <3174569B9743D511922F00A0C94314230466D263@TYANWEB>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3jBc-0007RP-5A
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Mar 2004 14:06:52 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B3jBb-00049D-CD
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Mar 2004 14:06:51 -0800
In-Reply-To: <3174569B9743D511922F00A0C94314230466D263@TYANWEB>
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
To: YhLu <YhLu@tyan.com>
Cc: Stefan Reinauer <stepan@suse.de>, Alexander Kern <alex.kern@gmx.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


I cross posted this to see if anyone else ran into this problem. I went 
looking for for Rage XL card last night but couldn't find it. I will look 
for it tonight. 

> The result of your patch.
> 
> atyfb: 3D RAGE (XL PCI-33MHz) [0x4752 rev 0x27] 512K SGRAM, 14.31818 MHz
> XTAL, 230 MHz PLL, 83 Mhz MCLK, 63 MHz XCLK
> atyfb: Unsupported xclk source:  5.
> atyfb: vclk out of range
> atyfb: vclk out of range
> atyfb: vclk out of range
> atyfb: vclk out of range
> not enough video RAM
> atyfb: vclk out of range
> atyfb: vclk out of range
> atyfb: vclk out of range
> atyfb: vclk out of range
> atyfb: vclk out of range
> not enough video RAM
> atyfb: vclk out of range
> not enough video RAM
> atyfb: vclk out of range
> not enough video RAM
> atyfb: vclk out of range
> not enough video RAM
> not enough video RAM
> atyfb: vclk out of range
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> not enough video RAM
> atyfb: vclk out of range
> atyfb: vclk out of range
> atyfb: vclk out of range
> atyfb: vclk out of range
> atyfb: vclk out of range
> atyfb: vclk out of range
> atyfb: vclk out of range
> atyfb: vclk out of range
> atyfb: vclk out of range
> atyfb: vclk out of range
> atyfb: vclk out of range
> atyfb: vclk out of range
> atyfb: vclk out of range
> atyfb: can't set default video mode
> 
> 
> the result for patch I manual changed from 2.4.22.
> atyfb: 3D RAGE (XL PCI-33MHz) [0x4752 rev 0x27] 8M WRAM, 14.31818 MHz XTAL,
> 230 MHz PLL, 83 Mhz MCLK, 63 Mhz XCLK
> fb0: ATY Mach64 frame buffer device on PCI
> 
> It seems that the RAM recognized is different.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
