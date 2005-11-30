From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: scroll modes
Date: Wed, 30 Nov 2005 18:32:01 +0100
Message-ID: <438DE211.2060900@t-online.de>
References: <438D9E60.7040007@t-online.de> <Pine.LNX.4.62.0511301347230.2123@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhWZb-0002rI-Qz
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Nov 2005 10:20:55 -0800
Received: from mailout01.sul.t-online.com ([194.25.134.80])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhWZY-0005oa-UI
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Nov 2005 10:20:55 -0800
In-Reply-To: <Pine.LNX.4.62.0511301347230.2123@pademelon.sonytel.be>
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
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>

Geert Uytterhoeven wrote:

>Ywrap has been working fine with amifb since ages (unless someone broke it very
>recently).
>
>  
>
We are talking about scrollmode = SCROLL_WRAP_MOVE ?
I put printk()s in the imageblit(), copyarea() and pan_display() 
functions of
cyblafb and in updatescrollmode() of fbcon.c. A "cat somefile" after loading
cyblafb produces the following log, you can see that the vyres == 2048 
and that
the maximum yoffset passed to pan_display() is 2048-768==1280. To call
that mode SCROLL_WRAP_SOMETHING the maximum yoffset should be
2048-16==2032. In reality it seems to be some kind of SCROLL_BROKEN_PAN ;-)


[43673.343266] cyblafb: CyblaFB version 0.56 initializing
[43673.345864] cyblafb: Pixmap size = 8188, alignement = 1
[43673.348147] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 
11 (level, low) -> IRQ 11
[43673.351810] cyblafb: region 0x3c0/0x20 already reserved
[43673.353941] cyblafb: framebuffer size = 8192 Kb
[43673.356006] cyblafb: region 0xe1800000/0x800000 already reserved
[43673.358274] cyblafb: detected startup mode: fbset -g 1024 768 1024 
??? 32 -t 15389 160 24 29 3 136 6
[43673.366685] cyblafb: Switching to new mode: fbset -g 1024 768 1024 
2048 32 -t 15389 160 24 29 3 136 6
[43673.368795] cyblafb: pixclock = 129.96 MHz, k/m/n 0 b 6e
[43673.368858] Scrollmode = SCROLL_WRAP_MOVE

[...]

[43674.319558] cyblafb: panning to xoffset 0, yoffset 1200
[43674.319836] cyblafb: blit to 0 / 1952, w/h 1024 / 16
[43674.319997] cyblafb: panning to xoffset 0, yoffset 1216
[43674.320260] cyblafb: blit to 0 / 1968, w/h 1024 / 16
[43674.320423] cyblafb: panning to xoffset 0, yoffset 1232
[43674.320710] cyblafb: blit to 0 / 1984, w/h 1024 / 16
[43674.320881] cyblafb: panning to xoffset 0, yoffset 1248
[43674.321147] cyblafb: blit to 0 / 2000, w/h 1024 / 16
[43674.321307] cyblafb: panning to xoffset 0, yoffset 1264
[43674.321582] cyblafb: blit to 0 / 2016, w/h 1024 / 16
[43674.321769] cyblafb: panning to xoffset 0, yoffset 1280
[43674.322050] cyblafb: blit to 0 / 2032, w/h 1024 / 16
[43674.322471] cyblafb: blit to 0 / 0, w/h 1024 / 16
[43674.322902] cyblafb: blit to 0 / 16, w/h 1024 / 16
[43674.344359] cyblafb: blit to 8 / 32, w/h 1016 / 16
[43674.346218] cyblafb: blit to 0 / 48, w/h 1024 / 16
[43674.348017] cyblafb: blit to 0 / 64, w/h 1024 / 16
[43674.349780] cyblafb: blit to 0 / 80, w/h 1024 / 16
[43674.351794] cyblafb: blit to 0 / 96, w/h 1024 / 16
[43674.353558] cyblafb: blit to 0 / 112, w/h 1024 / 16

[...]

[43674.647018] cyblafb: blit to 0 / 1984, w/h 1024 / 16
[43674.647184] cyblafb: panning to xoffset 0, yoffset 1248
[43674.647472] cyblafb: blit to 0 / 2000, w/h 1024 / 16
[43674.647646] cyblafb: panning to xoffset 0, yoffset 1264
[43674.647918] cyblafb: blit to 0 / 2016, w/h 1024 / 16
[43674.648085] cyblafb: panning to xoffset 0, yoffset 1280
[43674.648351] cyblafb: blit to 0 / 2032, w/h 1024 / 16
[43674.648767] cyblafb: blit to 0 / 0, w/h 1024 / 16
[43674.649068] cyblafb: blit to 0 / 16, w/h 16 / 16
[43674.668394] cyblafb: blit to 16 / 16, w/h 1008 / 16
[43674.670569] cyblafb: blit to 0 / 32, w/h 1024 / 16
[43674.672304] cyblafb: blit to 0 / 48, w/h 1024 / 16

cu,
 knut


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
