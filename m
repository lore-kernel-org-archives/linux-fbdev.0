From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: Kernel warning from Matrox Framebuffer in 2.6.20.1
Date: Sat, 24 Feb 2007 18:18:24 +0100
Message-ID: <200702241818.24675.linux@rainbow-software.org>
References: <306590.53720.qm@web52912.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752281AbXBXRXg@vger.kernel.org>
In-Reply-To: <306590.53720.qm@web52912.mail.yahoo.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Chris Rankin <rankincj@yahoo.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Saturday 24 February 2007 14:08, Chris Rankin wrote:
> Hi,
>
> I have just booted 2.6.20.1 on my Pentium 3 machine, which has a G400 MAX
> graphics card. This machine uses the Matrox framebuffer and TV-OUT modules,
> and I have found these warnings in the kernel log:
>
> **WARNING** I2C adapter driver [DDC:fb0 #0] forgot to specify physical
> device; fix it! **WARNING** I2C adapter driver [DDC:fb0 #1] forgot to
> specify physical device; fix it! **WARNING** I2C adapter driver [MAVEN:fb0]
> forgot to specify physical device; fix it!

I'm seeing something like that since installing 2.6.20.1 yesterday:

matroxfb: Matrox Mystique (PCI) detected
PInS memtype = 0
matroxfb: MTRR's turned on
matroxfb: 1024x768x8bpp (virtual: 1024x4096)
matroxfb: framebuffer at 0xE1000000, mapped to 0xcc880000, size 4194304
Console: switching to colour frame buffer device 128x48
fb0: MATROX frame buffer device
**WARNING** I2C adapter driver [DDC:fb0 #0] forgot to specify physical device; 
fix it!

> The relevant kernel modules seem to be:
>
> matroxfb_maven         13228  0
> i2c_matroxfb            4064  0
> i2c_algo_bit            6312  1 i2c_matroxfb
>
> Cheers,
> Chris

-- 
Ondrej Zary
