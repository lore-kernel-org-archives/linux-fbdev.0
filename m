From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Mar 2011 20:08:36 +0000
Subject: Re: Future desktop on dumb frame buffers?
Message-Id: <AANLkTimqkA7GGdT52Ys0b+346Pxr3A=PtDpY0nJ+ycVO@mail.gmail.com>
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
Cc: dri-devel@lists.freedesktop.org, timofonic timofonic <timofonic@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, wayland-devel@lists.freedesktop.org

On Mon, Mar 21, 2011 at 3:50 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Mar 21, 2011 at 20:25, Jesse Barnes <jbarnes@virtuousgeek.org> wr=
ote:
>> On Mon, 21 Mar 2011 19:19:43 +0000
>> timofonic timofonic <timofonic@gmail.com> wrote:
>>> So if KMS is so cool and provides many advantages over fbdev and
>>> such... Why isn't more widely used intead of still relying on fbdev?
>>> Why still using fbdev emulation (that is partial and somewhat broken,
>>> it seems) instead using KMS directly?
>>
>> Used by what? =A0All three major GPU device classes have KMS support
>> (Intel, ATI, and nVidia). =A0If you want it for a particular device, you
>> can always port it over.
>
> The three major GPU device classes on PC...

Sadly it gets worse.  A lot of the SoC vendors are adding an fbdev
emulation layer on top of v4l rather than using fbdev directly or
using KMS and v4l has grown it's own edid, hdmi, and cec handling.

Alex

>
>> As for fbdev emulation, what's still using it? =A0There's nothing
>> stopping projects from converting over; X and Wayland can already
>> handle KMS APIs just fine.
>
> Can Wayland handle fbdev APIs ...
>
>>> I know the graphic driver situation is quite bad on Linux, especially
>>> on the embedded world. Fbdev seems is still quite used there by binary
>>> blob drivers.
>>
>> Probably for a couple of reasons:
>> =A01) inertia: fbdev has been around a lot longer, and provides most of
>> =A0what embedded devices need anyway
>> =A02) feature set: why bother doing a full KMS driver if you're not
>> =A0going to use any of the additional features it would provide (output
>> =A0management, memory management, execution management)
>
> ... if no additional features of KMS are needed?
>
> Gr{oetje,eeting}s,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 =A0=A0 -- Linu=
s Torvalds
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
