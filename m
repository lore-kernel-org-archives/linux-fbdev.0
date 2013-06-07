From: Archit Taneja <archit@ti.com>
Date: Fri, 07 Jun 2013 07:18:47 +0000
Subject: Re: [PATCH 19/32] OMAPDSS: add videomode conversion support
Message-Id: <51B18687.6000602@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com> <1369906493-27538-20-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1369906493-27538-20-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Thursday 30 May 2013 03:04 PM, Tomi Valkeinen wrote:
> Add helper functions to convert between omapdss specific video timings
> and the common videomode.
>
> Eventually omapdss will be changed to use only the common video timings,
> and these helper functions will make the transition easier.

So we now use omap_video_timings, videomode, drm_display_mode, and 
fb_var_screeninfo, fun! :)

Archit

