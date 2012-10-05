From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 05 Oct 2012 11:37:43 +0000
Subject: Re: [PATCH 04/14] media: add V4L2 DT binding documentation
Message-Id: <Pine.LNX.4.64.1210051335390.13761@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
 <506CA5F7.3060807@gmail.com> <Pine.LNX.4.64.1210051119420.13761@axis700.grange>
 <201210051331.18586.hverkuil@xs4all.nl>
In-Reply-To: <201210051331.18586.hverkuil@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Rob Herring <robherring2@gmail.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-sh@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Robert Schwebel <r.schwebel@pengutronix.de>, Philipp Zabel <pza@pengutronix.de>

On Fri, 5 Oct 2012, Hans Verkuil wrote:

> On Fri October 5 2012 11:43:27 Guennadi Liakhovetski wrote:
> > On Wed, 3 Oct 2012, Rob Herring wrote:
> > 
> > > On 10/02/2012 09:33 AM, Guennadi Liakhovetski wrote:
> > > > Hi Rob
> > > > 
> > > > On Tue, 2 Oct 2012, Rob Herring wrote:
> > > > 
> > > >> On 09/27/2012 09:07 AM, Guennadi Liakhovetski wrote:

[snip]

> > > >>> +Optional link properties:
> > > >>> +- remote: phandle to the other endpoint link DT node.
> > > >>
> > > >> This name is a little vague. Perhaps "endpoint" would be better.
> > > > 
> > > > "endpoint" can also refer to something local like in USB case. Maybe 
> > > > rather the description of the "remote" property should be improved?
> > > 
> > > remote-endpoint?
> > 
> > Sorry, I really don't want to pull in yet another term here. We've got 
> > ports and links already, now you're proposing to also use "endpoind." 
> > Until now everyone was happy with "remote," any more opinions on this?
> 
> Actually, when I was reviewing the patch series today I got confused as
> well by 'remote'. What about 'remote-link'?

Yes, I was thinking about this one too, it looks a bit clumsy, but it does 
make it clearer, what is meant.

> And v4l2_of_get_remote() can be renamed to v4l2_of_get_remote_link() which
> I think is a lot clearer.
> 
> The text can be improved as well since this:
> 
> - remote: phandle to the other endpoint link DT node.
> 
> is a bit vague. How about:
> 
> - remote-link: phandle to the remote end of this link.

Looks good to me.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
