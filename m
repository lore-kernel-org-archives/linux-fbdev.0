From: Christoph Hellwig <hch@infradead.org>
Date: Wed, 29 Apr 2020 12:51:01 +0000
Subject: Re: [PATCH v2] video: fbdev: controlfb: fix build for COMPILE_TEST=y && PPC_PMAC=y && PPC32=n
Message-Id: <20200429125101.GA21275@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200429104825eucas1p16bf37b71a3ab3a768d1eff6c48eb61dd@eucas1p1.samsung.com>
 <fe520316-3863-e6c4-9581-5d709f49e906@samsung.com>
In-Reply-To: <fe520316-3863-e6c4-9581-5d709f49e906@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <lkp@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Why do we even bother allocing the driver to compile for !ppc32
given that it clearly needs ppc-specific infrastructure?  The whole
idea of needing magic stubs for the COMPILE_TEST case seems rather
counterproduction.
