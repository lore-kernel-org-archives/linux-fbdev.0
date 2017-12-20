From: Johannes Thumshirn <jthumshirn@suse.de>
Date: Wed, 20 Dec 2017 11:08:09 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <20171220110809.u7bf6miyiorio6bz@linux-x5ow.site>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
In-Reply-To: <20171219161630.GI26573@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Max Staudt <mstaudt@suse.de>, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, michal@markovi.net, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, bernhard.rosenkranzer@linaro.org, philm@manjaro.org

On Tue, Dec 19, 2017 at 05:16:30PM +0100, Daniel Vetter wrote:
> Ok I've realized that my assumptions about why you need this aren't
> holding up.
>=20
> So from reading these patches it sounded like you want an in-kernel boot
> splash because that would be on the display faster than a userspace one
> like plymouth. That's the only reasons I can see for this (if there's
> another good justification, please bring it up).
>=20
> I only know of very embedded setups (tv top boxes, in vehicle
> entertainment) where that kind of "time to first image" really matters,
> and those systems:
> - have a real hw kms driver
> - don't have fbcon or fbdev emulation enabled (except for some closed
>   source stacks that are a bit slow to adapt to the new world, and we
>   don't care about those in gfx).
>=20
> But from discussions it sounds like you very much want to use this on
> servers, which makes 0 sense to me. On a server something like plymouth
> should do a perfectly reasonable job.

For _one_ reason we'd like to see this is (I was one of the requesters of t=
his
implementation), plymouth in it's infinite wisdom also grabs the serial (IP=
MI)
console and escape characters in a screen log are (you can think of the rest
of this sentence yourself I think).

Also plymouth grabs the escape character of HPE iLOs, which is a serious
no-go. =20

But for several other reasons we can't disable $BOOTSPLASH_IMPLEMENTATION as
we're shipping a general purpose distro and don't know on what hardware it
will be installed.

This is only my peronal view on this situation.

Byte,
	Johannes
--=20
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
