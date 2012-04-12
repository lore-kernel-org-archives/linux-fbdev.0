From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 12 Apr 2012 02:20:21 +0000
Subject: Re: [PATCH v3 0/4] video: s3c-fb: Rearrange the elements in platform data
Message-Id: <4F863BE5.9080503@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1332606528-32338-1-git-send-email-thomas.abraham@linaro.org>
In-Reply-To: <1332606528-32338-1-git-send-email-thomas.abraham@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 03/24/2012 04:28 PM, Thomas Abraham wrote:
> Changes since v2:
> - Patch 3/4 is a new patch in this series. The real6410 and mini6410 boards
>   use the display controllers window configuration data to represent video
>   timing of two different lcd panels. Since the window configuration data
>   should be not be used to specify timing of two different panels, this has
>   been reworked in such a way that two instance of display controller's
>   platform data is setup for the two supported lcd panels. Depending on the
>   lcd panel specified using boot parameters, the corresponding platform data
>   is registered. This maintains backward compatibility with existing
>   functionality of supporting multiple lcd panels at runtime.
> 
> Changes since v1:
> - Includes all changes suggested by Jingoo Han.
> - Reworked s3c-fb platform data in all Samsung SoC based board files.
> 
> This patchset rearranges the elements in the platform data of the s3c-fb
> driver with the intent of adding device tree support to the driver in
> subsequent patches.
> 
> The first patch moves the video timing information from the individual window
> setup data into the platform specific configuration section in the platform
> data. The video timing is independent of the window setup. The resolution of
> the window could be smaller than that of the lcd panel attached. So the video
> timing data is removed from window configuration data.
> 
> The second patch removes the need for the 'default_win' element in the
> platform data. This element was used to decide whether the video data
> output from the controller should be enabled or disabled when the window
> specified by 'default_win' is enabled or disabled. With the first patch
> removing the need for atleast one window to be of the same resolution as
> that of the lcd panel, it is now possible to decide when to enable/disable
> the video data output based on the state of each window. If any of the
> window is active, the lcd data output is enabled. Otherwise, the lcd data
> output is disabled. Hence, the 'default_win' parameter from the platform
> data can be removed, which anyways cannot be specified when using
> device tree.
> 
> The third patch reworks the display controller's platform data that was
> used to supply video timing information for two different panels on the
> mini6410 and real6410 boards. That was not the correct usage of the window
> data and hence reworks the runtime handling of two different lcd panels.
> 
> For all the Samsung SoC based boards, the forth patch reworks the platform
> data of the display controller based on the changes introduced in the first
> two patches.
> 
> This patch series is based on
> http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git [for-next]
> 
> with all patches merged from
> https://github.com/schandinat/linux-2.6.git [fbdev-next]
> 
> and tested one Exynos4210 based Origen board (only compile tested for
> other boards)
> 
> Thomas Abraham (4):
>   video: s3c-fb: move video interface timing out of window setup data
>   video: s3c-fb: remove 'default_win' element from platform data
>   ARM: s3c64xx: Decouple lcd type from display controller window data
>   ARM: Samsung: Rework platform data of s3c-fb driver

Applied this series.


Thanks,

Florian Tobias Schandinat

> 
>  arch/arm/mach-exynos/mach-nuri.c           |   26 +++---
>  arch/arm/mach-exynos/mach-origen.c         |   24 +++--
>  arch/arm/mach-exynos/mach-smdkv310.c       |   28 ++++---
>  arch/arm/mach-exynos/mach-universal_c210.c |   26 +++---
>  arch/arm/mach-s3c24xx/mach-smdk2416.c      |   27 +++---
>  arch/arm/mach-s3c64xx/mach-anw6410.c       |   25 +++---
>  arch/arm/mach-s3c64xx/mach-crag6410.c      |   25 +++---
>  arch/arm/mach-s3c64xx/mach-hmt.c           |   24 +++--
>  arch/arm/mach-s3c64xx/mach-mini6410.c      |   92 +++++++++++--------
>  arch/arm/mach-s3c64xx/mach-real6410.c      |   90 +++++++++++--------
>  arch/arm/mach-s3c64xx/mach-smartq5.c       |   26 +++---
>  arch/arm/mach-s3c64xx/mach-smartq7.c       |   26 +++---
>  arch/arm/mach-s3c64xx/mach-smdk6410.c      |   25 +++---
>  arch/arm/mach-s5p64x0/mach-smdk6440.c      |   24 +++--
>  arch/arm/mach-s5p64x0/mach-smdk6450.c      |   24 +++--
>  arch/arm/mach-s5pc100/mach-smdkc100.c      |   27 +++---
>  arch/arm/mach-s5pv210/mach-aquila.c        |   36 ++++----
>  arch/arm/mach-s5pv210/mach-goni.c          |   26 +++---
>  arch/arm/mach-s5pv210/mach-smdkv210.c      |   24 +++--
>  arch/arm/plat-samsung/include/plat/fb.h    |   11 ++-
>  drivers/video/s3c-fb.c                     |  135 +++++++++++++--------------
>  21 files changed, 426 insertions(+), 345 deletions(-)
> 
> 

