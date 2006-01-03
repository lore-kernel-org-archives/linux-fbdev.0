From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [patch] [radeonfb] Radeon Mobility X700 (M26)
 and ATOM bios support
Date: Wed, 04 Jan 2006 00:29:31 +0100
Message-ID: <43BB08DB.4050008@vc.cvut.cz>
References: <20060103204404.GA23313@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Etvb0-00037B-PR
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Jan 2006 15:29:38 -0800
Received: from mailgw.cvut.cz ([147.32.3.235])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Etvay-00089Q-5z
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Jan 2006 15:29:38 -0800
Received: from mailgw (localhost [127.0.0.1])
	by mailgw.cvut.cz (Postfix) with SMTP id 554B313B7B1
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  4 Jan 2006 00:29:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mailgw.cvut.cz (Postfix) with ESMTP id 315F213B7B7
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  4 Jan 2006 00:29:32 +0100 (CET)
Received: from mailgw.cvut.cz ([127.0.0.1])
	by localhost (mailgw [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 12468-01-13 for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 4 Jan 2006 00:29:32 +0100 (CET)
Received: from [127.0.0.1] (vana.vc.cvut.cz [147.32.240.58])
	by mailgw.cvut.cz (Postfix) with ESMTP id 0154D13B7B1
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  4 Jan 2006 00:29:31 +0100 (CET)
In-Reply-To: <20060103204404.GA23313@shaftnet.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Stuffed Crust wrote:
> Signed-off-by:  Solomon Peachy <pizza@shaftnet.org>
> 
> Newer Radeon graphics cards use a different table layout in their 
> BIOSes, known as 'ATOM'.  
> 
> I've attached a patch (against 2.6.15) which implements the PLL and LVDS
> parsing out of the ATOM BIOSes, using the current X.org sources as a
> reference.  Notably absent is the code which detects the connectors and
> TDMS information, but it's of lesser importance at the moment.
> 
> This code still has quirks, but I'm not sure if those are due to bugs in
> my patch or incomplete/buggy support for the RV410.  So I'd appreciate
> it if people could try this out, especially if they have a newer ATOM
> BIOS in their radeon card, and let me know what happens. 

Thanks.  It correctly detects panel size from BIOS, unfortunately it behaves 
like X.org driver (which is probably expected).  I captured video just in case 
it provides some clue to somebody 
(http://platan.vc.cvut.cz/ftp/private/radeon/video.avi).  Otherwise I'll try 
some trial & error session during weekend.

Jan  3 23:58:02 debian kernel: radeonfb_pci_register BEGIN
Jan  3 23:58:02 debian kernel: ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 18 
(level, low) -> IRQ 209
Jan  3 23:58:02 debian kernel: radeonfb (0000:01:00.0): Found 131072k of DDR 128 
bits wide videoram
Jan  3 23:58:02 debian kernel: radeonfb (0000:01:00.0): mapped 16384k videoram
Jan  3 23:58:02 debian kernel: ATOM BIOS detected
Jan  3 23:58:02 debian kernel: radeonfb: Retreived PLL infos from BIOS
Jan  3 23:58:02 debian kernel: radeonfb: Reference=27.00 MHz (RefDiv=14) 
Memory=280.00 Mhz, System=358.00 MHz
Jan  3 23:58:02 debian kernel: radeonfb: PLL min 20000 max 50000
Jan  3 23:58:02 debian kernel: XXXX Write ATOM BIOS connector parse
Jan  3 23:58:02 debian kernel: Starting monitor auto detection...
Jan  3 23:58:02 debian kernel: radeonfb: I2C (port 1) ... not found
Jan  3 23:58:02 debian kernel: radeonfb: I2C (port 2) ... not found
Jan  3 23:58:02 debian kernel: radeonfb: I2C (port 3) ... not found
Jan  3 23:58:02 debian kernel: radeonfb: I2C (port 4) ... not found
Jan  3 23:58:02 debian kernel: radeonfb: I2C (port 2) ... not found
Jan  3 23:58:02 debian kernel: radeonfb: I2C (port 4) ... not found
Jan  3 23:58:02 debian kernel: Non-DDC laptop panel detected
Jan  3 23:58:02 debian kernel: radeonfb: I2C (port 3) ... not found
Jan  3 23:58:02 debian kernel: radeonfb: I2C (port 4) ... not found
Jan  3 23:58:02 debian kernel: radeonfb: Monitor 1 type LCD found
Jan  3 23:58:02 debian kernel: radeonfb: Monitor 2 type CRT found
Jan  3 23:58:02 debian kernel: radeonfb: detected LVDS panel size from BIOS: 
1920x1200
Jan  3 23:58:02 debian kernel: BIOS provided panel power delay: 15369
Jan  3 23:58:02 debian kernel: Setting up default mode based on panel info
Jan  3 23:58:02 debian kernel: radeonfb: Dynamic Clock Power Management enabled
Jan  3 23:58:02 debian kernel: hStart = 2020, hEnd = 2052, hTotal = 2184
Jan  3 23:58:02 debian kernel: vStart = 1202, vEnd = 1208, vTotal = 1235
Jan  3 23:58:02 debian kernel: h_total_disp = 0xef0110^I   hsync_strt_wid = 0x407de
Jan  3 23:58:02 debian kernel: v_total_disp = 0x4af04d2^I   vsync_strt_wid = 0x604b1
Jan  3 23:58:02 debian kernel: pixclock = 6589
Jan  3 23:58:02 debian kernel: freq = 15176
Jan  3 23:58:02 debian kernel: freq = 15176, PLL min = 20000, PLL max = 50000
Jan  3 23:58:02 debian kernel: ref_div = 14, ref_clk = 2700, output_freq = 30352
Jan  3 23:58:02 debian kernel: ref_div = 14, ref_clk = 2700, output_freq = 30352
Jan  3 23:58:02 debian kernel: post div = 0x1
Jan  3 23:58:02 debian kernel: fb_div = 0x9d
Jan  3 23:58:02 debian kernel: ppll_div_3 = 0x1009d
Jan  3 23:58:02 debian kernel: Console: switching to colour frame buffer device 
240x75
Jan  3 23:58:02 debian kernel: radeonfb (0000:01:00.0): ATI Radeon VS
Jan  3 23:58:02 debian kernel: radeonfb_pci_register END

							Thanks,
									Petr



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
