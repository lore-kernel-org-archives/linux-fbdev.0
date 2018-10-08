From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 08 Oct 2018 10:52:30 +0000
Subject: Re: [PATCH] fbdev: fix broken menu dependencies
Message-Id: <20181008105232eucas1p27b4df429e75fea5c975da532a5511a43~bnKocDvgz1504515045eucas1p2C@eucas1p2.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180922224318epcas3p4ee7b0ed26f6776adf2404e71f195dbdf@epcas3p4.samsung.com>
 <1feb7db2-12b8-77c4-c325-cb4bdc76548e@infradead.org>
In-Reply-To: <1feb7db2-12b8-77c4-c325-cb4bdc76548e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Alexander Shiyan <shc_work@mail.ru>, Daniel Vetter <daniel.vetter@ffwll.ch>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Andrew Morton <akpm@linux-foundation.org>


On 09/23/2018 12:43 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> The framebuffer options and devices menu is unintentionally split
> or broken because some items in it do not depend on FB (including
> several under omap and mmp).
> Fix this by moving FB_CMDLINE, FB_NOTIFY, and FB_CLPS711X_OLD to
> just before the FB Kconfig symbol definition and by moving the
> omap, omap2, and mmp menus to last, following FB_SM712.
> 
> Also, the FB_VIA dependencies are duplicated by both being inside
> an "if FB_VIA/endif" block and "depends on FB_VIA", so drop the
> "depends on FB_VIA" lines since they are redundant.
> 
> Fixes: ea6763c104c9 ("video/fbdev: Always built-in video= cmdline parsing")
> Fixes: 5ec9653806ba ("fbdev: Make fb-notify a no-op if CONFIG_FB=n")
> Fixes: ef74d46a4ef3 ("video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver")
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
