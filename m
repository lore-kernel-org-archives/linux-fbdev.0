From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] 0/3 Add I2C/DDC support to radeonfb (resend)
Date: Fri, 22 Aug 2003 19:09:05 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030822170905.GA5757@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail-1.tiscali.it ([195.130.225.147])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19qFPN-0005aU-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 22 Aug 2003 10:09:05 -0700
Received: from dreamland.darkstar.lan (217.133.180.117) by mail-1.tiscali.it (6.7.019)
        id 3F335F020056F396 for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Aug 2003 19:08:56 +0200
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

[This is a resend, it seems that original mail got lost]
In reply to this mail I'll send 3 patches that add i2c to radeonfb.

The first  patch adds a new  driver-id to the i2c-id.h,  a config option
and all the  i2c stuff to radeonfb.c. It doesn't change  te behaviour of
the driver.

The second patch registers the i2c bus, updates default var according to
EDID data and creates a modeb ouf of EDID.

i2c  bus  is registered  in  radeonfb_pci_register  and unregistered  in
radeonfb_pci_unregister. I'm a  bit concerned about XFree  that uses the
same bus...

I'm  having problems  with  this patch,  but  I think  that  the bug  is
elsewhere. If I don't  set any mode on lilo command  line the driver try
to use the default mode taken from  EDID. In my case the default mode is
1280x1024@60Hz.

This is 2.6.0-test3 + my patches:

radeonfb_pci_register END
hStart = 1328, hEnd = 1440, hTotal = 1688
vStart = 1025, vEnd = 1028, vTotal = 1066
h_total_disp = 0x9f00d2 hsync_strt_wid = 0xe0613
v_total_disp = 0x3ff0429 vsync_strt_wid = 0x30400
post div = 0x2
fb_div = 0x60
ppll_div_3 = 0x10060
ron = 11776, roff = 0
vclk_freq = 10800, per = 0
radeonfb: error ron out of range

...and the screen stays black.
DDA stuff has been disabled in 2.4 but it's still there in 2.6. However
even plain 2.6 is unable to set 1280x1024@60Hz:

hStart = 1296, hEnd = 1512, hTotal = 1568
vStart = 1025, vEnd = 1037, vTotal = 1165
h_total_disp = 0x9f00c3 hsync_strt_wid = 0x9b051a
v_total_disp = 0x3ff048c vsync_strt_wid = 0x8c0400
post div = 0x4
fb_div = 0x8e
ppll_div_3 = 0x2008e
ron = 1232, roff = 24220
vclk_freq = 7988, per = 865
Console: switching to colour frame buffer device 160x64

but  the  screen  stays  black. XFree  works with  no  problem  at  this
resolution.

Also, modes  from EDID  are a  bit different from  modes of  the default
modedb. This is 2.6.0 vanilla at 1024x768@60Hz:

hStart = 1032, hEnd = 1176, hTotal = 1344
vStart = 771, vEnd = 777, vTotal = 806
h_total_disp = 0x7f00a7 hsync_strt_wid = 0x920412
v_total_disp = 0x2ff0325 vsync_strt_wid = 0x860302
post div = 0x4
fb_div = 0x74
ppll_div_3 = 0x20074
ron = 712, roff = 14840
vclk_freq = 6525, per = 530

This is 2.6 + my patches, at 1024x768@60Hz, timings from EDID:

hStart = 1048, hEnd = 1184, hTotal = 1344
vStart = 771, vEnd = 777, vTotal = 806
h_total_disp = 0x7f00a7 hsync_strt_wid = 0x910422
v_total_disp = 0x2ff0325 vsync_strt_wid = 0x860302
post div = 0x4
fb_div = 0x74
ppll_div_3 = 0x20074
ron = 712, roff = 14840
vclk_freq = 6525, per = 530


The third patch attach a sysfb binary attribute to PCI device. EDID data
will show up in /sys/bus/pci/drivers/radeonfb/0000:01:00.0/edid.

This is a  kind of RFC, if  patches look good I'll  rediff against Ben's
tree.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"It is more complicated than you think"
                -- The Eighth Networking Truth from RFC 1925


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
