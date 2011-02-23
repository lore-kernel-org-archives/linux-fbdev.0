From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 23 Feb 2011 09:47:41 +0000
Subject: Re: [PATCH] OMAPFB: Adding a check for timings in set_def_mode
Message-Id: <1298454461.29392.5.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1298381713-13624-1-git-send-email-mayur@ti.com>
In-Reply-To: <1298381713-13624-1-git-send-email-mayur@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lethal@linux-sh.org" <lethal@linux-sh.org>

On Tue, 2011-02-22 at 07:35 -0600, Janorkar, Mayuresh wrote:
> When omapfb.mode is passed through bootargs, when omapfb is setting mode,
> it would check if timings passed are fine for panel attached to it.
> It makes use of check_timing API provided by the panel.
> 
> In current code if check_timing API is not available for attached panel,
> OMAPFB would return -EINVAL and BPP sent via bootargs will not have any effect.
> 
> In case of panels like TAAL panel, omapfb or any other driver should not be allowed to
> change the timings. So bpps sent via bootargs will not have an effect.
> 
> In such case we can check only the x_res and y_res with the panels resolution
> and if they match go ahead and set the bpps.
> The bpp value sent via bootarg would have an effect.
> 
> Signed-off-by: Mayuresh Janorkar <mayur@ti.com>

This looks good, applying to DSS tree.

 Tomi


