From: Kevin Hilman <khilman@ti.com>
Date: Mon, 23 Jan 2012 22:33:51 +0000
Subject: Re: [PATCH 3/3] OMAPDSS: use sync versions of pm_runtime_put
Message-Id: <87d3aakq0g.fsf@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327320930-14550-1-git-send-email-tomi.valkeinen@ti.com>
	<1327320930-14550-4-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1327320930-14550-4-git-send-email-tomi.valkeinen@ti.com> (Tomi
	Valkeinen's message of "Mon, 23 Jan 2012 14:15:30 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, paul@pwsan.com, archit@ti.com, neilb@suse.de, jean.pihet@newoldbits.com, jw@terrafix.co.uk

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> omapdss doesn't work properly on system suspend. The problem seems to be
> the fact that omapdss uses pm_runtime_put() functions when turning off
> the hardware, and when system suspend is in process only sync versions
> are allowed.
>
> Using non-sync versions normally and sync versions when suspending would
> need rather ugly hacks to convey the information of
> suspending/not-suspending to different functions. Optimally the driver
> wouldn't even need to care about this, and the PM layer would handle
> syncing when suspend is in process.
>
> This patch changes all omapdss's pm_runtime_put calls to
> pm_runtime_put_sync. This fixes the suspend problem, and probably the
> performance penalty of always using sync versions is negligible.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>
