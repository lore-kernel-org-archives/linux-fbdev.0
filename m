From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: radeonfb: Can't use the dvi port
Date: Tue, 26 Dec 2006 14:59:57 +0100
Message-ID: <20061226135957.GB4403@frodo.home.lxtec.de>
Reply-To: linux-fbdev-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-users-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-users>,
	<mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-users>
List-Post: <mailto:linux-fbdev-users@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-users>,
	<mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-users-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-users-bounces@lists.sourceforge.net
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, linux-fbdev-users <linux-fbdev-users@lists.sourceforge.net>


Hi all,

I replaced my old monitor with a brandnew LCD one (Samsung
SyncMaster 204B). Booting 2.6.(19|20-rc2) aknowledge the dvi port
but after a while the screen is blank. The monitor claims:

"Not Optimum Mode, Recommended mode : 1600 X 1200 60 Hz"

$ fbset

mode "1600x1200-60"
    # D: 162.022 MHz, H: 75.010 kHz, V: 60.008 Hz
    geometry 1600 1200 1600 1200 8
    timings 6172 304 64 46 1 192 3
    hsync high
    vsync high
    rgba 8/0,8/0,8/0,0/0
endmode


I`ve compiled raeonfb debug in the kernel:
Dec 26 14:52:05 frodo kernel: hStart = 1664, hEnd = 1856, hTotal = 2160
Dec 26 14:52:05 frodo kernel: vStart = 1201, vEnd = 1204, vTotal = 1250
Dec 26 14:52:05 frodo kernel: h_total_disp = 0xc7010d hsync_strt_wid = 0x18067a
Dec 26 14:52:05 frodo kernel: v_total_disp = 0x4af04e1 vsync_strt_wid = 0x304b0
Dec 26 14:52:05 frodo kernel: pixclock = 6172
Dec 26 14:52:05 frodo kernel: freq = 16202
Dec 26 14:52:05 frodo kernel: freq = 16202, PLL min = 20000, PLL max = 40000
Dec 26 14:52:05 frodo kernel: ref_div = 12, ref_clk = 2700, output_freq = 32404
Dec 26 14:52:05 frodo kernel: ref_div = 12, ref_clk = 2700, output_freq = 32404
Dec 26 14:52:05 frodo kernel: post div = 0x1
Dec 26 14:52:05 frodo kernel: fb_div = 0x90
Dec 26 14:52:05 frodo kernel: ppll_div_3 = 0x10090

My card:
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV250 If [Radeon 9000] (rev 01)

Switching to the analog port works well.

Any hints?

Elimar


-- 
  You cannot propel yourself forward by
  patting yourself on the back.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
