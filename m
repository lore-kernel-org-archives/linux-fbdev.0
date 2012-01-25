From: Paul Walmsley <paul@pwsan.com>
Date: Wed, 25 Jan 2012 19:02:54 +0000
Subject: Re: [PATCH 2/3] ARM: OMAP3: HWMOD: add SYSC_HAS_ENAWAKEUP for dispc
Message-Id: <alpine.DEB.2.00.1201251202400.5324@utopia.booyaka.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327320930-14550-1-git-send-email-tomi.valkeinen@ti.com> <1327320930-14550-3-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1327320930-14550-3-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com, neilb@suse.de, jean.pihet@newoldbits.com, khilman@ti.com, jw@terrafix.co.uk

On Mon, 23 Jan 2012, Tomi Valkeinen wrote:

> dispc's sysc_flags is missing SYSC_HAS_ENAWAKEUP flag. This seems to
> cause SYNC_LOST errors from the DSS when the power management is
> enabled.
> 
> This patch adds the missing SYSC_HAS_ENAWAKEUP flag. Note that there are
> other flags missing also (clock activity, DSI's sysc flags), but as they
> are not critical, they will be fixed in the next merge window.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, queued for 3.3-rc.


- Paul
