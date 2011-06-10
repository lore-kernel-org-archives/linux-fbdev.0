From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 10 Jun 2011 07:24:53 +0000
Subject: Re: [PATCHv2 20/28] OMAP: DSS2: Use PM runtime & HWMOD support
Message-Id: <20110610072448.GG26006@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com> <1307627810-3768-21-git-send-email-tomi.valkeinen@ti.com> <20110609200335.GD26006@linux-sh.org> <1307688729.1823.12.camel@lappyti>
In-Reply-To: <1307688729.1823.12.camel@lappyti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com, khilman@ti.com

On Fri, Jun 10, 2011 at 09:52:09AM +0300, Tomi Valkeinen wrote:
> On Fri, 2011-06-10 at 05:03 +0900, Paul Mundt wrote:
> > the use in the error paths and so on you will definitely need to be using
> > pm_runtime_put_sync() at least some of the time.
> 
> Hmm, why is that? When the user of, say, dispc, has finished with it and
> calls dispc_runtime_put(), the caller shouldn't care if the HW is
> actually turned off now or later.
> 
Ah, I forgot that pm_runtime_disable() already does the synchronous bits
for you, so you get lucky that way. I was concerned about the race
between the work queue and the device pointer going away, but this is
already handled by the subsystem via __pm_runtime_barrier() in the
disable path.

> pm_runtime_put() can return an error value, but my wrappers discard it,
> as I don't know in which situations it could happen, and what could the
> driver do about it. If the HW cannot be turned off now, why could it be
> turned off later, and when would that be?
> 
The return value is primarily aimed at informing you whether it was able
to idle the device, whether there were already pending requests, etc. If
you're in an exit path you're probably not too concerned with this.

If you have some alternate means of cutting power to the block unrelated
to runtime pm based clock control you can use the return value as a
sanity measure to error out before inadvertently cutting power out
underneath another user.
