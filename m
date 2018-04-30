From: Simon Horman <horms@verge.net.au>
Date: Mon, 30 Apr 2018 07:20:45 +0000
Subject: Re: [PATCH 0/3] fbdev/drm: sh_mobile: remove unused MERAM support
Message-Id: <20180430072045.pveq4t63amanu6tx@verge.net.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180427112213epcas2p3ed6890af75e679b537121f2655aa91d8@epcas2p3.samsung.com>
 <1524828105-26585-1-git-send-email-b.zolnierkie@samsung.com>
In-Reply-To: <1524828105-26585-1-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 01:21:42PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patchset removes unused MERAM support (last user was removed
> 3 years ago) from shmobile fbdev & drm drivers and then removes
> MERAM driver itself.
> 
> If it is okay to merge this patches I would like patch #1 to go
> through fbdev tree and patch #2 to go through drm tree. Once they
> are both upstream (v4.18) I will apply patch #3 to fbdev tree.

Nice to see this cleanup, thanks.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
