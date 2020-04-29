From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 29 Apr 2020 13:14:41 +0000
Subject: Re: [PATCH v2] video: fbdev: controlfb: fix build for COMPILE_TEST=y && PPC_PMAC=y && PPC32=n
Message-Id: <3006e72e-fde0-127c-bd59-3902032a0c18@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200429104825eucas1p16bf37b71a3ab3a768d1eff6c48eb61dd@eucas1p1.samsung.com>
 <fe520316-3863-e6c4-9581-5d709f49e906@samsung.com>
 <20200429125101.GA21275@infradead.org>
In-Reply-To: <20200429125101.GA21275@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-fbdev@vger.kernel.org, kbuild test robot <lkp@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>


On 4/29/20 2:51 PM, Christoph Hellwig wrote:
> Why do we even bother allocing the driver to compile for !ppc32
> given that it clearly needs ppc-specific infrastructure?  The whole
> idea of needing magic stubs for the COMPILE_TEST case seems rather
> counterproduction.
Not a perfect solution but at the cost of 2 ifdefs it allows controlfb
driver to be compile tested on any arch.

Being able to compile test fbdev device drivers is really useful for
me and saves me a lot of time when doing fbdev maintainer duties.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
