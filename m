From: andrew may <acmay@acmay.homeip.net>
Subject: Radeon video in PowerBook G4 800
Date: Wed, 5 Jun 2002 15:55:04 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020605155504.A26280@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 24-25-196-177.san.rr.com ([24.25.196.177] helo=acmay.homeip.net)
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17FjgI-0004jD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Jun 2002 15:55:06 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
To: bh40@calva.net
Cc: Ani Joshi <ajoshi@shell.unixbox.com>, Linux fbdev <linux-fbdev-devel@lists.sourceforge.net>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii

I am having problems with the radeon fb driver in BenH's 2.4.19-pre10
kernel. When it boots I get a strange grayish red blob that covers most
of the screen starting from the bottom right side.

I tried Xfree 4.20 and saw a similar effect.

Here is a dump from the init with DEBUG turned on in the driver.

The BenH kernel has some fixes from the 0.1.4 radeon driver and
I have not been able to get the 0.1.5 patch from the archieves 
to try.

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=fb-pre10

Jun  4 23:28:10 turtle kernel: radeonfb_pci_register BEGIN
Jun  4 23:28:10 turtle kernel: PCI: Enabling device 00:10.0 (0086 -> 0087)
Jun  4 23:28:10 turtle kernel: radeonfb: ref_clk=2700, ref_div=12, xclk=36675 from OF
Jun  4 23:28:10 turtle kernel: radeonfb: probed DDR SGRAM 32768k videoram
Jun  4 23:28:10 turtle kernel: radeonfb: detected DFP panel size from EDID: 1280x854
Jun  4 23:28:10 turtle kernel: DFP: H 1280 256 16 112 V 854 12 1 3
Jun  4 23:28:10 turtle kernel: hStart = 1296, hEnd = 1408, hTotal = 1536
Jun  4 23:28:10 turtle kernel: vStart = 855, vEnd = 858, vTotal = 866
Jun  4 23:28:10 turtle kernel: h_total_disp = 0x9f00bf^I   hsync_strt_wid = 0x8e050a
Jun  4 23:28:10 turtle kernel: v_total_disp = 0x3550361^I   vsync_strt_wid = 0x830356
Jun  4 23:28:10 turtle kernel: post div = 0x2
Jun  4 23:28:10 turtle kernel: fb_div = 0x47
Jun  4 23:28:10 turtle kernel: ppll_div_3 = 0x10047
Jun  4 23:28:10 turtle kernel: ron = 832, roff = 16464
Jun  4 23:28:10 turtle kernel: vclk_freq = 7988, per = 588
Jun  4 23:28:10 turtle kernel: Console: switching to colour frame buffer device 160x53
Jun  4 23:28:10 turtle kernel: Registered "ati" backlight controller, level: 15/15
Jun  4 23:28:10 turtle kernel: radeonfb: pm reg @50, clk_pwrmgt: f17500, pll_pwrmgt: a027e01f, mdll_cko: 980098
Jun  4 23:28:10 turtle kernel: radeonfb: ATI Radeon M7 LW  DDR SGRAM 32 MB
Jun  4 23:28:10 turtle kernel: radeonfb: DVI port LCD monitor connected
Jun  4 23:28:10 turtle kernel: radeonfb: CRT port no monitor connected
Jun  4 23:28:10 turtle kernel: radeonfb_pci_register END


--8t9RHnE3ZwKMSgU+--

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
