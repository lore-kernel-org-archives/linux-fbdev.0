From: Andrew Walrond <andrew@walrond.org>
Subject: ATI Rage XL on x86_64
Date: Wed, 26 Jan 2005 09:10:14 +0000
Message-ID: <200501260910.14102.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtjC4-0005Lf-0k
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Jan 2005 01:10:32 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CtjC2-0007K8-81
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Jan 2005 01:10:31 -0800
Received: from [62.24.231.115] (helo=host62-24-231-115.dsl.vispa.com)
	by cenedra.walrond.org with esmtp (Exim 4.34)
	id 1CtjBm-0007C7-5k
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Jan 2005 09:10:18 +0000
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
To: linux-fbdev-devel@lists.sourceforge.net

I have lots of server boards with Rage XL onboard, and have just spent a few 
hours trying to get a working framebuffer using the atyfb driver (built-in)

However I have failed miserably so far. Before I start wading through the 
code, perhaps someone  can confirm that I am using the right kernel 
parameters?

This
 video=atyfb:vmode:14,cmode:8
gives
 atyfb: using auxiliary register aperture
 atyfb: 3D RAGE XL (Mach64 GR, PCI-33MHz) [0x4752 rev 0x27]
 atyfb: 8M SDRAM (2:1) (32-bit) 29.498928 MHz XTAL, 230MHz PLL, 83 MHz MCLK  
63MHz XCLK
 atyfb: MACH64 chips are designed for max 1600x1200
 select anoter resolution
 atyfb: MACH64 chips are designed for max 1600x1200
 select anoter resolution
 atyfb: vclk out of range
 atyfb: vclk out of range
 atyfb: fb0: ATY Mach64 frame buffer device on PCI

and this
 video=atyfb:vmode:14,cmode:8
gives
 atyfb: using auxiliary register aperture
 atyfb: 3D RAGE XL (Mach64 GR, PCI-33MHz) [0x4752 rev 0x27]
 atyfb: 8M SDRAM (2:1) (32-bit) 29.498928 MHz XTAL, 230MHz PLL, 83 MHz MCLK  
63MHz XCLK
 atyfb: MACH64 chips are designed for max 1600x1200
 select anoter resolution
 atyfb: MACH64 chips are designed for max 1600x1200
 select anoter resolution
 atyfb: fb0: ATY Mach64 frame buffer device on PCI


(The speliing mistake is real BTW)

Any clues?

Andrew Walrond



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
