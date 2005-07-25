From: Terence Soh <Terence.Soh@appliedbiosystems.com>
Subject: General frame buffer questions (for NS9360)
Date: Tue, 26 Jul 2005 06:31:57 +0800
Message-ID: <OF6FF3BF3E.E5A02E1C-ON48257049.007AC48D-48257049.007BD32D@applera.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=_alternative 007BD32C48257049_="
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxBOx-0005Kx-QQ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Jul 2005 15:26:23 -0700
Received: from prd051.appliedbiosystems.com ([206.139.64.39])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1DxBOx-0000Tq-II
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Jul 2005 15:26:23 -0700
Received: from usfosmta01.pe-c.com (usfosmta01.pe-c.com [167.116.108.7])
	by prd051.appliedbiosystems.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id j6PMQtgf020382
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Jul 2005 15:26:55 -0700 (PDT)
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
To: linux-fbdev-devel@lists.sourceforge.net

This is a multipart message in MIME format.
--=_alternative 007BD32C48257049_=
Content-Type: text/plain; charset="US-ASCII"

Hi,
 
I am modifying FSForth GPL fb driver for 8-bit STN displays and ran into 
segmentation fault running arm konqueror embedded. The strace records are 

shmget(1829502980, 32768, IPC_CREAT|0600) = 0
shmat(0, 0, 0)                          = 0x407d9000
brk(0)                                  = 0x2fe000
brk(0x2ff000)                           = 0x2ff000
open("/dev/fb0", O_RDWR)                = 4
ioctl(4, FBIOGET_FSCREENINFO, 0xbefff9a0) = 0
ioctl(4, FBIOGET_VSCREENINFO, 0xbefff900) = 0
old_mmap(NULL, 76800, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) = 0x407e1000
ioctl(4, FBIOGETCMAP, 0x2fe270)         = -1 EINVAL (Invalid argument)
open("/dev/console", O_WRONLY)          = 5
write(5, "\33[9;0]\33[?33l\33[?25l\0", 19) = 19
close(5)                                = 0
open("/dev/tty", O_WRONLY)              = -1 ENXIO (No such device or 
address)
open("/dev/tty0", O_WRONLY)             = 5
write(5, "\33[9;0]\33[?33l\33[?25l\0", 19) = 19
close(5)                                = 0
ioctl(4, FBIOGET_VSCREENINFO, 0xbefff97c) = 0
ioctl(4, FBIOGET_FSCREENINFO, 0xbefff938) = 0
brk(0)                                  = 0x2ff000
brk(0x300000)                           = 0x300000
ioctl(4, FBIOPUTCMAP, 0xbefff920)       = 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++

My configuration is
info.fb.var.bit_per_pixel = 8
info.fb.var.red.offset = 0
info.fb.var.green.offset = 0
info.fb.var.blue.offset = 0
info.fb.var.red.length = 8
info.fb.var.green.length = 8
info.fb.var.blue.length = 8

I am assuming that the FBIOPUTCMAP ioctl is causing the sigsegv. I am also 
assuming that ioctl(4, FBIOPUTCMAP, 0xbefff920) would be serviced by 
.fb_ioctl callback but I am not getting the printk(s) in my .fb_ioctl 
callback on the console. What am I getting wrong?

