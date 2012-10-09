From: Kevin Hilman <khilman@deeprootsystems.com>
Date: Tue, 09 Oct 2012 20:37:34 +0000
Subject: Re: [PATCHv2 1/3] OMAP: VRFB: convert vrfb to platform device
Message-Id: <87fw5n1iwh.fsf@deeprootsystems.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349785827-27055-1-git-send-email-tomi.valkeinen@ti.com>
	<1349785827-27055-2-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1349785827-27055-2-git-send-email-tomi.valkeinen@ti.com> (Tomi
	Valkeinen's message of "Tue, 9 Oct 2012 15:30:24 +0300")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>

Hi Tomi,

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> This patch converts vrfb library into a platform device, in an effort to
> remove omap dependencies.
>
> The platform device is registered in arch/arm/plat-omap/fb.c and
> assigned resources depending on whether running on omap2 or omap3.
>
> The vrfb driver will parse those resources and use them to access vrfb
> configuration registers and the vrfb virtual rotation areas.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

[...]

I was having a quick look at this for the context save/restore piece in
order to understand how this driver's context is being saved/restored.

Looking at mainline, I don't see where omap_vrfb_restore_context() is
being called currently.  Am I missing something?

Kevin



