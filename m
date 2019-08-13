From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 13 Aug 2019 13:30:29 +0000
Subject: Re: [PATCH 09/16] fbdev: remove w90x900/nuc900 platform drivers
Message-Id: <cc732000-a147-bec2-1082-7bf58ee8f309@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190809202749.742267-1-arnd@arndb.de>
        <CGME20190809202857epcas2p14ab10d8ce2e50647671ab8c0ded385a8@epcas2p1.samsung.com>
        <20190809202749.742267-10-arnd@arndb.de>
In-Reply-To: <20190809202749.742267-10-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, soc@kernel.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org


On 8/9/19 10:27 PM, Arnd Bergmann wrote:
> The ARM w90x900 platform is getting removed, so this driver is obsolete.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

BTW there is a very minor issue with internal bisectability of
this patch series (non-issue in reality because it affects only
configs with ARCH_W90X900=y and such are now gone, just FYI):

arch/arm/mach-w90x900/dev.c (which stays in tree until patch #16
("ARM: remove w90x900 platform") uses include/linux/platform_data/
files removed in patches #7 (spi), #9 (fbdev) and #10 (keyboard).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>  drivers/video/fbdev/Kconfig                  |  14 -
>  drivers/video/fbdev/Makefile                 |   1 -
>  drivers/video/fbdev/nuc900fb.c               | 760 -------------------
>  drivers/video/fbdev/nuc900fb.h               |  51 --
>  include/Kbuild                               |   1 -
>  include/linux/platform_data/video-nuc900fb.h |  79 --
>  6 files changed, 906 deletions(-)
>  delete mode 100644 drivers/video/fbdev/nuc900fb.c
>  delete mode 100644 drivers/video/fbdev/nuc900fb.h
>  delete mode 100644 include/linux/platform_data/video-nuc900fb.h
