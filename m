From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 29 Apr 2020 13:39:23 +0000
Subject: Re: [PATCH v2] video: fbdev: controlfb: fix build for COMPILE_TEST=y && PPC_PMAC=y && PPC32=n
Message-Id: <20200429133923.GA18115@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200429104825eucas1p16bf37b71a3ab3a768d1eff6c48eb61dd@eucas1p1.samsung.com>
 <fe520316-3863-e6c4-9581-5d709f49e906@samsung.com>
 <20200429125101.GA21275@infradead.org>
In-Reply-To: <20200429125101.GA21275@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-fbdev@vger.kernel.org, kbuild test robot <lkp@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi Christoph

On Wed, Apr 29, 2020 at 05:51:01AM -0700, Christoph Hellwig wrote:
> Why do we even bother allocing the driver to compile for !ppc32
> given that it clearly needs ppc-specific infrastructure?  The whole
> idea of needing magic stubs for the COMPILE_TEST case seems rather
> counterproduction.

All the usual good arguments.
If this driver only builds for 32bit powerpc then we will seldom
build it and every time we do some refactoring we risk introducing
build errros in this driver that is triggered much later.

So a few hacks are preferred to actually make it build.
But hacks should not paper over missing abstractions
in the general ioremap handlign and such.

I recall someone said the other day that drm folks had a tendency to
workaround rather than fixing this.
So this is "drm folks" reaching out and asking if this is a
case where we have a workaround and need a fix?

I will - after some testing - apply the fix from Bartlomiej.
But would like to know if this is a workarond or a fix.
Dropping COMPILE_TEST is not an option as explained above.

	Sam
