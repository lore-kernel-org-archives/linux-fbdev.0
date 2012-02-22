From: Tony Lindgren <tony@atomide.com>
Date: Wed, 22 Feb 2012 18:06:01 +0000
Subject: Re: [PATCH 03/16] OMAPDSS: Remove video SRAM support
Message-Id: <20120222180601.GX18185@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
 <1327399231-20826-4-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1327399231-20826-4-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120124 01:30]:
> OMAP SRAM can be used as video memory on OMAP1 and 2. However, there
> usually is very little SRAM available, thus limiting its use, and no
> board supported by the kernel currently uses it.
> 
> This patch removes the use of SRAM as video ram for the omapdss driver
> to simplify memory handling.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

For the arch/arm/*omap*/* parts:

Acked-by: Tony Lindgren <tony@atomide.com>
