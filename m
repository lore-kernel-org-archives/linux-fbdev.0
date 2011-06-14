From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 14 Jun 2011 07:24:17 +0000
Subject: Re: [PATCHv2 01/28] OMAP: change get_context_loss_count ret value
Message-Id: <1308036257.1899.8.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
	 <1307627810-3768-2-git-send-email-tomi.valkeinen@ti.com>
	 <1307958710.1847.56.camel@deskari>
	 <alpine.DEB.2.00.1106140111540.20723@utopia.booyaka.com>
In-Reply-To: <alpine.DEB.2.00.1106140111540.20723@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-fbdev@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>

On Tue, 2011-06-14 at 01:13 -0600, Paul Walmsley wrote:
> Hi Tomi
> 
> On Mon, 13 Jun 2011, Tomi Valkeinen wrote:
> 
> > Paul, can you take this patch and queue it for an rc?
> 
> Generally I only queue regressions or fixes for major problems (crashes, 
> corruption, etc.) for -rc series.  So probably this one should go in via 
> the normal merge window, unless it's been causing major disruptions?

No, only disruptions for me as the DSS pm_runtime patches depend on this
one to function correctly. So merge window is ok, I'll handle the DSS
side somehow.

 Tomi


