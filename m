From: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Subject: Re: Framebuffer console not working with matroxfb on 2.6
Date: Fri, 17 Sep 2004 10:51:31 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040917085131.GQ18257@uvt316-2.ruk.cuni.cz>
References: <3B9599C3EB4@vcnet.vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8EV7-0000sI-P8
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Sep 2004 01:53:53 -0700
Received: from dec59.ruk.cuni.cz ([195.113.2.17])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C8EV6-0007s1-QZ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Sep 2004 01:53:53 -0700
Content-Disposition: inline
In-Reply-To: <3B9599C3EB4@vcnet.vc.cvut.cz>
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
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

> It is not matroxfb's bug, it is how fbcon works in 2.6.x, it uses
> only drivers which existed at a time fbcon was loaded...  Usually
> people find it by trial & error, or they ask...
> 
> You can also grab 
> http://platan.vc.cvut.cz/ftp/pub/linux/matrox-latest/matroxfb-2.6.9-rc2.gz,
> with it you should be able to use modular matroxfb.

It does not apply to my (2.6.8.1) kernel. But since it works when
compiled into kernel I can wait until it appears in the kernel.org
kernel or a new patch is available.

However, I still get a minor problem with the driver.
When I switch between the default 640x480-60 mode and 1024x768-85 mode
the 1024x768 gets interlaced, with completely different timings. I have
to use fbset to restore it to 1024x768-85.

Thanks

Michal Suchanek

--- fb.modes
# "1024x768"     94.50   1024 1072 1168 1376    768  769  772  808 +hsync +vsync
mode "1024x768-85"
  geometry 1024 768 1024 768 8
  timings 10582  208 48  36 1  96 3
    accel true
    laced false
    vsync high
    hsync high
endmode

mode "640x480-60"
    # D: 25.176 MHz, H: 31.469 kHz, V: 59.942 Hz
    geometry 640 480 640 26214 8
    # left right upper lower hslen vslen
    timings 39721 40 24 32 11 96 2
    accel true
    #rgba 8/0,8/0,8/0,0/0
endmode

--- partial .config

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
# CONFIG_FB_MATROX_G450 is not set
CONFIG_FB_MATROX_G100A=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
# CONFIG_FB_MATROX_MULTIHEAD is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
