From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 26 Nov 2012 14:47:08 +0000
Subject: Re: [RFC v2 0/5] Common Display Framework
Message-Id: <20121126144708.3daec09e@pyramind.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353620736-6517-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<20121123195607.GA20990@avionic-0098.adnet.avionic-design.de>
	<50B07427.1010605@ti.com>
In-Reply-To: <50B07427.1010605@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Tom Gall <tom.gall@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, dri-devel@lists.freedesktop.org, Rob Clark <rob.clark@linaro.org>, Ragesh Radhakrishnan <ragesh.r@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, Bryan Wu <bryan.wu@canonical.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Vikas Sajjan <vikas.sajjan@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Sebastien Guiriec <s-guiriec@ti.com>, linux-media@vger.kernel.org

On Sat, 24 Nov 2012 09:15:51 +0200
Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> On 2012-11-23 21:56, Thierry Reding wrote:
> > On Thu, Nov 22, 2012 at 10:45:31PM +0100, Laurent Pinchart wrote:
> > [...]
> >> Display entities are accessed by driver using notifiers. Any driver can
> >> register a display entity notifier with the CDF, which then calls the notifier
> >> when a matching display entity is registered.

The framebuffer layer has some similar 'anyone can' type notifier
behaviour and its not a good thing. That kind of "any one can" behaviour
leads to some really horrible messes unless the connections and the
locking are well defined IMHO.

Alan
