From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 20 Mar 2017 17:29:19 +0000
Subject: Re: [PATCH] video/logo: tidyup fb_logo_late_init initcall timing
Message-Id: <1911545.JOzUcodloT@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170308101436epcas5p44c047eb28386d4d3545313a10cb72775@epcas5p4.samsung.com>
 <87h934oz7j.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87h934oz7j.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Laurent <laurent.pinchart@ideasonboard.com>, Fabian Frederick <fabf@skynet.be>, Andrew Morton <akpm@linux-foundation.org>, shimoda <yoshihiro.shimoda.uh@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, shiiba <naoya.shiiba.nx@renesas.com>, sakato <ryusuke.sakato.bx@renesas.com>, Hosoya <yoshifumi.hosoya.wj@renesas.com>, Fukawa <tomoharu.fukawa.eb@renesas.com>, Hien Dang <hien.dang.eb@renesas.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kouei Abe <kouei.abe.cp@renesas.com>, Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Takeshi Kihara <takeshi.kihara.df@renesas.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wednesday, March 08, 2017 10:14:33 AM Kuninori Morimoto wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> Some video driver might returns -EPROBE_DEFER when probe timing,
> but logo init function doesn't care it.
> Thus, such kernel can't have logo when boot time.
> 
> This patch solves this issue by exchanging current
> late_initcall to late_initcall_sync
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch queued for 4.12, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

