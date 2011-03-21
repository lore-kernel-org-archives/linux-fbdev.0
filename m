From: Corbin Simpson <mostawesomedude@gmail.com>
Date: Mon, 21 Mar 2011 19:34:38 +0000
Subject: Re: Future desktop on dumb frame buffers?
Message-Id: <AANLkTi=kRdC1LoHxqwKxYKZJf99vBEU=OmQoY+zS1dK-@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimJWpebAskcjA+qQUDWXjiH6aHta4fri9z6OxRN@mail.gmail.com>
	<20110321110040.6f1ea6d3@jbarnes-desktop>
	<AANLkTimjOs8ZuKRUt1aOizhbRw2-Ni4bTPty-dKpZ-rz@mail.gmail.com>
	<20110321122518.6b7ec7e4@jbarnes-desktop>
In-Reply-To: <20110321122518.6b7ec7e4@jbarnes-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: timofonic timofonic <timofonic@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org

On Mon, Mar 21, 2011 at 12:25 PM, Jesse Barnes <jbarnes@virtuousgeek.org> w=
rote:
> On Mon, 21 Mar 2011 19:19:43 +0000
> timofonic timofonic <timofonic@gmail.com> wrote:
>> So if KMS is so cool and provides many advantages over fbdev and
>> such... Why isn't more widely used intead of still relying on fbdev?
>> Why still using fbdev emulation (that is partial and somewhat broken,
>> it seems) instead using KMS directly?
>
> Used by what? =A0All three major GPU device classes have KMS support
> (Intel, ATI, and nVidia). =A0If you want it for a particular device, you
> can always port it over.
>
> As for fbdev emulation, what's still using it? =A0There's nothing
> stopping projects from converting over; X and Wayland can already
> handle KMS APIs just fine.
>
>> I know the graphic driver situation is quite bad on Linux, especially
>> on the embedded world. Fbdev seems is still quite used there by binary
>> blob drivers.
>
> Probably for a couple of reasons:
> =A01) inertia: fbdev has been around a lot longer, and provides most of
> =A0what embedded devices need anyway
> =A02) feature set: why bother doing a full KMS driver if you're not
> =A0going to use any of the additional features it would provide (output
> =A0management, memory management, execution management)

Related: We are still missing basic userspace tools (kmsset, e.g.),
some kind of direct KMS console (kmscon would work, if it existed),
and an xf86-video-modesetting which compiles and works (this is
actually possible now, with some patches that landed in 2.6.38 for
generic KMS access.)

This is important to me, as the various old drivers I've been hacking
on won't be accepted upstream without some sort of userspace which can
work with them. One of the big goals of KMS was a generic
userspace-facing API, like FB, but without the suck.

~ C.

--=20
When the facts change, I change my mind. What do you do, sir? ~ Keynes

Corbin Simpson
<MostAwesomeDude@gmail.com>
