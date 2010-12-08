From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 08 Dec 2010 05:36:35 +0000
Subject: Re: [PATCH 1/2] video, sm501: add OF binding to support SM501
Message-Id: <20101208053635.GB31508@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
In-Reply-To: <1291451028-22532-1-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Heiko Schocher <hs@denx.de>
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org, linuxppc-dev@lists.ozlabs.org, Samuel Ortiz <sameo@linux.intel.com>, Ben Dooks <ben-linux@fluff.org>

On Sat, Dec 04, 2010 at 09:23:47AM +0100, Heiko Schocher wrote:
> - add binding to OF, compatible name "smi,sm501"
> 
> - add read/write functions for using this driver
>   also on powerpc plattforms
> 
> - add commandline options:
>   sm501.fb_mode:
>     Specify resolution as "<xres>x<yres>[-<bpp>][@<refresh>]"
>   sm501.bpp:
>     Specify bit-per-pixel if not specified mode
> 
> - Add support for encoding display mode information
>   in the device tree using verbatim EDID block.
> 
>   If the "edid" entry in the "smi,sm501" node is present,
>   the driver will build mode database using EDID data
>   and allow setting the display modes from this database.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> cc: linux-fbdev@vger.kernel.org
> cc: devicetree-discuss@ozlabs.org
> ---
> based against 2.6.37-rc4
> 
> ./scripts/checkpatch.pl 0003-video-sm501-add-OF-binding-to-support-SM501.patch lems and is ready for
> total: 0 errors, 0 warnings, 1067 lines checked
> 
> 0003-video-sm501-add-OF-binding-to-support-SM501.patch has no obvious style problems and is ready for submission.
> 
>  Documentation/kernel-parameters.txt          |    7 +
>  Documentation/powerpc/dts-bindings/sm501.txt |   30 +++
>  drivers/mfd/sm501.c                          |  141 ++++++++------
>  drivers/video/sm501fb.c                      |  264 +++++++++++++++++---------
>  include/linux/sm501.h                        |    8 +
>  5 files changed, 299 insertions(+), 151 deletions(-)
>  create mode 100644 Documentation/powerpc/dts-bindings/sm501.txt
> 
Given that this is all SM501 dependent, is there some particular reason
why you neglected to Cc the author or the MFD folks?
