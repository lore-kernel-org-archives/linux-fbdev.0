From: Jaya Kumar <jayakumar.lkml@gmail.com>
Date: Thu, 27 May 2010 00:21:30 +0000
Subject: Re: Idea of a v4l -> fb interface driver
Message-Id: <AANLkTilnb20a4KO1NmK_y148HE_4b6ka14hUJY5o93QT@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1005261559390.22516@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005261559390.22516@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, May 26, 2010 at 10:09 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Problem: Currently the standard way to provide graphical output on various
> (embedded) displays like LCDs is to use a framebuffer driver. The
> interface is well supported and widely adopted in the user-space, many
> applications, including the X-server, various libraries like directfb,
> gstreamer, mplayer, etc. In the kernel space, however, the subsystem has a
> number of problems. It is unmaintained. The infrastructure is not being
> further developed, every specific hardware driver is being supported by
> the respective architecture community. But as video output hardware

I understand the issue you are raising, but to be clear there are
several developers, Geert, Krzysztof, and others who are helping with
the role of fbdev maintainer while Tony is away. If you meant that it
has no specific currently active maintainer person, when you wrote
"unmaintained", then I agree that is correct. We're not sure where
Tony is and we hope he's okay and that he'll be back soon. But if you
meant that it is not maintained as in bugs aren't being fixed, then
I'd have to slightly disagree. Maybe not as fast as commercial
organizations seem to think should come for free, but still they are
being worked on.

> evolves, more complex displays and buses appear and have to be supported,
> the subsystem shows its aging. For example, there is currently no way to
> write reusable across multiple platforms display drivers.

At first I misread your point as talking about multi-headed displays
which you're correct is not so great in fbdev. But "write reusable
across multi-platform display driver", I did not understand fully. I
maintain a fbdev driver, broadsheetfb, that we're using on arm and x86
without problems and my presumption is other fbdev drivers are also
capable of this unless the author made it explicitly platform
specific. In my experience with adding defio to the fbdev infra, the
fbdev community seemed quite good and I did not notice any aging
problems. I realize there's probably issues that you're encountering
where fbdev might be weak, this is good, and if you raise them
specifically, I think the community can work together to address the
issues.

>
> OTOH V4L2 has a standard video output driver support, it is not very
> widely used, in the userspace I know only of gstreamer, that somehow
> supports video-output v4l2 devices in latest versions. But, being a part
> of the v4l2 subsystem, these drivers already now can take a full advantage
> of all v4l2 APIs, including the v4l2-subdev API for the driver reuse.
>
> So, how can we help graphics driver developers on the one hand by
> providing them with a capable driver framework (v4l2) and on the other
> hand by simplifying the task of interfacing to the user-space?

I think it would help if there were more specific elaborations on the
functionality that you'd want the fbdev community to improve and how
it could reuse v4l2 for this.

>
> How about a v4l2-output - fbdev translation layer? You write a v4l2-output
> driver and get a framebuffer device free of charge... TBH, I haven't given
> this too much of a thought, but so far I don't see anything that would
> make this impossible in principle. The video buffer management is quite
> different between the two systems, but maybe we can teach video-output
> drivers to work with just one buffer too? Anyway, feel free to tell me why
> this is an absolutely impossible / impractical idea;)

Sounds interesting. I think that idea seems viable but I'm not sure
we'd want every usb webcam to register an fbdev interface if that is
part of the thoughts you're having. If you could elaborate on the
benefits, that'd be great.

Thanks,
jaya
