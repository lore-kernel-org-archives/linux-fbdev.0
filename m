From: Jun Nie <niej0001@gmail.com>
Date: Mon, 08 Nov 2010 05:43:33 +0000
Subject: Re: V4L2 and framebuffer for the same controller
Message-Id: <AANLkTikww_o+L0hS8jFhL+u2EGvZMQPogY_F89Kcm1xT@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTikJNdcnRbNwv4j8zfv4TfSqOgB2K=UD4UFfL=q4@mail.gmail.com>
	<Pine.LNX.4.64.1011020821300.3804@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1011020821300.3804@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-media <linux-media@vger.kernel.org>, linux-fbdev@vger.kernel.org

2010/11/2 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
> Hi Jun
>
> On Fri, 29 Oct 2010, Jun Nie wrote:
>
>> Hi Guennadi,
>> =A0 =A0 I find that your idea of "provide a generic framebuffer driver
>> that could sit on top of a v4l output driver", which may be a good
>> solution of our LCD controller driver, or maybe much more other SOC
>> LCD drivers. V4L2 interface support many features than framebuffer for
>> video playback usage, such as buffer queue/dequeue, quality control,
>> etc. However, framebuffer is common for UI display. Implement two
>> drivers for one controller is a challenge for current architecture.
>> =A0 =A0 I am interested in your idea. Could you elaborate it? Or do you
>> think multifunction driver is the right solution for this the
>> scenario?
>
> Right, we have discussed this idea at the V4L2/MC mini-summit earlier this
> year, there the outcome was, that the idea is not bad, but it is easy
> enough to create such framebuffer additions on top of specific v4l2 output
> drivers anyway, so, noone was interested enough to start designing and
> implementing such a generic wrapper driver. However, I've heard, that this
> topic has also been scheduled for discussion at another v4l / kernel
> meeting (plumbers?), so, someone might be looking into implementing
> this... If you yourself would like to do that - feel free to propose a
> design on both mailing lists (fbdev added to cc), then we can discuss it,
> and you can implement it;)
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>

Good to know others are also interested in it. I surely can contribute
to it. But my concern is how to support Xwindow. Android and Ubuntu
should both run on our platform. Queue/deque should work well for
Android UI. I still can not figure out how to support Xwindow, for it
does not interact with driver after it get the mmaped buffer.

Jun