Thanks in advance,
Terence.
--=_alternative 007BD32C48257049_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi,</font>
<br><font size=2 face="sans-serif">&nbsp;</font>
<br><font size=2 face="sans-serif">I am modifying FSForth GPL fb driver
for 8-bit STN displays and ran into segmentation fault running arm konqueror
embedded. The strace records are </font>
<br>
<br><font size=2 face="sans-serif">shmget(1829502980, 32768, IPC_CREAT|0600)
= 0</font>
<br><font size=2 face="sans-serif">shmat(0, 0, 0) &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
0x407d9000</font>
<br><font size=2 face="sans-serif">brk(0) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;= 0x2fe000</font>
<br><font size=2 face="sans-serif">brk(0x2ff000) &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; = 0x2ff000</font>
<br><font size=2 face="sans-serif">open(&quot;/dev/fb0&quot;, O_RDWR) &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= 4</font>
<br><font size=2 face="sans-serif">ioctl(4, FBIOGET_FSCREENINFO, 0xbefff9a0)
= 0</font>
<br><font size=2 face="sans-serif">ioctl(4, FBIOGET_VSCREENINFO, 0xbefff900)
= 0</font>
<br><font size=2 face="sans-serif">old_mmap(NULL, 76800, PROT_READ|PROT_WRITE,
MAP_SHARED, 4, 0) = 0x407e1000</font>
<br><font size=2 face="sans-serif">ioctl(4, FBIOGETCMAP, 0x2fe270) &nbsp;
&nbsp; &nbsp; &nbsp; = -1 EINVAL (Invalid argument)</font>
<br><font size=2 face="sans-serif">open(&quot;/dev/console&quot;, O_WRONLY)
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= 5</font>
<br><font size=2 face="sans-serif">write(5, &quot;\33[9;0]\33[?33l\33[?25l\0&quot;,
19) = 19</font>
<br><font size=2 face="sans-serif">close(5) &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;= 0</font>
<br><font size=2 face="sans-serif">open(&quot;/dev/tty&quot;, O_WRONLY)
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= -1 ENXIO (No such device
or address)</font>
<br><font size=2 face="sans-serif">open(&quot;/dev/tty0&quot;, O_WRONLY)
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; = 5</font>
<br><font size=2 face="sans-serif">write(5, &quot;\33[9;0]\33[?33l\33[?25l\0&quot;,
19) = 19</font>
<br><font size=2 face="sans-serif">close(5) &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;= 0</font>
<br><font size=2 face="sans-serif">ioctl(4, FBIOGET_VSCREENINFO, 0xbefff97c)
= 0</font>
<br><font size=2 face="sans-serif">ioctl(4, FBIOGET_FSCREENINFO, 0xbefff938)
= 0</font>
<br><font size=2 face="sans-serif">brk(0) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;= 0x2ff000</font>
<br><font size=2 face="sans-serif">brk(0x300000) &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; = 0x300000</font>
<br><font size=2 face="sans-serif">ioctl(4, FBIOPUTCMAP, 0xbefff920) &nbsp;
&nbsp; &nbsp; = 0</font>
<br><font size=2 face="sans-serif">--- SIGSEGV (Segmentation fault) @ 0
(0) ---</font>
<br><font size=2 face="sans-serif">+++ killed by SIGSEGV +++</font>
<br>
<br><font size=2 face="sans-serif">My configuration is</font>
<br><font size=2 face="sans-serif">info.fb.var.bit_per_pixel = 8</font>
<br><font size=2 face="sans-serif">info.fb.var.red.offset = 0</font>
<br><font size=2 face="sans-serif">info.fb.var.green.offset = 0</font>
<br><font size=2 face="sans-serif">info.fb.var.blue.offset = 0</font>
<br><font size=2 face="sans-serif">info.fb.var.red.length = 8</font>
<br><font size=2 face="sans-serif">info.fb.var.green.length = 8</font>
<br><font size=2 face="sans-serif">info.fb.var.blue.length = 8</font>
<br>
<br><font size=2 face="sans-serif">I am assuming that the FBIOPUTCMAP ioctl
is causing the sigsegv. I am also assuming that ioctl(4, FBIOPUTCMAP, 0xbefff920)
would be serviced by .fb_ioctl callback but I am not getting the printk(s)
in my .fb_ioctl callback on the console. What am I getting wrong?</font>
<br>
<br><font size=2 face="sans-serif">Thanks in advance,</font>
<br><font size=2 face="sans-serif">Terence.</font>
--=_alternative 007BD32C48257049_=--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
