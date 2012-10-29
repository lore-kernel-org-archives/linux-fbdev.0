From: Archit Taneja <archit@ti.com>
Date: Mon, 29 Oct 2012 09:50:44 +0000
Subject: Re: [PATCH 04/20] OMAPDSS: DISPC: fix dispc_mgr_lclk_rate for DIGIT output
Message-Id: <508E5161.2060202@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com> <1351070951-18616-5-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1351070951-18616-5-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 24 October 2012 02:58 PM, Tomi Valkeinen wrote:
> dispc_mgr_lclk_rate() cannot currently be called with DIGIT channel
> parameter, even if dispc_ovl_lclk_rate() can. Fix this by making

It's called dispc_plane_lclk_rate() right now.

> dispc_mgr_lclk_rate() handle DIGIT channel also.

Did you see a bug with this? Or is this just a cleanup?

Archit
