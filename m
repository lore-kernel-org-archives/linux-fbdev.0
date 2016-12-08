From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 08 Dec 2016 21:28:39 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <1481232519.26959.49.camel@kernel.crashing.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <1481158879.26959.41.camel@kernel.crashing.org>
 <20161208101005.6ufl3d4qvwprosju@phenom.ffwll.local>
In-Reply-To: <20161208101005.6ufl3d4qvwprosju@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

On Thu, 2016-12-08 at 11:10 +0100, Daniel Vetter wrote:
> > With drmfb you basically have to shadow everything into memory & copy
> > over everything, and locks you out of simple 2D accel. For a simple text
> > console the result is orders of magnitude slower and memory hungry than
> > a simple fbdev.
>=20
> Not true, we have full fbdev emulation, and drivers can implement the 2d
> accel in there. And a bunch of them do. It's just that most teams decided
> that this is pointless waste of their time.j

Ok so my knowledge might be outdated here. I was complaining to Dave about
how cirrusdrmfb didn't even use blits for fbcon scrolling and always double
buffered everything, and Dave made the point that you basically had to do
that for security reasons that I mostly forgot the details of.

It looks like bochsdrmfb and astdrmfb are the same. If things have changed,
then cool. Can you point me to a drmfb driver that is a good (and not too
complex) example with simple 2d accel ? I'm thinking mostly of color
expansion, bitblt and solid fill for fbcon, the way I used to do it in
radeonfb for example.

> > At least that was the case last I looked at the DRM stuff with Dave,
> > maybe things have changed...=C2=A0
> >=20
> > Not everything has a powerful 3D GPU.
>=20
> That's correct, and drm can cope. And compared to fbdev there's a very
> active community who improves&refactors it every kernel release to make it
> even better. Since about 2 years (when atomic landed) we merge new driver=
s at
> a rate of 2-3 per kernel release, and those new drivers get ever simpler
> and smaller thanks to all this work.

Yeah it's hard to follow from outside :-) As I said above, it would
help if you could point to a good modern example driver to use as
reference.

Thanks !

Cheers,
Ben.

