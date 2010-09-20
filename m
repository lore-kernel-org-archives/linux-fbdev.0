From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 20 Sep 2010 20:27:57 +0000
Subject: Re: [Patch, RFC] Make struct fb_info ref-counted with kref
Message-Id: <Pine.LNX.4.64.1009202223450.19429@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100919172833.14bf291e@neptune.home> <4C963E99.9080207@gmx.de>
 <20100919190240.65762511@neptune.home> <4C97B079.8050707@gmx.de>
 <Pine.LNX.4.64.1009202118110.19429@axis700.grange> <20100920221424.04150239@neptune.home>
In-Reply-To: <20100920221424.04150239@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bernie Thompson <bernie@plugable.com>

On Mon, 20 Sep 2010, Bruno Pr=C3=A9mont wrote:

> On Mon, 20 September 2010 Guennadi Liakhovetski wrote:
>=20
> > Of course, the optimal solution would be to design and implement a
> > mechanism to notify framebuffer users about a changed fb configuration,
> > but we're not that far yet...
>=20
> This would include ABI change for userspace, hard to get it trough...
> (except maybe if userspace has to opt-in for the notification and kernel
> can thus differentiate the "old" and "new" users)

Yes, something like that...

> But how would you handle userspace apps that can't consume notifications =
right
> away? Do you timeout or risk long stalls?

In the same way as they're currently [1] handled: as long as there are=20
active fb-users, I reconfigure the physical interface but preserve the=20
user configuration, i.e., I either display the smaller user framebuffer on =

a part of the larger display or a part of the larger user framebuffer on=20
the whole smaller display.

[1] http://thread.gmane.org/gmane.linux.ports.sh.devel/8751

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
