Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCC5C4332F
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Dec 2022 13:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLPNQY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 16 Dec 2022 08:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiLPNQX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 16 Dec 2022 08:16:23 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F742637
        for <linux-fbdev@vger.kernel.org>; Fri, 16 Dec 2022 05:16:20 -0800 (PST)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 36A1E61CCD7B0;
        Fri, 16 Dec 2022 14:16:19 +0100 (CET)
Message-ID: <7b85b832-e6fd-fe42-c6a1-93ebb591383c@molgen.mpg.de>
Date:   Fri, 16 Dec 2022 14:16:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Why is mgag200 not used over matroxfb? (was: matroxfb: cannot
 determine memory size)
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     "Z. Liu" <liuzx@knownsec.com>, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, it+linux-fbdev@molgen.mpg.de
References: <5da53ec5-3a9c-ec87-da20-69f140aaaa6b@molgen.mpg.de>
 <972999d3-b75d-5680-fcef-6e6905c52ac5@suse.de>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <972999d3-b75d-5680-fcef-6e6905c52ac5@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Dear Thomas,


Thank you for your reply.

Am 16.12.22 um 13:27 schrieb Thomas Zimmermann:

> Am 15.12.22 um 17:39 schrieb Paul Menzel:

[…]

>> Between Linux 5.10.103 and 5.10.110/5.15.77, matrixfb fails to load.
> 
> Off-topic, but related. matroxfb is obsolete and there's a maintained 
> DRM replacement (mgag200) for this hardware.

I also remembered something like this in the back of my head. Though I 
thought about using simpledrm (`DRM_SIMPLEDRM`), we do not build though.

> Is there anything missing from mgag200 that prevents you from switching?
No, it looks like the matroxfb modules take precedence over the mgag200 
module:

     $ grep -e FB_MATROX -e MGAG /boot/config-5.15.77.mx64.440
     CONFIG_DRM_MGAG200=m
     CONFIG_FB_MATROX=m
     CONFIG_FB_MATROX_MILLENIUM=y
     CONFIG_FB_MATROX_MYSTIQUE=y
     CONFIG_FB_MATROX_G=y
     CONFIG_FB_MATROX_I2C=m
     # CONFIG_FB_MATROX_MAVEN is not set

     $ lsmod | grep matrox
     matroxfb_base          28672  0
     matroxfb_g450          16384  1 matroxfb_base
     matroxfb_Ti3026        16384  1 matroxfb_base
     matroxfb_accel         16384  1 matroxfb_base
     matroxfb_DAC1064       20480  1 matroxfb_base
     g450_pll               16384  2 matroxfb_g450,matroxfb_DAC1064
     matroxfb_misc          20480  5 
g450_pll,matroxfb_Ti3026,matroxfb_base,matroxfb_g450,matroxfb_DAC1064


Kind regards,

Paul


PS: Output of `modinfo`:

