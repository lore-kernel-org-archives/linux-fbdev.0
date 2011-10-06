From: Tony Lindgren <tony@atomide.com>
Date: Thu, 06 Oct 2011 23:14:49 +0000
Subject: Re: [PATCHv2 01/28] OMAP: change get_context_loss_count ret value
Message-Id: <20111006231449.GB6324@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
 <1307627810-3768-2-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.00.1110061710510.4611@utopia.booyaka.com>
In-Reply-To: <alpine.DEB.2.00.1110061710510.4611@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com, khilman@ti.com

* Paul Walmsley <paul@pwsan.com> [111006 15:37]:
> On Thu, 9 Jun 2011, Tomi Valkeinen wrote:
> 
> > get_context_loss_count functions return context loss count as u32, and
> > zero means an error. However, zero is also returned when context has
> > never been lost and could also be returned when the context loss count
> > has wrapped and goes to zero.
> > 
> > Change the functions to return an int, with negative value meaning an
> > error.
> > 
> > OMAP HSMMC code uses omap_pm_get_dev_context_loss_count(), but as the
> > hsmmc code handles the returned value as an int, with negative value
> > meaning an error, this patch actually fixes hsmmc code also.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Acked-by: Kevin Hilman <khilman@ti.com>
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>> 

Thanks, picking this into fixes-part2 branch as requested by Paul.

Tony
