From: Andrew Morton <akpm@osdl.org>
Subject: Fw: atyfb doesn't work for me
Date: Tue, 4 Apr 2006 03:03:18 -0700
Message-ID: <20060404030318.3c80b12a.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FQiOU-0000oI-7H
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 03:04:14 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1FQiOS-00088j-MQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 03:04:14 -0700
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
Cc: Greg Stark <gsstark@mit.edu>


Begin forwarded message:

Date: 04 Apr 2006 01:18:44 -0400
From: Greg Stark <gsstark@mit.edu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: atyfb doesn't work for me



When I try to load atyfb I get messages about "unsupported xclk source" and
"vclk out of range" and the fb devices don't seem to be active. That is, 
  fbset -fb /dev/fb?
all say "no such device"

I see there are module parameters to override some of these settings but I'm
not clear where I would find the correct values to use. And surely the fb
driver ought to be able to come up usable values on its own?


[   25.724880] PCI: Enabling device 0000:02:0b.0 (0080 -> 0083)
[   25.724943] ACPI: PCI Interrupt 0000:02:0b.0[A] -> GSI 23 (level, low) -> IRQ 18
[   25.725047] atyfb: using auxiliary register aperture
[   25.725125] atyfb: 3D RAGE II (Mach64 GT) [0x4754 rev 0x41]
[   25.725176] atyfb: Mach64 BIOS is located at c0000, mapped at c00c0000.
[   25.725228] atyfb: BIOS frequency table:
[   25.725281] atyfb: PCLK_min_freq 26465, PCLK_max_freq 24930, ref_freq 11829, ref_divider 12902
[   25.725337] atyfb: MCLK_pwd 12598, MCLK_max_freq 8241, XCLK_max_freq 22016, SCLK_freq 13619
[   25.725418] atyfb: 512K SDRAM (1:1), 14.31818 MHz XTAL, 249 MHz PLL, 82 Mhz MCLK, 220 MHz XCLK
[   25.725473] atyfb: Unsupported xclk source:  5.
[   25.725654] atyfb: vclk out of range
[   25.725703] atyfb: can't set default video mode
[   25.762829] PCI: Enabling device 0000:02:0c.0 (0080 -> 0083)
[   25.762882] ACPI: PCI Interrupt 0000:02:0c.0[A] -> GSI 20 (level, low) -> IRQ 19
[   25.762965] atyfb: using auxiliary register aperture
[   25.763020] atyfb: 3D RAGE II+ (Mach64 GU) [0x4755 rev 0x9a]
[   25.763065] atyfb: Mach64 BIOS is located at c0000, mapped at c00c0000.
[   25.763109] atyfb: BIOS frequency table:
[   25.763150] atyfb: PCLK_min_freq 26465, PCLK_max_freq 24930, ref_freq 11829, ref_divider 12902
[   25.763201] atyfb: MCLK_pwd 12598, MCLK_max_freq 8241, XCLK_max_freq 22016, SCLK_freq 13619
[   25.763276] atyfb: 512K RESV, 14.31818 MHz XTAL, 249 MHz PLL, 82 Mhz MCLK, 220 MHz XCLK
[   25.763326] atyfb: Unsupported xclk source:  5.
[   25.763496] atyfb: vclk out of range
[   25.763541] atyfb: can't set default video mode


-- 
greg

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
