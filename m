From: Tony Lindgren <tony@atomide.com>
Date: Mon, 30 Jun 2014 07:24:14 +0000
Subject: Re: [PATCH v2 01/13] ARM: OMAP2+: Remove non working OMAP HDMI audio initialization
Message-Id: <20140630072414.GL28884@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1403894190.git.jsarha@ti.com>
 <41571cc2e5a93ff95eda9263a4b5808bba7e6e36.1403894190.git.jsarha@ti.com>
In-Reply-To: <41571cc2e5a93ff95eda9263a4b5808bba7e6e36.1403894190.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, jyri.sarha@iki.fi

* Jyri Sarha <jsarha@ti.com> [140627 11:41]:
> This code is not working currently and it can be removed. There is a
> conflict in sharing resources with the actual HDMI driver and with
> the ASoC HDMI audio DAI driver.
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
