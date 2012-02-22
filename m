From: Tony Lindgren <tony@atomide.com>
Date: Wed, 22 Feb 2012 18:06:58 +0000
Subject: Re: [PATCH 04/16] OMAPFB: Remove video SRAM support (old omapfb)
Message-Id: <20120222180658.GY18185@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
 <1327399231-20826-5-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1327399231-20826-5-git-send-email-tomi.valkeinen@ti.com>
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
> This patch removes the use of SRAM as video ram for the old omapfb
> driver to simplify memory handling.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
