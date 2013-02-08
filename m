From: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
Date: Fri, 08 Feb 2013 12:43:32 +0000
Subject: Re: [RFC v2 0/5] Common Display Framework
Message-Id: <5114F2F4.5040702@stericsson.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353620736-6517-1-git-send-email-laurent.pinchart@ideasonboard.com> <1987992.4TmVjQaiLj@amdc1227> <50EC5283.80006@stericsson.com> <3057999.UZLp2j2DkQ@avalon> <510F8807.2020406@stericsson.com> <5114D8A2.6010806@ti.com>
In-Reply-To: <5114D8A2.6010806@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomasz Figa <t.figa@samsung.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Tom Gall <tom.gall@linaro.org>, Ragesh Radhakrishnan <Ragesh.R@linaro.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Rob Clark <rob.clark@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, sunil joshi <joshi@samsung.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Bryan Wu <bryan.wu@canonical.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Vikas Sajjan <vikas.sajjan@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Sebastien Guiriec <s-guiriec@ti.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>

On 02/08/2013 11:51 AM, Tomi Valkeinen wrote:
> On 2013-02-04 12:05, Marcus Lorentzon wrote:
>
>> As discussed at FOSDEM I will give DSI bus with full feature set a
>> try.
> Please do, but as a reminder I want to raise the issues I see with a DSI
> bus:
>
> - A device can be a child of only one bus. So if DSI is used only for
> video, the device is a child of, say, i2c bus, and thus there's no DSI
> bus. How to configure and use DSI in this case?
>
> - If DSI is used for both control and video, we have two separate APIs
> for the bus. What I mean here is that for the video-only case above, we
> need a video-only-API for DSI. This API should contain all necessary
> methods to configure DSI. But we need similar methods for the control
> API also.
>
> So, I hope you come up with some solution for this, but as I see it,
> it's easily the most simple and clear option to have one video_source
> style entity for the DSI bus itself, which is used for both control and
> video.
>
>
Thanks, it is not that I'm totally against the video source stuff. And I 
share your concerns, none of the solutions are perfect. It just doesn't 
feel right to create this dummy source "device" without investigating 
the DSI bus route. But I will try to write up some history/problem 
description and ask Greg KH for guidance. If he has a strong opinion 
either way, there is not much more to discuss ;)

/BR
/Marcus

