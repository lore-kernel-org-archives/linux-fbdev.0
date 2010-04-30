From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 30 Apr 2010 21:39:46 +0000
Subject: [RFC] Second OLPC Viafb series, v2.1
Message-Id: <1272663589-4950-1-git-send-email-corbet@lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Here's a small update to the second posting of the second OLPC viafb
series.  It contains three new patches, all fixing issues pointed out by
Bruno Pr=C3=A9mont.  I'm not going to spam everybody with the whole set aga=
in;
it can be pulled from:

	git://git.lwn.net/linux-2.6.git viafb-posted

Only the new patches will appear here.

The review so far is much appreciated - any other comments?  Is there
anything arguing against moving everything (except the camera driver) into
viafb-next, from which it will flow into linux-next?

As a reminder, here's what's in the full series:

Chris Ball (1):
      viafb: Add 1200x900 DCON/LCD panel modes for OLPC XO-1.5

Florian Tobias Schandinat (7):
      viafb: package often used basic io functions
      viafb: unify modesetting functions
      viafb: move some modesetting functions to a seperate file
      viafb: replace inb/outb
      viafb: improve misc register handling
      viafb: fix proc entry removal
      viafb: make procfs entries optional

Harald Welte (4):
      viafb: Fix various resource leaks during module_init()
      viafb: use proper pci config API
      viafb: Determine type of 2D engine and store it in chip_info
      viafb: rework the I2C support in the VIA framebuffer driver

Jonathan Corbet (20):
      viafb: Unmap the frame buffer on initialization error
      viafb: Retain GEMODE reserved bits
      viafb: Unify duplicated set_bpp() code
      viafb: complete support for VX800/VX855 accelerated framebuffer
      viafb: Only establish i2c busses on ports that always had them
      viafb: Move core stuff into via-core.c
      viafb: Separate global and fb-specific data
      viafb: add a driver for GPIO lines
      viafb: Convert GPIO and i2c to the new indexed port ops
      viafb: Turn GPIO and i2c into proper platform devices
      via: Do not attempt I/O on inactive I2C adapters
      viafb: Introduce viafb_find_i2c_adapter()
      via: Rationalize vt1636 detection
      viafb: Add a simple interrupt management infrastructure
      viafb: Add a simple VX855 DMA engine driver
      viafb: Reserve framebuffer memory for the upcoming camera driver
      viafb: Add a driver for the video capture engine
      viafb: Do not remove gpiochip under spinlock
      viafb: Fix initialization error paths
      viafb: Don't build in camera-specific code without the camera

Paul Fox (1):
      suppress verbose debug messages: change printk() to DEBUG_MSG()

Thanks,

jon


