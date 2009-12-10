From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 Dec 2009 19:55:39 +0000
Subject: Re: conflicts between fbcon and user-mode fbdev clients
Message-Id: <10f740e80912101155uad00e1atc8a12fea3be3e5df@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <480988180912091352v77fa9a12s5077b3211c13586b@mail.gmail.com>
In-Reply-To: <480988180912091352v77fa9a12s5077b3211c13586b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Thu, Dec 10, 2009 at 20:43, Bernie Thompson <bernie@plugable.com> wrote:
> On Thu, Dec 10, 2009 at 11:02 AM, James Simmons <jsimmons@infradead.org> wrote:
>> That shouldn't happen. In the xorg.conf do you have in the
>>
>> Option UseFBDev "True"
>
> That option appears to have no effect (have tried both ways).  Do you
> know who parses it?  Couldn't find it in core xserver.
>
> The DisplayLink support is still very rough, but it's currently using
> its own X server driver
> (http://libdlo.freedesktop.org/wiki/xf86-driver-displaylink), which
> has some IOCTLs to its framebuffer driver, including a mode setting
> IOCTL.
>
> If the arbitration between fbdev clients is intended to happen at the
> point of mode setting, rather than at open(), that would explain the
> problem.  Are there any old posts or docs which describe how
> arbitration is handled for the fbdev driver and multiple clients?

Usually the X server locks the VT (virtual terminal) using an ioctl,
and uses another ioctl to switch the VT to graphics mode, so fbcon
will stop drawing to it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
