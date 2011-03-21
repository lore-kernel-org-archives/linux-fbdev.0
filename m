From: Ondrej Zary <linux@rainbow-software.org>
Date: Mon, 21 Mar 2011 21:13:44 +0000
Subject: Re: Future desktop on dumb frame buffers?
Message-Id: <201103212213.51565.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimJWpebAskcjA+qQUDWXjiH6aHta4fri9z6OxRN@mail.gmail.com>
	<20110321122518.6b7ec7e4@jbarnes-desktop>
	<AANLkTi=kRdC1LoHxqwKxYKZJf99vBEU=OmQoY+zS1dK-@mail.gmail.com>
In-Reply-To: <AANLkTi=kRdC1LoHxqwKxYKZJf99vBEU=OmQoY+zS1dK-@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, wayland-devel@lists.freedesktop.org, Geert Uytterhoeven <geert@linux-m68k.org>, timofonic timofonic <timofonic@gmail.com>

On Monday 21 March 2011 20:34:38 Corbin Simpson wrote:
> On Mon, Mar 21, 2011 at 12:25 PM, Jesse Barnes <jbarnes@virtuousgeek.org>=
=20
wrote:
> > On Mon, 21 Mar 2011 19:19:43 +0000
> >
> > timofonic timofonic <timofonic@gmail.com> wrote:
> >> So if KMS is so cool and provides many advantages over fbdev and
> >> such... Why isn't more widely used intead of still relying on fbdev?
> >> Why still using fbdev emulation (that is partial and somewhat broken,
> >> it seems) instead using KMS directly?
> >
> > Used by what? =A0All three major GPU device classes have KMS support
> > (Intel, ATI, and nVidia). =A0If you want it for a particular device, you
> > can always port it over.
> >
> > As for fbdev emulation, what's still using it? =A0There's nothing
> > stopping projects from converting over; X and Wayland can already
> > handle KMS APIs just fine.
> >
> >> I know the graphic driver situation is quite bad on Linux, especially
> >> on the embedded world. Fbdev seems is still quite used there by binary
> >> blob drivers.
> >
> > Probably for a couple of reasons:
> > =A01) inertia: fbdev has been around a lot longer, and provides most of
> > =A0what embedded devices need anyway
> > =A02) feature set: why bother doing a full KMS driver if you're not
> > =A0going to use any of the additional features it would provide (output
> > =A0management, memory management, execution management)
>
> Related: We are still missing basic userspace tools (kmsset, e.g.),
> some kind of direct KMS console (kmscon would work, if it existed),
> and an xf86-video-modesetting which compiles and works (this is
> actually possible now, with some patches that landed in 2.6.38 for
> generic KMS access.)

This looks interesting. If existing *fb drivers could be easily converted t=
o=20
KMS (including 2D acceleration) and then used in X with a common driver, it=
=20
would be great. Let's say, convert cyber2000fb driver to KMS and use it in =
X=20
with 2D acceleration.

> This is important to me, as the various old drivers I've been hacking
> on won't be accepted upstream without some sort of userspace which can
> work with them. One of the big goals of KMS was a generic
> userspace-facing API, like FB, but without the suck.


--=20
Ondrej Zary
