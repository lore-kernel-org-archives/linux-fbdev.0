From: Otto Solares <solca@guug.org>
Subject: radeonfb problem in test8-mm1
Date: Wed, 22 Oct 2003 08:54:29 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031022145429.GA12481@guug.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ACKfj-0002Z4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 22 Oct 2003 08:13:15 -0700
Received: from guug.galileo.edu ([168.234.203.30])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1ACKRu-0006BG-UV
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Oct 2003 07:58:59 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

The situation:

I have a radeon 9200 (RV280 RADEON_Ya).
I easily added support for it to kernels test8 and test8-mm1.
test8 kernel have old radeonfb driver.
test8-mm1 kernel has benh's new radeonfb driver (or some strange derivative).

The problem:

test8 works nicely in all resolutions including 640x480-60 and 1024x768-75.
test8-mm1 only works at 640x480-60, anything else is black or distorted.

The evidence:

As the attached files can attest, both kernels have exactly the same timings
for a given resolution but different debug printk's.  test8-mm1 has text accel
enabled and test8 disabled.  Forcing test8-mm1 to accel disable does not make
any difference.  AFAICS the only difference are the debug printk's which i
can't remotely interpret.

The beg for help:

Can somebody look at the attached files and deduce what is going wrong?
Or point me to a better source of debugging info.

-solca


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg-test8

radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=12, xclk=16600 from BIOS
radeonfb: probed DDR SGRAM 262144k videoram
radeon_get_moninfo: bios 4 scratch = 2000002
radeonfb: ATI Radeon 9200 Ya DDR SGRAM 256 MB
radeonfb: DVI port no monitor connected
radeonfb: CRT port CRT monitor connected
radeonfb_pci_register END

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg-test8-mm1

radeonfb_pci_register BEGIN
radeonfb: probed DDR SGRAM 262144k videoram
radeonfb: ref_clk=20000, ref_div=12, xclk=16600 from BIOS
Starting monitor auto detection...
radeonfb: Monitor 1 type CRT found
radeonfb: Monitor 2 type no found
radeonfb: ATI Radeon Ya 9200 RV280 DDR SGRAM 256 MB
radeonfb_pci_register END

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-640x480-60.test8"

hStart = 656, hEnd = 752, hTotal = 800
vStart = 490, vEnd = 492, vTotal = 525
h_total_disp = 0x4f0063	   hsync_strt_wid = 0x8c029a
v_total_disp = 0x1df020c	   vsync_strt_wid = 0x8201e9
post div = 0x8
fb_div = 0x59
ppll_div_3 = 0x30059
ron = 1096, roff = 23772
vclk_freq = 2503, per = 849

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-640x480-60.test8-mm1"

hStart = 656, hEnd = 752, hTotal = 800
vStart = 490, vEnd = 492, vTotal = 525
h_total_disp = 0x4f0063	   hsync_strt_wid = 0x8c029a
v_total_disp = 0x1df020c	   vsync_strt_wid = 0x8201e9
pixclock = 39722
freq = 2517
post div = 0x0
fb_div = 0x12
ppll_div_3 = 0x12

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-1024x768-75.test8"

hStart = 1040, hEnd = 1136, hTotal = 1312
vStart = 769, vEnd = 772, vTotal = 800
h_total_disp = 0x7f00a3	   hsync_strt_wid = 0xc041a
v_total_disp = 0x2ff031f	   vsync_strt_wid = 0x30300
post div = 0x4
fb_div = 0x8c
ppll_div_3 = 0x2008c
ron = 1040, roff = 15120
vclk_freq = 7875, per = 540

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-1024x768-75.test8-mm1"

hStart = 1040, hEnd = 1136, hTotal = 1312
vStart = 769, vEnd = 772, vTotal = 800
h_total_disp = 0x7f00a3	   hsync_strt_wid = 0xc041a
v_total_disp = 0x2ff031f	   vsync_strt_wid = 0x30300
pixclock = 12699
freq = 7874
post div = 0x0
fb_div = 0x39
ppll_div_3 = 0x39

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fbset-640x480-60.test8"


mode "640x480-60"
    # D: 25.175 MHz, H: 31.469 kHz, V: 59.940 Hz
    geometry 640 480 640 480 8
    timings 39722 48 16 33 10 96 2
    rgba 8/0,8/0,8/0,0/0
endmode


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fbset-640x480-60.test8-mm1"


mode "640x480-60"
    # D: 25.175 MHz, H: 31.469 kHz, V: 59.940 Hz
    geometry 640 480 640 480 8
    timings 39722 48 16 33 10 96 2
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fbset-1024x768-75.test8"


mode "1024x768-75"
    # D: 78.746 MHz, H: 60.020 kHz, V: 75.025 Hz
    geometry 1024 768 1024 768 8
    timings 12699 176 16 28 1 96 3
    hsync high
    vsync high
    rgba 8/0,8/0,8/0,0/0
endmode


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fbset-1024x768-75.test8-mm1"


mode "1024x768-75"
    # D: 78.746 MHz, H: 60.020 kHz, V: 75.025 Hz
    geometry 1024 768 1024 768 8
    timings 12699 176 16 28 1 96 3
    hsync high
    vsync high
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode


--envbJBWh7q8WU6mo--


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
