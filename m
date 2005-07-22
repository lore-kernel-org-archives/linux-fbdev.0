From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: ghosting with nvidia framebuffer (pci-e 6600), 1600x1200 and 12x22 font
Date: Fri, 22 Jul 2005 12:03:31 +0800
Message-ID: <200507221203.31810.adaplas@gmail.com>
References: <20050706190456.GA20251@amd64.of.nowhere>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DvpkV-00010D-8x
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Jul 2005 22:07:03 -0700
Received: from rproxy.gmail.com ([64.233.170.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DvpkU-0003Ou-Vk
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Jul 2005 22:07:03 -0700
Received: by rproxy.gmail.com with SMTP id a41so144629rng
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 21 Jul 2005 22:07:02 -0700 (PDT)
In-Reply-To: <20050706190456.GA20251@amd64.of.nowhere>
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
To: linux-fbdev-devel@lists.sourceforge.net, jurriaan <thunder7@xs4all.nl>, adaplas@hotpop.com, adaplas@pol.net

On Thursday 07 July 2005 03:04, jurriaan wrote:
> I've bought myself a fine new s939 motherboard, which meant another
> videocard as well. Since I couldn't get an Ati X600 running reliably
> under X.org (#@#$*$ FIFO timed out errors are very frustrating, and the
> only solution I found was to shut down all acceleration, which didn't
> make me happy), I'm now running an Nvidia 6600.
>
> Kernel command line: root=/dev/hda1 video=nvidiafb:1600x1200-32@85
> atkbd.softrepeat=1
>
> nvidiafb: nVidia device/chipset 10DE0141
> nvidiafb: PCI device 10de:0141 (nVidia Corporation)
> nvidiafb: CRTC0 found
> nvidiafb: CRTC1 found
> nvidiafb: CRTC 0 appears to have a CRT attached
> nvidiafb: Using CRT on CRTC 0
> nvidiafb: MTRR set to ON
> Console: switching to colour frame buffer device 133x54
> nvidiafb: PCI nVidia NV14 framebuffer (64MB @ 0xC0000000)
>
> I'm running at 1600x1200 resolution with the 12x22 font, and a
> 2.6.13-rc1-mm1 kernel.
>
> A strange effect is noticeable: often characters from the left of the
> screen are ghosted on the right of the screen. Not all of the pixels
> that form a character, but enough to be visible. To my best knowledge,
> the ghosting starts at column 85, and 85 * 12 = 1020, which may mean
> some sort of erroneous wrap-around at pixel 1024 is taking place?
>

It looks like a timings problem.  Are the effects still present if you try to
change modes?

Based on the dmesg snippet, I don't think the driver was able to grab the
edid.  Which means that the mode 1600x1200 was taken from the default modedb
which may not be correct for your hardware.

If you can, grab X's modeline using xvidtune, then convert it into a fb
compatible modeline, enter it in /etc/fb.modes then use fbset to change your
video mode.

Tony



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
