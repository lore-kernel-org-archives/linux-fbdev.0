From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 03 Jul 2018 15:10:34 +0000
Subject: Re: [PATCH] video: fbdev: simplefb: Stop including <linux/clk-provider.h>
Message-Id: <2060425.mtieo8VWGK@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180619172229epcas3p15ff0f115330cd4ffea687479cc929738@epcas3p1.samsung.com>
 <20180619172221.20252-1-geert+renesas@glider.be>
In-Reply-To: <20180619172221.20252-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org

On Tuesday, June 19, 2018 07:22:21 PM Geert Uytterhoeven wrote:
> Simplefb is not a clock provider, but it uses of_clk_get_parent_count(),
> so it can just include <linux/of_clk.h> instead.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

