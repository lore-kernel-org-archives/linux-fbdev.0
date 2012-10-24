From: Tony Lindgren <tony@atomide.com>
Date: Wed, 24 Oct 2012 16:23:15 +0000
Subject: Re: [PATCH 20/20] OMAPDSS: split hdmi muxing function
Message-Id: <20121024162314.GF5605@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
 <1351070951-18616-21-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1351070951-18616-21-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [121024 02:32]:
> Split the omap4_hdmi_mux_pads() function into two parts, one handles the
> tpd12s015 gpio muxing, the other handles the hdmi pins.
> 
> This is clearer, as hdmi and tpd12s015 are separate devices, and it also
> allows us to mux those separately with DT.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Ricardo Neri <ricardo.neri@ti.com>

Looks OK to me to merge with the rest of the DSS patches:

Acked-by: Tony Lindgren <tony@atomide.com>
