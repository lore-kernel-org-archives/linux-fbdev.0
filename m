From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 20 Mar 2020 13:42:56 +0000
Subject: Re: fbdev: fix -Wextra build warnings
Message-Id: <27499b12-9e21-a799-ca9b-0852d1c0de0e@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200315041009eucas1p14e087e86c18ceafe1644589a67de9499@eucas1p1.samsung.com>
 <20200315041002.24473-1-rdunlap@infradead.org>
In-Reply-To: <20200315041002.24473-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>


On 3/15/20 5:09 AM, Randy Dunlap wrote:
> This patch series fixes warnings in fbdev that are found when
> -Wextra is used. In fixing these, there were a few other build
> errors discovered (mostly caused by bitrot) and fixed.
> 
> [PATCH 1/6] fbdev: fbmon: fix -Wextra build warnings
> [PATCH 2/6] fbdev: aty: fix -Wextra build warning
> [PATCH 3/6] fbdev: matrox: fix -Wextra build warnings
> [PATCH 4/6] fbdev: savage: fix -Wextra build warning
> [PATCH 5/6] fbdev: pm[23]fb.c: fix -Wextra build warnings and errors
> [PATCH 6/6] fbdev: via: fix -Wextra build warning and format warning
> 
>  drivers/video/fbdev/aty/atyfb_base.c       |    2 +-
>  drivers/video/fbdev/core/fbmon.c           |    2 +-
>  drivers/video/fbdev/matrox/matroxfb_base.h |    2 +-
>  drivers/video/fbdev/pm2fb.c                |    2 +-
>  drivers/video/fbdev/pm3fb.c                |    8 ++++----
>  drivers/video/fbdev/savage/savagefb.h      |    2 +-
>  drivers/video/fbdev/via/debug.h            |    6 ++++--
>  drivers/video/fbdev/via/viafbdev.c         |    2 +-
>  8 files changed, 14 insertions(+), 12 deletions(-)

Patches #1-6 queued for v5.7, thanks!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
