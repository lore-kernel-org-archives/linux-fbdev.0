From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Fri, 22 Feb 2013 04:11:39 +0000
Subject: RE: [PATCH RFC] video: Add Hyper-V Synthetic Video Frame Buffer Driver
Message-Id: <e0484554d9b44ade88b84f9e4e5ecc2d@DFM-DB3MBX15-08.exchange.corp.microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360955396-14183-1-git-send-email-haiyangz@microsoft.com>
 <20130219165118.GA17715@aepfle.de>
 <1ca36b5d55c64ac6b8854c4f216ef8e5@DFM-TK5MBX15-06.exchange.corp.microsoft.com>
 <20130219184009.GA21783@aepfle.de>
 <7267f77544c24531b8fcccc2192b9f48@DFM-TK5MBX15-06.exchange.corp.microsoft.com>,<20130221155359.GA28637@aepfle.de>
In-Reply-To: <20130221155359.GA28637@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olaf Hering <olaf@aepfle.de>
Cc: "FlorianSchandinat@gmx.de" <FlorianSchandinat@gmx.de>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>


> From: Olaf Hering
> Sent: Thursday, February 21, 2013 10:53 AM
> To: Haiyang Zhang
> Cc: FlorianSchandinat@gmx.de; linux-fbdev@vger.kernel.org; KY Srinivasan; jasowang@redhat.com; linux-kernel@vger.kernel.org; devel@linuxdriverproject.org
> Subject: Re: [PATCH RFC] video: Add Hyper-V Synthetic Video Frame Buffer Driver
> 
> On Tue, Feb 19, Haiyang Zhang wrote:
> 
> > In my test, the vesafb doesn't automatically give up the emulated video device,
> > unless I add the DMI based mechanism to let it exit on Hyper-V.
> 
> From reading the code, it seems to do that via
> do_remove_conflicting_framebuffers(). hypervfb does not set apertures
> etc, so that function is a noop.

We are currently allocating a new framebuffer for hyperv_fb, which is different
from the framebuffer for the emulated video. So this cannot be detected by
do_remove_conflicting_framebuffers() based on apertures_overlap().

> My point is that with this new driver distro kernel will have no console
> output until hypervfb is loaded. On native hardware there is at least
> vesafb which can display something until initrd is running. So if the
> hypervisor allows that hypervfb can shutdown the emulated vesa hardware
> then it should do that.

Since the generic vga driver starts to work early in the boot process, the console
messages are still displayed without vesafb. Actually, I didn't see any console 
messages missing when comparing it to the original VM before my patch.

Thanks,
- Haiyang
