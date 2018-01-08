From: Ladislav Michl <ladis@linux-mips.org>
Date: Mon, 08 Jan 2018 16:55:27 +0000
Subject: Re: [PATCH v2 0/5] video: udlfb: (not only) Logging cleanup
Message-Id: <20180108165527.GA8109@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180104193623.GA22612@lenoch>
In-Reply-To: <20180104193623.GA22612@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Jan 04, 2018 at 08:36:23PM +0100, Ladislav Michl wrote:
> This patchset is a side product of debugging on unreliable USB host
> where devices saw a lot of disconnects. It turned out that udlfb
> logging is just too noisy to be usefull as produced syslog is hard
> to read.
> 
> Hence this attempt to clean things up.
> 
> Comments and suggestions welcome and appreciated, as always.
> 
> Changes in v2:
> - Dropped patch "Delete error messages for failed allocations"
> - Dropped patch "Remove unnecessary 'return'"
> - Added patch "Remove noisy warnings"
> - Reordered patches
> - Rebased against next-20180104
>   Please note as kernel compilation fails with:
>     kernel/exit.o: In function `__crc_abort':
>     exit.c:(*ABS*+0xc0e2ec8b): multiple definition of `__crc_abort'
>     Makefile:1029: recipe for target 'vmlinux' failed
>   this patchset is not runtime tested.

FYI, now runtime tested with next-20180108:

usb 2-1.4.1: new high-speed USB device number 6 using ehci-omap
usb 2-1.4.1: New USB device found, idVendor8f, idProductb54
usb 2-1.4.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
hub 2-1.4.1:1.0: USB hub found
hub 2-1.4.1:1.0: 4 ports detected
usb 2-1.4.1.2: new high-speed USB device number 7 using ehci-omap
usb 2-1.4.1.2: New USB device found, idVendore9, idProduct@1a
usb 2-1.4.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-1.4.1.2: Product: mimo
usb 2-1.4.1.2: Manufacturer: DisplayLink
usb 2-1.4.1.2: SerialNumber: 7090902
udlfb 2-1.4.1.2:1.0: vendor descriptor length:23 data:23 5f 01 00 21 00 04 04 07 00 01
udlfb 2-1.4.1.2:1.0: DL chip limited to 1500000 pixel modes
usb 2-1.4.1.2: fb1 is DisplayLink USB device (800x480, 1504K framebuffer memory)

> Ladislav Michl (5):
>   video: udlfb: Remove unnecessary local variable
>   video: udlfb: Remove redundant gdev variable
>   video: udlfb: Remove noisy warnings
>   video: udlfb: Do not name private data 'dev'
>   video: udlfb: Switch from the pr_*() to the dev_*() logging functions
> 
>  drivers/video/fbdev/udlfb.c | 635 +++++++++++++++++++++-----------------------
>  include/video/udlfb.h       |   3 +-
>  2 files changed, 302 insertions(+), 336 deletions(-)
> 
> -- 
> 2.15.1
> 
