From: jurriaan <thunder7@xs4all.nl>
Subject: savagefb not working on thinkpad T23 in
	1400x1050
Date: Mon, 27 Nov 2006 21:11:46 +0100
Message-ID: <20061127201146.GA13885@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gompx-0005sR-V4 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Nov 2006 12:12:22 -0800
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gompw-0004ZZ-Lc
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Nov 2006 12:12:21 -0800
Received: from rivierenland.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-vbr3.xs4all.nl (8.13.8/8.13.8) with ESMTP id kARKCDI0030581
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 27 Nov 2006 21:12:14 +0100 (CET)
	(envelope-from jurriaan@rivierenland.xs4all.nl)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: dok@directfb.org, neo@directfb.org

I got myself a shiny new IBM ThinkPad T23. I've used one for years, and
it worked fine with savagefb and XFree/X.org. The old one had a 1024x768
LCD screen, the new one has a 1400x1050 LCD screen.

Unfortunately, savagefb doesn't work correctly on the new laptop.

X.org works just fine in 1400x1050.

According to lspci, my card is a 

01:00.0 VGA compatible controller: S3 Inc. SuperSavage IX/C SDR (rev 05)
(prog-if 00 [VGA])
Subsystem: IBM ThinkPad T23 (2647-4MG)
Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
Memory at c0100000 (32-bit, non-prefetchable) [size=512K]
Memory at e8000000 (32-bit, prefetchable) [size=64M]
Memory at e4000000 (32-bit, prefetchable) [size=64M]
Memory at e0000000 (32-bit, prefetchable) [size=32M]
[virtual] Expansion ROM at e2000000 [disabled] [size=64K]
Capabilities: <access denied>

modprobe savagefb works just fine, I enabled the debug prints and got:


savagefb: savagefb_init
savagefb: savagefb_probe
savagefb: savage_map_mmio
savagefb: mapped io at e0900000
savagefb: savage_enable_mmio

savagefb: savage_init_hw
savagefb: probed videoram:  16384k
savagefb: Detected current MCLK value of 143182 kHz
savagefb: 1408x1050 TFT LCD panel detected and active
savagefb: Limiting video mode to 1408x1050
savagefb: savage_map_video
savagefb: mapped framebuffer at e0a00000, pbase == e8000000
savagefb: savagefb_check_var
savagefb v0.4.0_2.6: 16256kB VRAM, using 800x600, 37.878kHz, 60Hz
savagefb: savagefb_set_par
savagefb: savagefb_decode_var
savagefb: savagefb_set_par_int
SR    x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 xA xB xC xD xE xF
SR0x  03 01 0f 00 0e 05 06 07 06 05 00 00 0c 50 06 df
SR1x  01 1c c1 41 00 83 00 00 00 23 48 80 fc fe 9c 13
SR2x  7f 88 c2 36 c2 3d 40 cc 7f 00 00 02 1e 00 2e 2f
SR3x  01 10 c6 a0 00 0f f0 00 7f 00 00 00 40 08 00 00
SR4x  01 e5 00 01 00 00 99 00 00 ff 00 00 00 00 00 88
SR5x  00 00 00 f7 10 1f 10 7f 4c 70 e1 04 77 70 00 00
SR6x  ce af b0 11 bc 1e 00 a7 2d 19 19 2a 1c 7f 44 44

CR    x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 xA xB xC xD xE xF
CR0x  7f 63 68 98 69 99 72 f0 00 60 00 00 00 00 00 00
CR1x  59 2d 57 64 00 58 5c eb ff ff ff ff ff ff ff ff
CR2x  ff 00 00 00 00 00 00 00 00 00 00 00 00 8c 2e 05
CR3x  e1 0c 40 a1 10 00 df 4b 4b ad 15 74 3f 00 00 40
CR4x  01 03 00 00 00 00 01 3d 3a 2b 00 ff 3f 7c 40 40
CR5x  c1 80 00 00 00 00 00 00 13 e8 00 00 00 00 40 40
CR6x  02 02 02 00 00 00 89 01 ff 00 00 02 00 22 ff ba
CR7x  10 00 20 25 68 10 4a 00 0f 00 00 00 06 28 20 30
CR8x  00 20 10 80 00 23 28 28 18 28 20 20 20 08 00 00
CR9x  80 64 00 00 00 14 10 fc 01 00 00 00 00 b5 3f 0f
CRax  12 80 00 00 00 00 00 00 00 00 00 00 00 00 03 00
CRbx  a0 3f 20 20 10 10 20

