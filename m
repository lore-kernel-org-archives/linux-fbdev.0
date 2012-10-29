From: Archit Taneja <archit@ti.com>
Date: Mon, 29 Oct 2012 10:21:00 +0000
Subject: Re: [PATCH 09/20] OMAPDSS: add dispc_ovl_enabled()
Message-Id: <508E55BC.5060607@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com> <1351070951-18616-10-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1351070951-18616-10-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 24 October 2012 02:59 PM, Tomi Valkeinen wrote:
> Add new dispc function, dispc_ovl_enabled(). This returns if the overlay
> enable bit is set in the registers.

Is this function used by omapdrm? I can't see it being used in the later 
patches.

Archit
