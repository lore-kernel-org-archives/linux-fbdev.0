From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 15 Jun 2011 06:14:07 +0000
Subject: Re: [PATCH v2 00/29] Use display information in info not in var for panning
Message-Id: <20110615061404.GM17891@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308043507-11083-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1308043507-11083-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Jun 14, 2011 at 11:24:38AM +0200, Laurent Pinchart wrote:
> I've split the fixes in one patch per driver for easier review and handling of
> potential problems. The patches can be squashed together if needed. I've tried
> to CC individual driver maintainers when possible, and Acked-by lines received
> in reply to the first version have been included.
> 
> Compared to v1, I've fixed a couple of subject lines that mentioned the wrong
> driver name, and replaced var->bits_per_pixel in the mx3fb driver.
> 
> Not all patches have been tested on real hardware and acked. Geert Uytterhoeven
> acked the overall idea, and I believe the patches are now ready to be applied.
> 
This seems like a good direction in general, so it's certainly with
proceeding with. I've applied the series to the fbdev/panning-fixes topic
branch, which I will subsequently merge so it's possible to get wider
coverage via -next.

Individual driver authors have had a few weeks to ack/nack accordingly,
so it's fairly reasonable to expect that you're not likely to be
collecting much more feedback before the whole thing gets merged anyways.

If it ends up horribly breaking a number of drivers then it's still
trivial to revert the branch merge and convert drivers incrementally, but
I don't expect that to really be a problem.
