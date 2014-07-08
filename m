From: Tony Lindgren <tony@atomide.com>
Date: Tue, 08 Jul 2014 08:09:45 +0000
Subject: Re: [PATCH 01/12] ARM: OMAP2+: Remove non working OMAP HDMI audio initialization
Message-Id: <20140708080945.GZ28884@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1403807781.git.jsarha@ti.com>
 <b0764a3af8181db55db046d6139119def363e8eb.1403807781.git.jsarha@ti.com>
 <20140707114625.GT28884@atomide.com>
 <53BB9E08.7090802@ti.com>
In-Reply-To: <53BB9E08.7090802@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, jyri.sarha@iki.fi

* Peter Ujfalusi <peter.ujfalusi@ti.com> [140708 00:32]:
> Hi Tony,
> 
> On 07/07/2014 02:46 PM, Tony Lindgren wrote:
> > * Jyri Sarha <jsarha@ti.com> [140626 12:26]:
> >> This code is not working currently and it can be removed. There is a
> >> conflict in sharing resources with the actual HDMI driver and with
> >> the ASoC HDMI audio DAI driver.
> > 
> > Is this OK to queue for v3.17 or do we need this for v3.16-rc series?
> 
> Jyri is away currently, but I think it would be great if this patch goes in
> for 3.16. The patch does not introduce regression since the OMAP4/5 HDMI is in
> non working state in the kernel so removing the platform device right now will
> ease up the merger of the new and working code.

OK, will apply it into omap-for-v3.16/fixes as it just removes broken code.

Regards,

Tony
