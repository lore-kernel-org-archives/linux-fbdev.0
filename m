From: Louis Garcia <louisg00@bellsouth.net>
Subject: Re: radeonfb and 2.5.66
Date: 26 Mar 2003 14:34:26 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048707266.2533.1.camel@tiger>
References: <Pine.GSO.4.21.0303251607490.22126-100000@vervain.sonytel.be>
	 <1048633657.2513.5.camel@tiger> <1048668763.10474.27.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail227.mail.bellsouth.net ([205.152.58.197] helo=imf25bis.bellsouth.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18yGf3-0005m2-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Mar 2003 11:34:09 -0800
In-Reply-To: <1048668763.10474.27.camel@zion.wanadoo.fr>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

This change had no effect. This is what I get

--Lou


Mar 26 14:28:02 tiger kernel: Journalled Block Device driver loaded
Mar 26 14:28:02 tiger kernel: radeonfb_pci_register BEGIN
Mar 26 14:28:02 tiger kernel: radeonfb: ref_clk=2700, ref_div=12,
xclk=23000 defaults
Mar 26 14:28:03 tiger kernel: radeonfb: probed DDR SGRAM 65536k videoram
Mar 26 14:28:03 tiger kernel: radeonfb: detected DFP panel size from
registers:
1280x1024
Mar 26 14:28:03 tiger kernel: radeonfb: ATI Radeon 7500 QW DDR SGRAM 64
MB
Mar 26 14:28:03 tiger kernel: radeonfb: DVI port DFP monitor connected
Mar 26 14:28:03 tiger kernel: radeonfb: CRT port no monitor connected
Mar 26 14:28:03 tiger kernel: radeonfb_pci_register END
Mar 26 14:28:03 tiger kernel: hStart = 680, hEnd = 960, hTotal = 1056
Mar 26 14:28:03 tiger kernel: vStart = 402, vEnd = 421, vTotal = 442
Mar 26 14:28:03 tiger kernel: h_total_disp = 0x4f0083^I   hsync_strt_wid
= 0xa302a2
Mar 26 14:28:03 tiger kernel: v_total_disp = 0x18f01b9^I  
vsync_strt_wid = 0x930191
Mar 26 14:28:03 tiger kernel: post div = 0x8
Mar 26 14:28:03 tiger kernel: fb_div = 0x59
Mar 26 14:28:03 tiger kernel: ppll_div_3 = 0x30059
Mar 26 14:28:03 tiger kernel: ron = 712, roff = 16464
Mar 26 14:28:03 tiger kernel: vclk_freq = 2503, per = 588
Mar 26 14:28:03 tiger kernel: Console: switching to colour frame buffer
device 80x25
Mar 26 14:28:03 tiger keytable: Loading keymap:



On Wed, 2003-03-26 at 03:52, Benjamin Herrenschmidt wrote:
> On Wed, 2003-03-26 at 00:07, Louis Garcia wrote:
> > When I use video=radeonfb:dfp my monitor just goes into power saving
> > mode (shuts off). This is what I get in the logs: If someone needs more
> > info let me know. By the way I'm on a Intel x86 box.
> 
> Try that: around line 2065, change:
> 
> 	newmode.tmds_transmitter_cntl = (TMDS_RAN_PAT_RST |
> 					 ICHCSEL | TMDS_PLL_EN) &
> 					 ~(TMDS_PLLRST);
> 
> to:
> 
> 	newmode.tmds_transmitter_cntl = (TMDS_RAN_PAT_RST | ICHCSEL) &
> 					 ~(TMDS_PLLRST);
> 
> And tell me if that helps
> 
> Ben.
> 



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
