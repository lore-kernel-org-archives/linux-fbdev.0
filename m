From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Make radeonfb work with R300
Date: Mon, 24 Mar 2003 18:57:48 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303241857390.22808-100000@phoenix.infradead.org>
References: <20030323171156.GA505@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xX9L-0000j5-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 24 Mar 2003 10:58:24 -0800
In-Reply-To: <20030323171156.GA505@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, ajoshi@unixbox.com


Applied.

> 
> Hi,
> radeonfb is  unable to  acquire the  pll clock values  from the  BIOS on
> newer radeon cards and uses default values which don't work.
> 
> Using ATI binary driver for X I founded this in the log:
> 
> (II) fglrx(0): PLL parameters: rf=2700 rd=12 min=20000 max=40000; xclk=27000
> 
> This patch (against 2.5.65) sets pll values according to X:
> 
> --- drivers/video/radeonfb.orig.c	Sun Mar 23 16:15:04 2003
> +++ drivers/video/radeonfb.c	Sun Mar 23 18:01:48 2003
> @@ -881,6 +881,16 @@
>  				rinfo->pll.ref_div = 12;
>  				rinfo->pll.ref_clk = 2700;
>  				break;
> +			case PCI_DEVICE_ID_ATI_RADEON_ND:
> +			case PCI_DEVICE_ID_ATI_RADEON_NE:
> +			case PCI_DEVICE_ID_ATI_RADEON_NF:
> +			case PCI_DEVICE_ID_ATI_RADEON_NG:
> +				rinfo->pll.ppll_max = 40000;
> +				rinfo->pll.ppll_min = 20000;
> +				rinfo->pll.xclk = 27000;
> +				rinfo->pll.ref_div = 12;
> +				rinfo->pll.ref_clk = 2700;
> +				break;
>  			case PCI_DEVICE_ID_ATI_RADEON_QD:
>  			case PCI_DEVICE_ID_ATI_RADEON_QE:
>  			case PCI_DEVICE_ID_ATI_RADEON_QF:
> 
> 
> It works on  a R300 NE (9500 Pro),  but should be ok also  for the other
> R300 chips (don't have the hw to make a test though).
> 
> In X log there is also this line:
> 
> (II) fglrx(0): Primary V_BIOS segment is: 0xc000
> 
> I've no idea of what V_BIOS is (Video BIOS?), but it may be useful ;)
> 
> 
> HTH,
> Luca
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
