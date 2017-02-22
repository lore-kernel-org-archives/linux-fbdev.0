From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 22 Feb 2017 08:52:54 +0000
Subject: Re: [PATCH] backlight: report error on failure
Message-Id: <20170222085254.dgafttyoqzs2fbzh@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1484774630-4228-1-git-send-email-sudipm.mukherjee@gmail.com>
 <588FC682.9040503@gmail.com>
 <58A876EF.1040803@gmail.com>
 <20170219082618.GB30444@wychelm.lan>
 <20170220205241.GA10427@sudip-tp>
In-Reply-To: <20170220205241.GA10427@sudip-tp>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, 20 Feb 2017, Sudip Mukherjee wrote:

> On Sun, Feb 19, 2017 at 08:26:18AM +0000, Daniel Thompson wrote:
> > On Sat, Feb 18, 2017 at 04:31:43PM +0000, Sudip Mukherjee wrote:
> > > On Monday 30 January 2017 11:04 PM, Sudip Mukherjee wrote:
> > > > On Wednesday 18 January 2017 09:23 PM, Sudip Mukherjee wrote:
> > > > > It is possible to update the backlight power and the brightness u=
sing
> > > > > the sysfs and on writing it either returns the count or if the ca=
llback
> > > > > function does not exist then returns the error code 'ENXIO'.
> > > > >=20
> > > > > We have a situation where the userspace client is writing to the =
sysfs
> > > > > to update the power and since the callback function exists the cl=
ient
> > > > > receives the return value as count and considers the operation to=
 be
> > > > > successful. That is correct as the write to the sysfs was success=
ful.
> > > > > But there is no way to know if the actual operation was done or n=
ot.
> > > > >=20
> > > > > backlight_update_status() returns the error code if it fails. Pas=
s that
> > > > > to the userspace client who is trying to update the power so that=
 the
> > > > > client knows that the operation failed.
> > > > >=20
> > > > > Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> > > > > ---
> > > >=20
> > > > A gentle ping.
> > >=20
> > > Hi Andrew,
> > >=20
> > > Its more than one month now that this patch was submitted. Can you pl=
ease
> > > take it through your tree... else it will miss the merge window.
> >=20
> > Sorry you've been waiting so long for a review. Your "gentle ping" did
> > result in a few minor tweaks to the maintainers but what it didn't
> > (until today) provoke was  review!
>=20
> what tweaks? I can see that now you are the new maintainer.Is that the
> result of my ping? :)

Pings never have any effect and are thus always discouraged. ;)

The amount of pending reviews on Backlight patches were what provoked
me to find a new, diligent Maintainer for the subsystem.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
