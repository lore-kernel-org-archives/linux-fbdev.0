From: Kukjin Kim <kgene.kim@samsung.com>
Date: Thu, 23 Aug 2012 09:55:37 +0000
Subject: RE: [PATCH V2 0/5] arm: samsung: Move FIMD headers to include/video/
Message-Id: <1d5a01cd8115$7251eb40$56f5c1c0$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343737385-23337-1-git-send-email-l.krishna@samsung.com>
 <02f701cd6f8d$5ca3e850$15ebb8f0$%kim@samsung.com> <5018FDF6.4020205@gmx.de>
In-Reply-To: <5018FDF6.4020205@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>
Cc: 'Leela Krishna Amudala' <l.krishna@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 'Kukjin Kim' <kgene.kim@samsung.com>

Florian Tobias Schandinat wrote:
> 
> On 08/01/2012 02:28 AM, Kukjin Kim wrote:
> > Leela Krishna Amudala wrote:
> >>
> >> This patchset moves the contents of regs-fb-v4.h and regs-fb.h from
> arch
> >> side
> >> to include/video/samsung_fimd.h
> >>
> >> This patchset is created and rebased against master branch of torvalds
> >> tree.
> >> Tested on smdk5250 board, build tested for other boards.
> >>
> > (Cc'ed Florian Tobias Schandinat)
> >
> > Yeah, since it's merge window, this series could be created against on
> > mainline. And IMO, would be helpful to us if this series could be sent
> to
> > upstream via samsung tree after reviewing, because this touches too many
> > files in samsung tree and just adds include/video/samsung_fimd.h. But
> I'm
> > not sure the added inclusion will be used in other file of
drivers/video.
> If
> > so, I can provide some topic branch can be merged into Florian's tree.
> > Florian, how about?
> 
> Using a topic branch to merge it in both trees sounds like a good plan
> to me.
> 
Florian,

Please pull following topic branch we talked. I already merged it into my
-next.

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.7-for-florian

Note, I applied Leela's V4 patches not this V2 series.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.7-for-florian

Leela Krishna Amudala (2):
      include/video: move fimd register headers from platform to
include/video
      include/video: Add register offsets for FIMD version 8

 arch/arm/mach-exynos/mach-nuri.c                   |    2 +-
 arch/arm/mach-exynos/mach-origen.c                 |    2 +-
 arch/arm/mach-exynos/mach-smdk4x12.c               |    2 +-
 arch/arm/mach-exynos/mach-smdkv310.c               |    2 +-
 arch/arm/mach-exynos/mach-universal_c210.c         |    2 +-
 arch/arm/mach-exynos/setup-fimd0.c                 |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-anw6410.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-hmt.c                   |    2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-ncp.c                   |    2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    2 +-
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |    2 +-
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |    2 +-
 arch/arm/mach-s5pc100/mach-smdkc100.c              |    2 +-
 arch/arm/mach-s5pv210/mach-aquila.c                |    2 +-
 arch/arm/mach-s5pv210/mach-goni.c                  |    2 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c              |    2 +-
 arch/arm/plat-samsung/include/plat/regs-fb-v4.h    |  159
--------------------
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |    2 +-
 drivers/video/s3c-fb.c                             |    2 +-
 .../plat/regs-fb.h => include/video/samsung_fimd.h |  152
+++++++++++++++++--
 26 files changed, 165 insertions(+), 194 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb-v4.h
 rename arch/arm/plat-samsung/include/plat/regs-fb.h =>
include/video/samsung_fimd.h (73%)

