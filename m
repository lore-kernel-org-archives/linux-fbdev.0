From: Jurriaan <thunder7@xs4all.nl>
Subject: Re: status of rivafb versus Geforce FX cards?
Date: Wed, 9 Jun 2004 06:27:29 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040609042729.GA2904@middle.of.nowhere>
References: <20040604131147.GA2056@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BXuh4-0004YK-Da
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 08 Jun 2004 21:28:06 -0700
Received: from smtp-out6.xs4all.nl ([194.109.24.7])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BXuh3-0000bg-Rf
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 08 Jun 2004 21:28:06 -0700
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-out6.xs4all.nl (8.12.10/8.12.10) with ESMTP id i594S3ew061668
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 9 Jun 2004 06:28:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20040604131147.GA2056@middle.of.nowhere>
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
To: linux-fbdev-devel@lists.sourceforge.net

From: Jurriaan <thunder7@xs4all.nl>
Date: Fri, Jun 04, 2004 at 03:11:47PM +0200
> The current rivafb driver doesn't support anything after the Ti-4600
> cards, if I read it correctly.
> 
> Is this being worked on?
> 
Just to reply to myself:

Kernel command line: root=/dev/md3 video=rivafb softrepeat=1 mem=256M console=ttyS0
fbdev: probing for matroxfb
fbdev: probing for rivafb
fbdev: probing for radeonfb
rivafb: trying pci_register_driver()
rivafb: starting probe.
rivafb: getting architecture.
rivafb: device 0342, arch 48
rivafb: nVidia device/chipset 10DE0342
rivafb: nVidia Corporation NV 36 [GeForce 5700]
rivafb: NV_ARCH_30 support is experimental!
rivafb: RIVA MTRR set to ON
rivafb: PCI nVidia NV30 framebuffer ver 0.9.5b (128MB @ 0xE0000000)

With help from Mark Vojkovich, who pointed me to what exactly changed in
XFree86 to support the FX-5700, I'm now here. It boots without crashing.
Unfortunately, clock programming is off somewhere, this default mode,
which should look like

Opening frame buffer device `/dev/fb0'
Using current video mode from `/dev/fb0'

mode "640x480-60"
    # D: 25.176 MHz, H: 31.469 kHz, V: 59.942 Hz
    geometry 640 480 640 480 8
    timings 39721 40 24 32 11 96 2
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode

instead has

fh 201.8 kHz
fv   0.0 Hz

according to my Eizo monitor. So I'll have to compare rivafb and
XFree86's nv driver some more.

But progress is being made.

Jurriaan
-- 
If you take his intimations to heart, you will apprehend the sorry
consequences of ignoble curiosity. Such knowledge is beyond value.
	Jack Vance - The Gray Prince
Debian (Unstable) GNU/Linux 2.6.7-rc2-mm2 2x6078 bogomips load 0.00


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
