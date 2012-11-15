From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 15 Nov 2012 15:47:53 +0000
Subject: Re: [PATCH v10 1/6] video: add display_timing and videomode
Message-Id: <20121115154753.C82223E194B@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352971437-29877-1-git-send-email-s.trumtrar@pengutronix.de> <1352971437-29877-2-git-send-email-s.trumtrar@pengutronix.de>
In-Reply-To: <1352971437-29877-2-git-send-email-s.trumtrar@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Guennady Liakhovetski <g.liakhovetski@gmx.de>, linux-media@vger.kernel.org

On Thu, 15 Nov 2012 10:23:52 +0100, Steffen Trumtrar <s.trumtrar@pengutronix.de> wrote:
> Add display_timing structure and the according helper functions. This allows
> the description of a display via its supported timing parameters.
> 
> Every timing parameter can be specified as a single value or a range
> <min typ max>.
> 
> Also, add helper functions to convert from display timings to a generic videomode
> structure. This videomode can then be converted to the corresponding subsystem
> mode representation (e.g. fb_videomode).
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Hmmm... here's my thoughts as an outside reviewer. Correct me if I'm
making an incorrect assumption.

It looks to me that the purpose of this entire series is to decode video
timings from the device tree and (eventually) provide the data in the
form 'struct videomode'. Correct?

If so, then it looks over engineered. Creating new infrastructure to
allocate, maintain, and free a new 'struct display_timings' doesn't make
any sense when it is an intermediary data format that will never be used
by drivers.

Can the DT parsing code instead return a table of struct videomode?

But, wait... struct videomode is also a new structure. So it looks like
this series creates two new intermediary data structures;
display_timings and videomode. And at least as far as I can see in this
series struct fb_videomode is the only user.

g.

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
