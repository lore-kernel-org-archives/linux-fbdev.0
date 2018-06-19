From: Stephen Boyd <sboyd@kernel.org>
Date: Tue, 19 Jun 2018 20:12:31 +0000
Subject: Re: [PATCH] video: fbdev: simplefb: Stop including <linux/clk-provider.h>
Message-Id: <152943915116.16708.6058152206701595837@swboyd.mtv.corp.google.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180619172221.20252-1-geert+renesas@glider.be>
In-Reply-To: <20180619172221.20252-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-fbdev@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org

Quoting Geert Uytterhoeven (2018-06-19 10:22:21)
> Simplefb is not a clock provider, but it uses of_clk_get_parent_count(),
> so it can just include <linux/of_clk.h> instead.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

