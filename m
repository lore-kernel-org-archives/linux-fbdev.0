From: Tony Lindgren <tony@atomide.com>
Date: Wed, 22 Feb 2012 22:09:26 +0000
Subject: Re: [PATCH 00/16] OMAPDSS: old OMAPFB cleanup
Message-Id: <20120222220926.GL18185@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
 <1329220343.1845.65.camel@deskari>
 <20120222185016.GI18185@atomide.com>
In-Reply-To: <20120222185016.GI18185@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, archit@ti.com, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [120222 10:18]:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [120214 03:21]:
> > 
> > Tony, do you have any feedback on this? I think the arch/arm changes are
> > quite clean as such, but are you ok with (possibly) breaking N770's
> > display? The other OMAP1 boards should, at least in theory, work as well
> > as before.
> > 
> > For N770, the bootloader passes the reset GPIO number and number of
> > datalines, and I have no idea what those are.
> 
> I think they should be:
> 
> conf->nreset_gpio = 13
> conf->data_lines = 24

Probably should be:

conf->nreset_gpio = 13
conf->data_lines = 16

No luck getting anything on the LCD though with
current kernel though.

Tony
