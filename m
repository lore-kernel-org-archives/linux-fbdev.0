From: Tony Lindgren <tony@atomide.com>
Date: Tue, 13 Aug 2013 07:54:49 +0000
Subject: Re: [RFC 00/22] OMAPDSS: DT support
Message-Id: <20130813075449.GS7656@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130809 01:46]:
> 
> So as is evident, I have things in my mind that should be improved. Maybe
> the most important question for short term future is:
> 
> Can we add DSS DT bindings for OMAP4 as unstable bindings? It would give us
> some proper testing of the related code, and would also allow us to remove
> the related hacks (which don't even work quite right). However, I have no
> idea yet when the unstable DSS bindings would turn stable.
> 
> If we shouldn't add the bindings as unstable, when should the bindings be
> added? Wait until CDF is in the mainline, and use that?

I don't think we should add any temporary bindings as it's going to be
a pain to support those in the long run. I suggest you initially just
stick to established bindings for the basic hardware IO address and
interrupts etc, then those should still be valid with the generic panel
bindings later on.

Regards,

Tony
