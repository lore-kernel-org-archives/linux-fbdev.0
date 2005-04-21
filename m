From: Miles Lane <miles.lane@gmail.com>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives black screen
Date: Thu, 21 Apr 2005 01:51:12 -0400
Message-ID: <a44ae5cd05042022512e840cfa@mail.gmail.com>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com>
	 <200504141351.42971.adaplas@hotpop.com>
	 <20050414191323.10d7d435.khali@linux-fr.org>
	 <200504151107.49810.adaplas@hotpop.com>
	 <a44ae5cd05041601211c292316@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DOUbv-0000kW-UI
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 20 Apr 2005 22:52:23 -0700
Received: from wproxy.gmail.com ([64.233.184.207])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DOUbv-0007X5-Ia
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 20 Apr 2005 22:52:23 -0700
Received: by wproxy.gmail.com with SMTP id 57so537545wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 20 Apr 2005 22:52:17 -0700 (PDT)
In-Reply-To: <a44ae5cd05041601211c292316@mail.gmail.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>

Your patches seem to have fixed the Oops with I2C, but=20
nvidiafb is not working unless I specify more than vmalloc=3D128M
in the append options.  That is, the default kernel options
do not provide for a working nvidiafb display.

Here's what I get when testing 2.6.12-rc2-mm3
(I verified that your two patches have been applied in my
tree):

Kernel command line: BOOT_IMAGE=3DLinux ro root=3D306
video=3Dnvidiafb:1280x1024-16@85 vmalloc=3D
128M init=3D/etc/init lang=3Dus apm=3Dpower-off nomce

nvidiafb: nVidia device/chipset 10DE0312
nvidiafb: nVidia Corporation NV31 [GeForce FX 5600]
i2c_adapter i2c-0: registered as adapter #0
i2c_adapter i2c-1: registered as adapter #1
i2c_adapter i2c-2: registered as adapter #2
nvidiafb: CRTC0 found
nvidiafb: CRTC1 not found
i2c_adapter i2c-0: master_xfer[0] W, addr=3D0x50, len=3D1
i2c_adapter i2c-0: master_xfer[1] R, addr=3D0x50, len=3D128
nvidiafb: EDID found from BUS1
i2c_adapter i2c-1: master_xfer[0] W, addr=3D0x50, len=3D1
i2c_adapter i2c-1: master_xfer[1] R, addr=3D0x50, len=3D128
i2c_adapter i2c-1: master_xfer[0] W, addr=3D0x50, len=3D1
i2c_adapter i2c-1: master_xfer[1] R, addr=3D0x50, len=3D128
i2c_adapter i2c-1: master_xfer[0] W, addr=3D0x50, len=3D1
i2c_adapter i2c-1: master_xfer[1] R, addr=3D0x50, len=3D128
nvidiafb: CRTC 0 appears to have a CRT attached
nvidiafb: Using CRT on CRTC 0
allocation failed: out of vmalloc space - use vmalloc=3D<size> to increase =
size.
nvidiafb: cannot ioremap FB base

When I boot, the screen stays black until XFree86 starts up.


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
