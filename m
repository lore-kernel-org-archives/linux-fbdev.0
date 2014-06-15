From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 15 Jun 2014 08:57:48 +0000
Subject: Re: console / fbdev: fbcon support for bits_per_pixel = 1?
Message-Id: <CAMuHMdXMWFXG99iiuk1j=0DaQbWbmcpGxaTfDNX8o+Dz7MH7aw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <539C1C1F.5060904@biereigel.de>
	<20140614143550.59367463@neptune.home>
In-Reply-To: <20140614143550.59367463@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: Stefan Biereigel <stefan@biereigel.de>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-console@vger.kernel.org, brian <brian.fonfara@gmx.de>

On Sat, Jun 14, 2014 at 2:35 PM, Bruno Pr=C3=A9mont
<bonbons@linux-vserver.org> wrote:
>> Is this behavior intended or are we triggering a bug here (that no one n=
oticed, because
>> who in the world uses monochrome framebuffers these days..). I can't see=
 any comments that
>> monochrome consoles should not work with 1 bit per pixel. See the code b=
elow if you spot
>> some errors (ignore some missing error handling and mediocre style for n=
ow, please).
>
> fbcon on 1bpp frambuffer worked for me with picoLCD (though I have found =
no userspace

I'm not aware of 1 bpp frame buffer consoles being broken.

> framebuffer application willing to operate at 1bpp).

Xfbdev does. I revived support for monochrome (and Atari/Amiga-style
bitplanes) last year.

And of course
https://git.kernel.org/cgit/linux/kernel/git/geert/fbtest.git/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
