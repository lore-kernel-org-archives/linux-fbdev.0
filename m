From: Archit Taneja <archit@ti.com>
Date: Wed, 20 Mar 2013 11:42:46 +0000
Subject: Re: [PATCH 05/14] OMAPDSS: DSI: add enum omap_dss_dsi_trans_mode
Message-Id: <51499DE6.4060008@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com> <1362743569-10289-6-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1362743569-10289-6-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 08 March 2013 05:22 PM, Tomi Valkeinen wrote:
> Instead of managing DSI sync ends with booleans, add an enum for the DSI
> transfer mode. This is much cleaner way to handle the DSI syncs.

This sort of DSI protocol specific enums should definitely get into the 
CDF encoder drivers, maybe even in include/video/mipi_display.h for the 
time CDF is being worked upon.

Archit

