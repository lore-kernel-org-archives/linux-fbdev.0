From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Jul 2013 07:43:56 +0000
Subject: Re: [PATCH] logo: Remove trailing whitespace from logo_linux_clut224.ppm
Message-Id: <CAMuHMdV9vgh89oRsMsH25Jx-nEJh1e6NV02i5EXKhM9bQsCkrA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373876954-30437-1-git-send-email-geert@linux-m68k.org>
	<CA+55aFxGymOvvaYfOg22AdHpxEOuOctfC8vRW+_u=vtua8Dksg@mail.gmail.com>
In-Reply-To: <CA+55aFxGymOvvaYfOg22AdHpxEOuOctfC8vRW+_u=vtua8Dksg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Landley <rob@landley.net>

Hi Linus,

On Tue, Jul 16, 2013 at 3:02 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Jul 15, 2013 at 1:29 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> Commit ad81f0545ef01ea651886dddac4bef6cec930092 ("Linux 3.11-rc1")
>> replaced the Standard 224-color Linux logo, and introduced lots of
>> trailing whitespace. Remove it again.
>
> The logo is temporary, and I'd rather keep it the way it is so that a
> simple revert will fix things up again..

OK, that's a good reason. But unlike last time with Tuz, you can't revert
the whole commit, as that also reverts the version ;-)

> That said, even if it wasn't temporary, I think we might be better off
> with the raw format that the netpbm tools generate these days. It was
> actually slightly annoying to get that big diff from a small edit, and
> it was the result of either the original logo ASCII representation
> having been cleaned up excessively before, or possibly just the netpbm
> tools having changed their output radically.

It seems there are different versions. My (Ubuntu 12.04 LTS) version of
pnmnoraw doesn't add trailing whitespace, but groups the values per
pixel. The old version used to generate the pre-v3.11-rc1 logo didn't
group the values, but used he same width for all fields.

> Of course, it would be even better if we actually used some saner
> format. I'm not exactly artistic, so making that whole silly logo
> change took more time than it really should have. But what was
> *really* painful was to fight the horrible ppm format conversion
> issues, and how we only accept that legacy ascii version etc.

When the logo conversion code was written (before we just had C header
files with arrays, which were a hell to update), my requirements were:
  1. The format must be easy to generate with commonly used tools,
  2. The format must be ASCII, to allow emailing of patches,
  3. The format must be easily parsable, without relying on external tools and
     libraries.

Thanks to "GIT binary patch", 2 is no longer required.
If we switch to e.g. PNG, we may have to rely on one more external library,
upsetting Rob.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
