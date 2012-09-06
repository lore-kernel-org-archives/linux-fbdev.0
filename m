From: Tony Lindgren <tony@atomide.com>
Date: Thu, 06 Sep 2012 20:11:55 +0000
Subject: Re: [PATCH 7/8] OMAP: 4430SDP: remove DSI clock config from board file
Message-Id: <20120906201155.GD1303@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
 <1345729514-2441-8-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1345729514-2441-8-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120823 06:46]:
> DSI clocks are now configured dynamically by the DSI driver, so we can
> remove the hardcoded clock configuration from the board file.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

This should be safe to merge via fb tree:

Acked-by: Tony Lindgren <tony@atomide.com>
