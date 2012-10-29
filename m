From: Archit Taneja <archit@ti.com>
Date: Mon, 29 Oct 2012 07:24:08 +0000
Subject: Re: [PATCH 19/20] OMAPDSS: DISPC: remove dssdev depependency from error handler
Message-Id: <508E2C48.6020008@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com> <1351070951-18616-20-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1351070951-18616-20-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

On Wednesday 24 October 2012 02:59 PM, Tomi Valkeinen wrote:
> The dispc error handler tries to "fix" issues by disabling and enabling
> panel. This is problematic, as we're trying to remove the dependency
> from omapdss to the omap_dss_devices. It's also racy, and doesn't really
> fix anything.
>
> This patch removes the use of omap_dss_device from the error handler,
> and just disables and enables the associated overlay manager. This
> should produce similar results as the previous solution, without using
> dssdev.

Calling APPLY functions from the DISPC driver seems a bit incorrect. 
Instead of disabling/enabling the panel, can't we disable/enable the 
manger by just using DISPC funcs?

Archit
