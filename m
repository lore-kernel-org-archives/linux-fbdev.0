From: Olaf Hering <olh@suse.de>
Subject: [PATCH] add modeline for 1680x1050@60
Date: Mon, 13 Mar 2006 13:35:03 +0100
Message-ID: <20060313123502.GA5996@suse.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FImGV-0006RG-EJ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Mar 2006 04:35:11 -0800
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FImGU-0005eq-O7
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Mar 2006 04:35:11 -0800
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
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net


Add a modeline for the Philips 200W display. 
aty128fb does not do DDC, it picks 1920x1440 or similar.
It works ok with nvidiafb because it can ask for DDC data.

mode "1680x1050-60"
    # D: 146.028 MHz, H: 65.191 kHz, V: 59.863 Hz
    geometry 1680 1050 1680 1050 16
    timings 6848 280 104 30 3 176 6
    hsync high
    vsync high
    rgba 5/11,6/5,5/0,0/0
endmode


 hwinfo --monitor
20: None 00.0: 10000 Monitor                                    
  [Created at monitor.206]
  Unique ID: rdCR.pzUFTofo1S4
  Parent ID: 002j.bJRsY88eNSC
  Hardware Class: monitor
  Model: "PHILIPS Philips 200W"
  Vendor: PHL "PHILIPS"
  Device: eisa 0x0832 "Philips 200W"
  Serial ID: "VN  016596"
  Resolution: 720x400@70Hz
  Resolution: 640x480@60Hz
  Resolution: 640x480@67Hz
  Resolution: 640x480@72Hz
  Resolution: 640x480@75Hz
  Resolution: 800x600@56Hz
  Resolution: 800x600@60Hz
  Resolution: 800x600@72Hz
  Resolution: 800x600@75Hz
  Resolution: 832x624@75Hz
  Resolution: 1024x768@60Hz
  Resolution: 1024x768@70Hz
  Resolution: 1024x768@75Hz
  Resolution: 1280x1024@75Hz
  Resolution: 1152x864@70Hz
  Resolution: 1152x864@75Hz
  Resolution: 1280x960@60Hz
  Resolution: 1280x1024@60Hz
  Resolution: 1680x1050@60Hz
  Size: 433x271 mm
  Driver Info #0:
    Max. Resolution: 1680x1050
    Vert. Sync Range: 56-85 Hz
    Hor. Sync Range: 30-93 kHz
  Config Status: cfg=new, avail=yes, need=no, active=unknown
  Attached to: #5 (VGA compatible controller)

Signed-off-by: Olaf Hering <olh@suse.de>
---
 drivers/video/modedb.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6.16-rc6-olh/drivers/video/modedb.c
===================================================================
--- linux-2.6.16-rc6-olh.orig/drivers/video/modedb.c
+++ linux-2.6.16-rc6-olh/drivers/video/modedb.c
@@ -183,6 +183,10 @@ static const struct fb_videomode modedb[
 	NULL, 75, 1600, 1200, 4938, 304, 64, 46, 1, 192, 3,
 	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
     }, {
+	/* 1680x1050 @ 60 Hz, 65.191 kHz hsync */
+	NULL, 60, 1680, 1050, 6848, 280, 104, 30, 3, 176, 6,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    }, {
 	/* 1600x1200 @ 85 Hz, 105.77 kHz hsync */
 	NULL, 85, 1600, 1200, 4545, 272, 16, 37, 4, 192, 3,
 	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
