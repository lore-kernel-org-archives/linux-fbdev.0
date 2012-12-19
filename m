From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Wed, 19 Dec 2012 14:57:56 +0000
Subject: Re: [RFC v2 0/5] Common Display Framework
Message-Id: <87pq26ay2z.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353620736-6517-1-git-send-email-laurent.pinchart@ideasonboard.com> <1608840.IleINgrx5J@avalon> <87pq28hb72.fsf@intel.com> <1671267.x0lxGrFjjV@avalon>
In-Reply-To: <1671267.x0lxGrFjjV@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Tom Gall <tom.gall@linaro.org>, Ragesh Radhakrishnan <ragesh.r@linaro.org>, dri-devel@lists.freedesktop.org, Rob Clark <rob.clark@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Bryan Wu <bryan.wu@canonical.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Vikas Sajjan <vikas.sajjan@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Sebastien Guiriec <s-guiriec@ti.com>, linux-media@vger.kernel.org


Hi Laurent -

On Tue, 18 Dec 2012, Laurent Pinchart <laurent.pinchart@ideasonboard.com> w=
rote:
> Hi Jani,
>
> On Monday 17 December 2012 18:53:37 Jani Nikula wrote:
>> I can see the need for a framework for DSI panels and such (in fact Tomi
>> and I have talked about it like 2-3 years ago already!) but what is the
>> story for HDMI and DP? In particular, what's the relationship between
>> DRM and CDF here? Is there a world domination plan to switch the DRM
>> drivers to use this framework too? ;) Do you have some rough plans how
>> DRM and CDF should work together in general?
>
> There's always a world domination plan, isn't there ? :-)
>
> I certainly want CDF to be used by DRM (or more accurately KMS). That's w=
hat=20
> the C stands for, common refers to sharing panel and other display entity=
=20
> drivers between FBDEV, KMS and V4L2.
>
> I currently have no plan to expose CDF internals to userspace through the=
 KMS=20
> API. We might have to do so later if the hardware complexity grows in suc=
h a=20
> way that finer control than what KMS provides needs to be exposed to=20
> userspace, but I don't think we're there yet. The CDF API will thus only =
be=20
> used internally in the kernel by display controller drivers. The KMS core=
=20
> might get functions to handle common display entity operations, but the b=
ulk=20
> of the work will be in the display controller drivers to start with. We w=
ill=20
> then see what can be abstracted in KMS helper functions.
>
> Regarding HDMI and DP, I imagine HDMI and DP drivers that would use the C=
DF=20
> API. That's just a thought for now, I haven't tried to implement them, bu=
t it=20
> would be nice to handle HDMI screens and DPI/DBI/DSI panels in a generic =
way.
>
> Do you have thoughts to share on this topic ?

It just seems to me that, at least from a DRM/KMS perspective, adding
another layer (=CDF) for HDMI or DP (or legacy outputs) would be
overengineering it. They are pretty well standardized, and I don't see
there would be a need to write multiple display drivers for them. Each
display controller has one, and can easily handle any chip specific
requirements right there. It's my gut feeling that an additional
framework would just get in the way. Perhaps there could be more common
HDMI/DP helper style code in DRM to reduce overlap across KMS drivers,
but that's another thing.

So is the HDMI/DP drivers using CDF a more interesting idea from a
non-DRM perspective? Or, put another way, is it more of an alternative
to using DRM? Please enlighten me if there's some real benefit here that
I fail to see!

For DSI panels (or DSI-to-whatever bridges) it's of course another
story. You typically need a panel specific driver. And here I see the
main point of the whole CDF: decoupling display controllers and the
panel drivers, and sharing panel (and converter chip) specific drivers
across display controllers. Making it easy to write new drivers, as
there would be a model to follow. I'm definitely in favour of coming up
with some framework that would tackle that.


BR,
Jani.
