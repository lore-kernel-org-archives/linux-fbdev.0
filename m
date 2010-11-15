From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 15 Nov 2010 07:23:27 +0000
Subject: Re: V4L2 and framebuffer for the same controller
Message-Id: <Pine.LNX.4.64.1011150816240.32257@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTikJNdcnRbNwv4j8zfv4TfSqOgB2K=UD4UFfL=q4@mail.gmail.com>
 <Pine.LNX.4.64.1011020821300.3804@axis700.grange>
 <AANLkTikww_o+L0hS8jFhL+u2EGvZMQPogY_F89Kcm1xT@mail.gmail.com>
 <AANLkTikOdktmvDS0eXof-JCBT_6k=HKHSCYkR2Mu3v9d@mail.gmail.com>
In-Reply-To: <AANLkTikOdktmvDS0eXof-JCBT_6k=HKHSCYkR2Mu3v9d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jun Nie <niej0001@gmail.com>
Cc: linux-media <linux-media@vger.kernel.org>, linux-fbdev@vger.kernel.org

On Mon, 15 Nov 2010, Jun Nie wrote:

> 2010/11/8 Jun Nie <niej0001@gmail.com>:
> > 2010/11/2 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
> >> Hi Jun
> >>
> >> On Fri, 29 Oct 2010, Jun Nie wrote:
> >>
> >>> Hi Guennadi,
> >>> =A0 =A0 I find that your idea of "provide a generic framebuffer driver
> >>> that could sit on top of a v4l output driver", which may be a good
> >>> solution of our LCD controller driver, or maybe much more other SOC
> >>> LCD drivers. V4L2 interface support many features than framebuffer for
> >>> video playback usage, such as buffer queue/dequeue, quality control,
> >>> etc. However, framebuffer is common for UI display. Implement two
> >>> drivers for one controller is a challenge for current architecture.
> >>> =A0 =A0 I am interested in your idea. Could you elaborate it? Or do y=
ou
> >>> think multifunction driver is the right solution for this the
> >>> scenario?
> >>
> >> Right, we have discussed this idea at the V4L2/MC mini-summit earlier =
this
> >> year, there the outcome was, that the idea is not bad, but it is easy
> >> enough to create such framebuffer additions on top of specific v4l2 ou=
tput
> >> drivers anyway, so, noone was interested enough to start designing and
> >> implementing such a generic wrapper driver. However, I've heard, that =
this
> >> topic has also been scheduled for discussion at another v4l / kernel
> >> meeting (plumbers?), so, someone might be looking into implementing
> >> this... If you yourself would like to do that - feel free to propose a
> >> design on both mailing lists (fbdev added to cc), then we can discuss =
it,
> >> and you can implement it;)
> >>
> >> Thanks
> >> Guennadi
> >> ---
> >> Guennadi Liakhovetski, Ph.D.
> >> Freelance Open-Source Software Developer
> >> http://www.open-technology.de/
> >>
> >
> > Good to know others are also interested in it. I surely can contribute
> > to it. But my concern is how to support Xwindow. Android and Ubuntu
> > should both run on our platform. Queue/deque should work well for
> > Android UI. I still can not figure out how to support Xwindow, for it
> > does not interact with driver after it get the mmaped buffer.
> >
> > Jun
> >
>=20
> Guennadi,
>=20
> Any idea on supporting this feature with V4L2 based FB? I can not
> figure out any method and will adopt framebuffer for UI and V4L2 for
> video layer for the schedule pressure.

Hi Jun

Sorry, not sure I understand you right here. You are saying, that atm you=20
don't have the time to work on a generic solution and are going for a=20
specific one, right? Yes, that's what everybody is currently doing. And=20
you're asking whether I am working or am going to work on such a generic=20
solution? No, sorry, I don't think I'll have time for it either in the=20
near future.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
