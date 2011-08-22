From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 22 Aug 2011 08:42:36 +0000
Subject: Re: [PATCH 00/10] OMAPDSS: code cleanups
Message-Id: <1314002556.2168.25.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org

On Mon, 2011-08-22 at 11:27 +0300, Tomi Valkeinen wrote:
> Cleanups for DSS driver, no functionality changed.
> 
>  Tomi
> 
> Tomi Valkeinen (10):
>   OMAP: DSS2: Remove support for non-DISPC overlays
>   OMAP: DSS2: DISPC: use lookup tables for bit shifts
>   OMAP: DSS2: Add overlay caps to DSS features
>   OMAP: DSS2: Add GLOBAL_ALPHA & PRE_MULT_ALPHA to ovl caps
>   OMAP: DSS2: string parsing cleanups
>   OMAP: OMAPFB: string parsing cleanups
>   OMAP: DSS2: DISPC: remove non-existing func prototypes
>   OMAP: DSS2: DISPC: rename overlay related funcs
>   OMAP: DSS2: DISPC: rename manager related funcs
>   OMAP: DSS2: reorganize functions in dss.h

This patch set had some minor conflicts with the patch "OMAP: DSS2:
Handle manager change in apply". The dss master branch has all the
patches with conflicts resolved.

 Tomi


