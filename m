From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Mar 2011 19:50:20 +0000
Subject: Re: Future desktop on dumb frame buffers?
Message-Id: <AANLkTikAeQ=z-M3kW2zPgVRK-bmoiTeA5ktjjTokEybW@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimJWpebAskcjA+qQUDWXjiH6aHta4fri9z6OxRN@mail.gmail.com>
	<20110321110040.6f1ea6d3@jbarnes-desktop>
	<AANLkTimjOs8ZuKRUt1aOizhbRw2-Ni4bTPty-dKpZ-rz@mail.gmail.com>
	<20110321122518.6b7ec7e4@jbarnes-desktop>
In-Reply-To: <20110321122518.6b7ec7e4@jbarnes-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: timofonic timofonic <timofonic@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org

On Mon, Mar 21, 2011 at 20:25, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> On Mon, 21 Mar 2011 19:19:43 +0000
> timofonic timofonic <timofonic@gmail.com> wrote:
>> So if KMS is so cool and provides many advantages over fbdev and
>> such... Why isn't more widely used intead of still relying on fbdev?
>> Why still using fbdev emulation (that is partial and somewhat broken,
>> it seems) instead using KMS directly?
>
> Used by what?  All three major GPU device classes have KMS support
> (Intel, ATI, and nVidia).  If you want it for a particular device, you
> can always port it over.

The three major GPU device classes on PC...

> As for fbdev emulation, what's still using it?  There's nothing
> stopping projects from converting over; X and Wayland can already
> handle KMS APIs just fine.

Can Wayland handle fbdev APIs ...

>> I know the graphic driver situation is quite bad on Linux, especially
>> on the embedded world. Fbdev seems is still quite used there by binary
>> blob drivers.
>
> Probably for a couple of reasons:
>  1) inertia: fbdev has been around a lot longer, and provides most of
>  what embedded devices need anyway
>  2) feature set: why bother doing a full KMS driver if you're not
>  going to use any of the additional features it would provide (output
>  management, memory management, execution management)

... if no additional features of KMS are needed?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