Console: switching to colour frame buffer device 114x42
fb: S3 SuperSavage frame buffer device

Unfortunately, using the full 1400x1050 screen  doesn't work. The screen
is corrupted, with clumps of pixels where normal characters should be,
almost if another line length is used somewhere

The dmesg output looks like this:

savagefb: savagefb_init
savagefb: savagefb_probe
savagefb: savage_map_mmio
savagefb: mapped io at e0900000
savagefb: savage_enable_mmio

savagefb: savage_init_hw
savagefb: probed videoram:  16384k
savagefb: Detected current MCLK value of 71591 kHz
savagefb: 1408x1050 TFT LCD panel detected and active
savagefb: Limiting video mode to 1408x1050
savagefb: savage_map_video
savagefb: mapped framebuffer at e0a00000, pbase == e8000000
savagefb: savagefb_check_var
savagefb v0.4.0_2.6: 16256kB VRAM, using 1400x1050, 63.982kHz, 59Hz
savagefb: savagefb_set_par
savagefb: savagefb_decode_var
savagefb: savagefb_set_par_int
SR    x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 xA xB xC xD xE xF
SR0x  03 01 0f 00 0e 05 06 07 06 05 00 00 0c 50 06 df
SR1x  21 1c 41 2b 00 83 00 00 00 23 48 80 fc fe 9c 13
SR2x  7f 88 c2 36 c2 3d 40 cc 7f 00 00 02 1e 00 2e 2f
SR3x  01 10 c6 a0 00 0f f0 00 7f 00 00 00 40 08 00 00
SR4x  01 e5 00 01 00 00 99 00 00 ff 00 00 00 00 00 88
SR5x  00 00 00 f7 10 1f 10 7f 01 10 00 08 77 70 00 00
SR6x  ce af b0 11 bc 1e 00 a7 2d 19 19 2a 1c 7f 44 44

CR    x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 xA xB xC xD xE xF
CR0x  ce ae b3 81 b4 02 29 10 00 40 00 00 00 00 00 00
CR1x  1b 2e 19 af 00 1a 1d eb ff ff ff ff ff ff ff ff
CR2x  ff 00 00 00 00 00 00 00 00 00 00 00 00 8c 2e 05
CR3x  e1 0c 40 20 10 00 df 4b 4b ad 15 c1 67 00 02 40
CR4x  01 03 00 00 00 00 05 38 39 0f 00 ff 3f 7c 40 40
CR5x  c1 80 00 00 00 00 00 00 13 e8 00 00 00 00 57 57
CR6x  02 02 02 00 00 00 89 01 ff 00 00 02 00 22 ff ba
CR7x  10 00 20 25 68 10 4a 00 0f 00 00 00 06 28 20 30
CR8x  00 20 10 80 00 23 28 28 18 28 20 20 20 08 00 00
CR9x  80 af 00 00 00 14 10 fc 01 00 00 00 00 b5 3f 0f
CRax  12 80 00 00 00 00 00 00 00 00 00 00 00 00 03 00
CRbx  a0 3f 20 20 10 10 20

Console: switching to colour frame buffer device 200x75
fb: S3 SuperSavage frame buffer device

Where do I start to look? Has this driver been tested under there
conditions before? I'd really like to get my framebuffer working again,
so I can play Angband without the overhead of starting X :-)

Thanks,
Jurriaan
-- 
For their part, the Quality ignored Hawk and Fisher. Guards were supposed
to know their place, and Hawk and Fisher were notorious throughout Haven
for not having the faintest idea of what their place was.
	Simon R Green - Hawk & Fisher
Debian (Unstable) GNU/Linux 2.6.19-rc5-mm1 2x4826 bogomips load 4.83

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
