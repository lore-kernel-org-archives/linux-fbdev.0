From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Mar 2011 21:46:27 +0000
Subject: Re: Future desktop on dumb frame buffers?
Message-Id: <AANLkTikEGDtNYu4f6z=ipUiJS8oQRAFxDaT+KgB6G74M@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimJWpebAskcjA+qQUDWXjiH6aHta4fri9z6OxRN@mail.gmail.com>
	<20110321122518.6b7ec7e4@jbarnes-desktop>
	<AANLkTi=kRdC1LoHxqwKxYKZJf99vBEU=OmQoY+zS1dK-@mail.gmail.com>
	<201103212213.51565.linux@rainbow-software.org>
In-Reply-To: <201103212213.51565.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, timofonic timofonic <timofonic@gmail.com>, dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org

On Mon, Mar 21, 2011 at 5:13 PM, Ondrej Zary <linux@rainbow-software.org> w=
rote:
> On Monday 21 March 2011 20:34:38 Corbin Simpson wrote:
>> On Mon, Mar 21, 2011 at 12:25 PM, Jesse Barnes <jbarnes@virtuousgeek.org>
> wrote:
>> > On Mon, 21 Mar 2011 19:19:43 +0000
>> >
>> > timofonic timofonic <timofonic@gmail.com> wrote:
>> >> So if KMS is so cool and provides many advantages over fbdev and
>> >> such... Why isn't more widely used intead of still relying on fbdev?
>> >> Why still using fbdev emulation (that is partial and somewhat broken,
>> >> it seems) instead using KMS directly?
>> >
>> > Used by what? =A0All three major GPU device classes have KMS support
>> > (Intel, ATI, and nVidia). =A0If you want it for a particular device, y=
ou
>> > can always port it over.
>> >
>> > As for fbdev emulation, what's still using it? =A0There's nothing
>> > stopping projects from converting over; X and Wayland can already
>> > handle KMS APIs just fine.
>> >
>> >> I know the graphic driver situation is quite bad on Linux, especially
>> >> on the embedded world. Fbdev seems is still quite used there by binary
>> >> blob drivers.
>> >
>> > Probably for a couple of reasons:
>> > =A01) inertia: fbdev has been around a lot longer, and provides most of
>> > =A0what embedded devices need anyway
>> > =A02) feature set: why bother doing a full KMS driver if you're not
>> > =A0going to use any of the additional features it would provide (output
>> > =A0management, memory management, execution management)
>>
>> Related: We are still missing basic userspace tools (kmsset, e.g.),
>> some kind of direct KMS console (kmscon would work, if it existed),
>> and an xf86-video-modesetting which compiles and works (this is
>> actually possible now, with some patches that landed in 2.6.38 for
>> generic KMS access.)
>
> This looks interesting. If existing *fb drivers could be easily converted=
 to
> KMS (including 2D acceleration) and then used in X with a common driver, =
it
> would be great. Let's say, convert cyber2000fb driver to KMS and use it i=
n X
> with 2D acceleration.

You'd need to update the existing DDX to work with KMS.  Generally you
need some sort of userspace driver to allocate the buffers, deal with
acceleration alignment, build the acceleration command buffers, and
interface with X.

Alex

>
>> This is important to me, as the various old drivers I've been hacking
>> on won't be accepted upstream without some sort of userspace which can
>> work with them. One of the big goals of KMS was a generic
>> userspace-facing API, like FB, but without the suck.
>
>
> --
> Ondrej Zary
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
