From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [Fwd: AtyFB in 2.6.10, still not perfect]
Date: Wed, 16 Mar 2005 04:39:05 +0800
Message-ID: <200503160439.05644.adaplas@hotpop.com>
References: <200503151826.46073.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBIou-0000HC-Fi
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 12:39:16 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DBIor-0000F1-PD
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 12:39:16 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 3AE0D14BD29A
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Mar 2005 20:39:00 +0000 (UTC)
In-Reply-To: <200503151826.46073.adaplas@hotpop.com>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: Luigi Gangitano <luigi@debian.org>
Cc: Alexander Kern <alex.kern@gmx.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tuesday 15 March 2005 18:26, Antonino A. Daplas wrote:
> --- Luigi Gangitano <luigi@debian.org> wrote:

> 4.  Can you post the dmesg, config and fbset -i of both the
> working and non-working kernel?
>

The dmesg log you sent me showed this:

working:
atyfb: 3D RAGE (XL) [0x4752 rev 0x27] 8M SDRAM, 29.498928 MHz XTAL, 230 
MHz PLL, 100 Mhz MCLK

not working:
atyfb: 3D RAGE XL (Mach64 GR, PCI-33MHz) [0x4752 rev 0x27]
atyfb: 8M SDRAM (1:1), 29.498928 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 63 
MHz XCLK

The MCLK value is different.  Can you try booting with

video=atyfb:mclk:100

You can also experiment with xclk:

video=atyfb:mclk:100,xclk:63

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
