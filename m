From: Tony Lindgren <tony@atomide.com>
Date: Mon, 16 Dec 2013 18:41:58 +0000
Subject: Re: [PATCHv2 01/27] ARM: OMAP: remove DSS DT hack
Message-Id: <20131216184157.GA26293@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
 <1387205794-32246-2-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1387205794-32246-2-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131216 06:59]:
> As a temporary solution to enable DSS for selected boards when booting
> with DT, a hack was added to board-generic.c in
> 63d5fc0c2f748e20f38a0a0ec1c8494bddf5c288 (OMAP: board-generic: enable
> DSS for panda & sdp boards).
> 
> We're now adding proper DT support, so the hack can be removed.

I guess this patch should be merged later on after we have the DT support
working?

Regards,

Tony
