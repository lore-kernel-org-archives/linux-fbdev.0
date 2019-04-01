From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Apr 2019 12:04:25 +0000
Subject: Re: [PATCH] video/macfb: Always initialize DAFB colour table pointer register
Message-Id: <aed176be-adce-dd80-8f54-55a1ca33a65b@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190218224758epcas5p21d3d13ec8323a3ff3c04d45081b4cfff@epcas5p2.samsung.com>
 <7396d7b11366fe9ee362cb140e74dd391e66e2d6.1550529894.git.fthain@telegraphics.com.au>
In-Reply-To: <7396d7b11366fe9ee362cb140e74dd391e66e2d6.1550529894.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Finn Thain <fthain@telegraphics.com.au>
Cc: linux-m68k@lists.linux-m68k.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


On 02/18/2019 11:44 PM, Finn Thain wrote:
> Don't skip the framebuffer CLUT pointer register initialization when
> the first dafb_setpalette() invocation has regno equal to zero.
> 
> Cc: linux-m68k@lists.linux-m68k.org
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