```
$ modinfo matroxfb_base
filename: 
/lib/modules/5.15.77.mx64.440/kernel/drivers/video/fbdev/matrox/matroxfb_base.ko
license:        GPL
description:    Accelerated FBDev driver for Matrox 
Millennium/Mystique/G100/G200/G400/G450/G550
author:         (c) 1998-2002 Petr Vandrovec <vandrove@vc.cvut.cz>
alias:          pci:v0000102Bd00002527sv*sd*bc*sc*i*
alias:          pci:v0000102Bd00000525sv*sd*bc*sc*i*
alias:          pci:v0000102Bd00000521sv*sd*bc*sc*i*
alias:          pci:v0000102Bd00000532sv*sd*bc*sc*i*
alias:          pci:v0000102Bd00000520sv*sd*bc*sc*i*
alias:          pci:v0000102Bd00001001sv*sd*bc*sc*i*
alias:          pci:v0000102Bd00001000sv*sd*bc*sc*i*
alias:          pci:v0000102Bd0000051Asv*sd*bc*sc*i*
alias:          pci:v0000102Bd0000051Fsv*sd*bc*sc*i*
alias:          pci:v0000102Bd0000051Bsv*sd*bc*sc*i*
alias:          pci:v0000102Bd00000519sv*sd*bc*sc*i*
depends: 
matroxfb_g450,matroxfb_misc,matroxfb_DAC1064,matroxfb_Ti3026,matroxfb_accel
retpoline:      Y
intree:         Y
name:           matroxfb_base
vermagic:       5.15.77.mx64.440 SMP mod_unload modversions
parm:           mem:Size of available memory in MB, KB or B 
(2,4,8,12,16MB, default=autodetect) (int)
parm:           disabled:Disabled (0 or 1=disabled) (default=0) (int)
parm:           noaccel:Do not use accelerating engine (0 or 1=disabled) 
(default=0) (int)
parm:           nopan:Disable pan on startup (0 or 1=disabled) 
(default=0) (int)
parm:           no_pci_retry:PCI retries enabled (0 or 1=disabled) 
(default=0) (int)
parm:           novga:VGA I/O (0x3C0-0x3DF) disabled (0 or 1=disabled) 
(default=0) (int)
parm:           nobios:Disables ROM BIOS (0 or 1=disabled) (default=do 
not change BIOS state) (int)
parm:           noinit:Disables W/SG/SD-RAM and bus interface 
initialization (0 or 1=do not initialize) (default=0) (int)
parm:           memtype:Memory type for G200/G400 (see 
Documentation/fb/matroxfb.rst for explanation) (default=3 for G200, 0 
for G400) (int)
parm:           mtrr:This speeds up video memory accesses (0=disabled or 
1) (default=1) (int)
parm:           sgram:Indicates that G100/G200/G400 has SGRAM memory 
(0=SDRAM, 1=SGRAM) (default=0) (int)
parm:           inv24:Inverts clock polarity for 24bpp and loop 
frequency > 100MHz (default=do not invert polarity) (int)
parm:           inverse:Inverse (0 or 1) (default=0) (int)
parm:           dev:Multihead support, attach to device ID (0..N) 
(default=all working) (int)
parm:           vesa:Startup videomode (0x000-0x1FF) (default=0x101) (int)
parm:           xres:Horizontal resolution (px), overrides xres from 
vesa (default=vesa) (int)
parm:           yres:Vertical resolution (scans), overrides yres from 
vesa (default=vesa) (int)
parm:           upper:Upper blank space (scans), overrides upper from 
vesa (default=vesa) (int)
parm:           lower:Lower blank space (scans), overrides lower from 
vesa (default=vesa) (int)
parm:           vslen:Vertical sync length (scans), overrides lower from 
vesa (default=vesa) (int)
parm:           left:Left blank space (px), overrides left from vesa 
(default=vesa) (int)
parm:           right:Right blank space (px), overrides right from vesa 
(default=vesa) (int)
parm:           hslen:Horizontal sync length (px), overrides hslen from 
vesa (default=vesa) (int)
parm:           pixclock:Pixelclock (ns), overrides pixclock from vesa 
(default=vesa) (int)
parm:           sync:Sync polarity, overrides sync from vesa 
(default=vesa) (int)
parm:           depth:Color depth (0=text,8,15,16,24,32) (default=vesa) 
(int)
parm:           maxclk:Startup maximal clock, 0-999MHz, 1000-999999kHz, 
1000000-INF Hz (int)
parm:           fh:Startup horizontal frequency, 0-999kHz, 1000-INF Hz (int)
parm:           fv:Startup vertical frequency, 0-INF Hz
You should specify 
"fv:max_monitor_vsync,fh:max_monitor_hsync,maxclk:max_monitor_dotclock" 
(int)
parm:           grayscale:Sets display into grayscale. Works perfectly 
with paletized videomode (4, 8bpp), some limitations apply to 16, 24 and 
32bpp videomodes (default=nograyscale) (int)
parm:           cross4MB:Specifies that 4MB boundary can be in middle of 
line. (default=autodetected) (int)
parm:           dfp:Specifies whether to use digital flat panel 
interface of G200/G400 (0 or 1) (default=0) (int)
parm:           dfp_type:Specifies DFP interface type (0 to 255) 
(default=read from hardware) (int)
parm:           outputs:Specifies which CRTC is mapped to which output 
(string of up to three letters, consisting of 0 (disabled), 1 (CRTC1), 2 
(CRTC2)) (default=111 for Gx50, 101 for G200/G400 with DFP, and 100 for 
all other devices) (string)
```

```
$ modinfo mgag200
filename: 
/lib/modules/5.15.77.mx64.440/kernel/drivers/gpu/drm/mgag200/mgag200.ko
license:        GPL
description:    MGA G200 SE
author:         Matthew Garrett
alias:          pci:v0000102Bd00000538sv*sd*bc*sc*i*
alias:          pci:v0000102Bd00000536sv*sd*bc*sc*i*
alias:          pci:v0000102Bd00000534sv*sd*bc*sc*i*
alias:          pci:v0000102Bd00000533sv*sd*bc*sc*i*
alias:          pci:v0000102Bd00000532sv*sd*bc*sc*i*
alias:          pci:v0000102Bd00000530sv*sd*bc*sc*i*
alias:          pci:v0000102Bd00000524sv*sd*bc*sc*i*
alias:          pci:v0000102Bd00000522sv*sd*bc*sc*i*
alias:          pci:v0000102Bd00000521sv*sd*bc*sc*i*
alias:          pci:v0000102Bd00000520sv*sd*bc*sc*i*
depends:        drm,drm_kms_helper,i2c-algo-bit
retpoline:      Y
intree:         Y
name:           mgag200
vermagic:       5.15.77.mx64.440 SMP mod_unload modversions
parm:           modeset:Disable/Enable modesetting (int)
```
