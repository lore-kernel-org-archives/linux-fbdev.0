From: Stefan Krah <sfk1@bigfoot.com>
Subject: Matrox G550, matroxfb: "Signal out of range"
Date: Wed, 29 Jan 2003 14:42:27 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030129134227.GA201@irkutsk.ip503cbb7c.speed.planet.nl>
Reply-To: Stefan Krah <stefankrah@bigfoot.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from ip503cbb7c.speed.planet.nl ([80.60.187.124])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18dsTQ-0001x8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 Jan 2003 05:41:52 -0800
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

Hello,

I am having a problem with the matroxfb driver which I couldn't solve
by asking Google or reading the docs. I hope it is not too off-topic
here.


The problem:

At bootup my monitor displays a warning sign saying:

       Signal out of range
       125.8 kHz    173Hz

The warning sign is distorted (stretched vertically) and disappears
after 4 seconds. From that moment on the framebuffer works normally
and with the very frequencies I specified in /etc/lilo.conf.
So (from my limited point of view) it seems that the driver disregards
those maximum frequencies for 4 seconds. Or that I have forgotten to
set some vital parameter.


The hardware:

Asus TUSL2-C (i815EP, AGP 4X)
Matrox G550 (with the latest bios)
Monitor CTX VL500 (30-70kHz, 50-120Hz)


Reproduced on:

SuSE 7.3, Debian Woody, LinuxFromScratch 4.0; kernels 2.4.20, 2.4.18


My .config:

[cut]
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_G450=y
# CONFIG_FB_MATROX_MULTIHEAD is not set
[cut]


My lilo.conf:

boot    = /dev/hda
vga     = 788
read-only
menu-scheme = Wg:kw:Wg:Wg
lba32
prompt
timeout = 80
message = /boot/message

  image  = /boot/2.4.20-suse-fb
  label  = SuSE
  root   = /dev/hda11
  append = "video=matrox:vesa:788,fh:69,fv:90"

  image  = /boot/2.4.20-lfs
  label  = lfs-4.0
  root   = /dev/hda6
  append = "video=matrox:vesa:0x114,fh:69,fv:90"
[cut]



I have tried other parameters:

video=matrox:vesa:0x114  -->  same problem

video=matrox:vesa:0x114,fh:50,fv:70  -->  same problem

video=matrox:nopan   -->  same problem, but warning sign is *not* distorted
                          and videomode is different

video=matrox:vesa:0x114,maxclk:16025   --> monitor stays black



I have also tried leaving out the vga = 788, then I get the following:

  - initial boot messages are displayed in the large default console font.

  - when the matroxfb kicks in we have the same story: warning sign for
    4 seconds, after that the framebuffer works impeccably, rest of boot
    messages are displayed in framebuffer font.


I'd be grateful for a hint or two.

Regards,

Stefan Krah


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
