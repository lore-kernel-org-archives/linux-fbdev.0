From: Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Mon, 21 Mar 2011 19:56:05 +0000
Subject: Re: Future desktop on dumb frame buffers?
Message-Id: <20110321125605.15aa6a04@jbarnes-desktop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimJWpebAskcjA+qQUDWXjiH6aHta4fri9z6OxRN@mail.gmail.com>
	<20110321110040.6f1ea6d3@jbarnes-desktop>
	<AANLkTimjOs8ZuKRUt1aOizhbRw2-Ni4bTPty-dKpZ-rz@mail.gmail.com>
	<20110321122518.6b7ec7e4@jbarnes-desktop>
	<AANLkTikAeQ=z-M3kW2zPgVRK-bmoiTeA5ktjjTokEybW@mail.gmail.com>
In-Reply-To: <AANLkTikAeQ=z-M3kW2zPgVRK-bmoiTeA5ktjjTokEybW@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: timofonic timofonic <timofonic@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org

On Mon, 21 Mar 2011 20:50:20 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Mon, Mar 21, 2011 at 20:25, Jesse Barnes <jbarnes@virtuousgeek.org> wr=
ote:
> > On Mon, 21 Mar 2011 19:19:43 +0000
> > timofonic timofonic <timofonic@gmail.com> wrote:
> >> So if KMS is so cool and provides many advantages over fbdev and
> >> such... Why isn't more widely used intead of still relying on fbdev?
> >> Why still using fbdev emulation (that is partial and somewhat broken,
> >> it seems) instead using KMS directly?
> >
> > Used by what? =A0All three major GPU device classes have KMS support
> > (Intel, ATI, and nVidia). =A0If you want it for a particular device, you
> > can always port it over.
>=20
> The three major GPU device classes on PC...

Yes, good point. :)

> > As for fbdev emulation, what's still using it? =A0There's nothing
> > stopping projects from converting over; X and Wayland can already
> > handle KMS APIs just fine.
>=20
> Can Wayland handle fbdev APIs ...

Yes.  Fundamentally, the Wayland protocol just assumes a way to share
buffers between processes.  For the software raster version of the Qt
port, Kristian created a shmem interface for doing that to allow the
results of CPU rendering to be passed around without copying.  On an
embedded device that would be one way to go.

--=20
Jesse Barnes, Intel Open Source Technology Center
