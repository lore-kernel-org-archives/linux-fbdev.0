From: Tony Lindgren <tony@atomide.com>
Date: Fri, 07 Sep 2012 16:21:37 +0000
Subject: Re: [PATCH 1/8] OMAPDSS: HDMI: Move GPIO handling to HDMI driver
Message-Id: <20120907162137.GS1303@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
 <1345729514-2441-2-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1345729514-2441-2-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120823 06:46]:
> We currently manage HDMI GPIOs in the board files via
> platform_enable/disable calls. This won't work with device tree, and in
> any case the correct place to manage the GPIOs is in the HDMI driver.
> 
> This patch moves the handling of the GPIOs to the HDMI driver. The GPIO
> handling is moved to the common hdmi.c file, and this probably needs to
> be revisited when adding OMAP5 HDMI support to see if the GPIO handling
> needs to be moved to IP specific files.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

This too looks safe to merge via fb tree:

Acked-by: Tony Lindgren <tony@atomide.com>
