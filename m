From: Kronos <kronos@kronoz.cjb.net>
Subject: [2.5.59] radeonfb not working
Date: Wed, 29 Jan 2003 16:27:03 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030129152703.GA539@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail-8.tiscali.it ([195.130.225.154] helo=mail.tiscali.it)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18du7Q-0003NL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 Jan 2003 07:27:16 -0800
Received: from dreamland.darkstar.lan (217.133.181.65) by mail.tiscali.it (6.5.032)
        id 3E351FE800174698 for linux-fbdev-devel@lists.sourceforge.net; Wed, 29 Jan 2003 16:27:02 +0100
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hi,
I've a  Radeon 9500 Pro board  and framebuffer isn't working. If  I boot
with "video=radeon" monitor complains about "Out of scan range". This is
from the bootlog:

radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=67, xclk=16600 defaults
radeonfb: probed SDR SGRAM 131072k videoram
radeon_get_moninfo: bios 4 scratch = 2000002
radeonfb: ATI Radeon 9700 NE SDR SGRAM 128 MB
radeonfb: DVI port no monitor connected
radeonfb: CRT port CRT monitor connected
radeonfb_pci_register END
hStart = 664, hEnd = 760, hTotal = 800
vStart = 491, vEnd = 493, vTotal = 525
h_total_disp = 0x4f0063    hsync_strt_wid = 0x8c02a2
v_total_disp = 0x1df020c           vsync_strt_wid = 0x8201ea
post div = 0x8
fb_div = 0x1f4
ppll_div_3 = 0x301f4
ron = 1024, roff = 23632
vclk_freq = 2519, per = 844
Console: switching to colour frame buffer device 80x30

If   I  append   a  specific   video  mode   I'll  get   "out  of   scan
range"   or  "no   signal"  depending   on  the   video  mode. This   is
"video=radeon:640x480-16@85" (no signal):

radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=67, xclk=16600 defaults
radeonfb: probed SDR SGRAM 131072k videoram
radeon_get_moninfo: bios 4 scratch = 2000002
radeonfb: ATI Radeon 9700 NE SDR SGRAM 128 MB
radeonfb: DVI port no monitor connected
radeonfb: CRT port CRT monitor connected
radeonfb_pci_register END
hStart = 696, hEnd = 752, hTotal = 832
vStart = 481, vEnd = 484, vTotal = 509
h_total_disp = 0x4f0067    hsync_strt_wid = 0x8702b9
v_total_disp = 0x1df01fc           vsync_strt_wid = 0x8301e0
post div = 0x4
fb_div = 0x165
ppll_div_3 = 0x20165
ron = 960, roff = 16548
vclk_freq = 3597, per = 591
Console: switching to colour frame buffer device 80x30

ciao,
Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Il coraggio non mi manca.
E` la paura che mi frega...


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
