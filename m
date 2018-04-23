From: Simon Horman <horms@verge.net.au>
Date: Mon, 23 Apr 2018 07:46:54 +0000
Subject: Re: [PATCH] video: fbdev: sh_mobile_meram: Drop SUPERH platform dependency
Message-Id: <20180423074653.chqhdfroamufvw47@verge.net.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1524234051-14058-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1524234051-14058-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Fri, Apr 20, 2018 at 04:20:51PM +0200, Geert Uytterhoeven wrote:
> Since commit a521422ea4ae6128 ("ARM: shmobile: mackerel: Remove Legacy C
> board code"), the only remaining platforms using this driver are SuperH
> SH-Mobile SoCs (sh7723).  As both SUPERH and ARCH_SHMOBILE are set for
> these platforms, the SUPERH dependency can be dropped.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>
