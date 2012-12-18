From: Dave Airlie <airlied@gmail.com>
Date: Tue, 18 Dec 2012 05:04:02 +0000
Subject: Re: [RFC v2 0/5] Common Display Framework
Message-Id: <CAPM=9txFJzJ0haTyBnr8hEmmqNb+gSAyBno+Zs0Z-qvVMTwz9A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353620736-6517-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1353620736-6517-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Tom Gall <tom.gall@linaro.org>, Ragesh Radhakrishnan <ragesh.r@linaro.org>, dri-devel@lists.freedesktop.org, Rob Clark <rob.clark@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Bryan Wu <bryan.wu@canonical.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Vikas Sajjan <vikas.sajjan@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Sebastien Guiriec <s-guiriec@ti.com>, linux-media@vger.kernel.org

>
> Many developers showed interest in the first RFC, and I've had the opportunity
> to discuss it with most of them. I would like to thank (in no particular
> order) Tomi Valkeinen for all the time he spend helping me to draft v2, Marcus
> Lorentzon for his useful input during Linaro Connect Q4 2012, and Linaro for
> inviting me to Connect and providing a venue to discuss this topic.
>

So this might be a bit off topic but this whole CDF triggered me
looking at stuff I generally avoid:

The biggest problem I'm having currently with the whole ARM graphics
and output world is the proliferation of platform drivers for every
little thing. The whole ordering of operations with respect to things
like suspend/resume or dynamic power management is going to be a real
nightmare if there are dependencies between the drivers. How do you
enforce ordering of s/r operations between all the various components?

The other thing I'd like you guys to do is kill the idea of fbdev and
v4l drivers that are "shared" with the drm codebase, really just
implement fbdev and v4l on top of the drm layer, some people might
think this is some sort of maintainer thing, but really nothing else
makes sense, and having these shared display frameworks just to avoid
having using drm/kms drivers seems totally pointless. Fix the drm
fbdev emulation if an fbdev interface is needed. But creating a fourth
framework because our previous 3 frameworks didn't work out doesn't
seem like a situation I want to get behind too much.

Dave.
