From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 15 Jun 2011 11:23:47 +0000
Subject: Re: [PATCHv2 15/28] OMAP4: HWMOD: Modify DSS opt clocks
Message-Id: <1308137027.1974.39.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
	 <1307627810-3768-16-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1307627810-3768-16-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b-cousson@ti.com
Cc: linux-fbdev@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>

On Thu, 2011-06-09 at 16:56 +0300, Tomi Valkeinen wrote:
> Add missing DSS optional clocks to HWMOD data for OMAP4xxx.
> 
> Add HWMOD_CONTROL_OPT_CLKS_IN_RESET flag for dispc to fix dispc reset.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Benoit (and/or Paul/Kevin), can you ack this and the other HWMOD
patches, or give comments?

 Tomi


