From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Apr 2018 16:09:42 +0000
Subject: Re: [PATCH] video: fbdev: sh_mobile_meram: Drop SUPERH platform dependency
Message-Id: <2605903.FtxXXJybeG@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180420142058epcas4p107bd9707fc2225753d4ae60ac316c45b@epcas4p1.samsung.com>
 <1524234051-14058-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1524234051-14058-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org

On Friday, April 20, 2018 04:20:51 PM Geert Uytterhoeven wrote:
> Since commit a521422ea4ae6128 ("ARM: shmobile: mackerel: Remove Legacy C
> board code"), the only remaining platforms using this driver are SuperH
> SH-Mobile SoCs (sh7723).  As both SUPERH and ARCH_SHMOBILE are set for
> these platforms, the SUPERH dependency can be dropped.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch queued for 4.18 (w/ Laurent's & Simon's ACKs), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

