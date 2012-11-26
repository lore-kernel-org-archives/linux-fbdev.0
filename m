From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 26 Nov 2012 07:53:40 +0000
Subject: Re: [RFC v2 0/5] Common Display Framework
Message-Id: <1353916420.2636.6.camel@pizza.hi.pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353620736-6517-1-git-send-email-laurent.pinchart@ideasonboard.com>
	 <20121123195607.GA20990@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20121123195607.GA20990@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Tom Gall <tom.gall@linaro.org>, Ragesh Radhakrishnan <ragesh.r@linaro.org>, Rob Clark <rob.clark@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Bryan Wu <bryan.wu@canonical.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Vikas Sajjan <vikas.sajjan@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Sebastien Guiriec <s-guiriec@ti.com>, linux-media@vger.kernel.org

Hi Thierry,

Am Freitag, den 23.11.2012, 20:56 +0100 schrieb Thierry Reding:
> On Thu, Nov 22, 2012 at 10:45:31PM +0100, Laurent Pinchart wrote:
> [...]
> > Display entities are accessed by driver using notifiers. Any driver can
> > register a display entity notifier with the CDF, which then calls the notifier
> > when a matching display entity is registered. The reason for this asynchronous
> > mode of operation, compared to how drivers acquire regulator or clock
> > resources, is that the display entities can use resources provided by the
> > display driver. For instance a panel can be a child of the DBI or DSI bus
> > controlled by the display device, or use a clock provided by that device. We
> > can't defer the display device probe until the panel is registered and also
> > defer the panel device probe until the display is registered. As most display
> > drivers need to handle output devices hotplug (HDMI monitors for instance),
> > handling other display entities through a notification system seemed to be the
> > easiest solution.
> > 
> > Note that this brings a different issue after registration, as display
> > controller and display entity drivers would take a reference to each other.
> > Those circular references would make driver unloading impossible. One possible
> > solution to this problem would be to simulate an unplug event for the display
> > entity, to force the display driver to release the dislay entities it uses. We
> > would need a userspace API for that though. Better solutions would of course
> > be welcome.
> 
> Maybe I don't understand all of the underlying issues correctly, but a
> parent/child model would seem like a better solution to me. We discussed
> this back when designing the DT bindings for Tegra DRM and came to the
> conclusion that the output resource of the display controller (RGB,
> HDMI, DSI or TVO) was the most suitable candidate to be the parent of
> the panel or display attached to it. The reason for that decision was
> that it keeps the flow of data or addressing of nodes consistent. So the
> chain would look something like this (on Tegra):
> 
> 	CPU
> 	+-host1x
> 	  +-dc
> 	    +-rgb
> 	    | +-panel
> 	    +-hdmi
> 	      +-monitor
> 
> In a natural way this makes the output resource the master of the panel
> or display. From a programming point of view this becomes quite easy to
> implement and is very similar to how other busses like I2C or SPI are
> modelled. In device tree these would be represented as subnodes, while
> with platform data some kind of lookup could be done like for regulators
> or alternatively a board setup registration mechanism like what's in
> place for I2C or SPI.

I second Tomi's answer. Also, describing data bus connections implicitly
with parent/child relationships doesn't work for entities with multiple
inputs. Imagine there are multiple dc's in the above diagram, and the
single hdmi encoder can be connected to either of them via multiplexing.

regards
Philipp

