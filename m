From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] cirrusfb: use 5-6-5 RGB for
	16bpp mode
Date: Sun, 15 Feb 2009 19:30:53 +0100
Message-ID: <10f740e80902151030y2fbd44d3h8e545642473c95db@mail.gmail.com>
References: <20090214185231.9158b170.krzysztof.h1@poczta.fm>
	<10f740e80902150353v3c58d942m145c9e1f8ba10501@mail.gmail.com>
	<20090215192537.e5848d0d.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert.uytterhoeven@gmail.com>) id 1LYllh-00010N-34
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Feb 2009 18:31:05 +0000
Received: from mail-bw0-f205.google.com ([209.85.218.205])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LYllX-0001IR-IA for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Feb 2009 18:31:05 +0000
Received: by bwz1 with SMTP id 1so2817485bwz.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 15 Feb 2009 10:30:53 -0800 (PST)
In-Reply-To: <20090215192537.e5848d0d.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Arthur Marsh <arthur.marsh@internode.on.net>, Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sun, Feb 15, 2009 at 19:25, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> On Sun, 15 Feb 2009 12:53:36 +0100
> Geert Uytterhoeven <geert.uytterhoeven@gmail.com> wrote:
>> On Sat, Feb 14, 2009 at 18:52, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
>> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
>> >
>> > Use the 5-6-5 RGB mode instead of the 5-5-5 mode
>> > at 16bpp depth.
>> > It fixes colors in the 16bpp modes on Cirrus
>> > Laguna chips.
>> >
>> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
>> > ---
>> >  drivers/video/cirrusfb.c |    6 +++---
>> >  1 files changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
>> > index c98efd0..bf3d9c3 100644
>> > --- a/drivers/video/cirrusfb.c
>> > +++ b/drivers/video/cirrusfb.c
>> > @@ -499,12 +499,12 @@ static int cirrusfb_check_var(struct fb_var_screeninfo *var,
>> >                        var->green.offset = -3;
>> >                        var->blue.offset = 8;
>> >                } else {
>> > -                       var->red.offset = 10;
>> > +                       var->red.offset = 11;
>> >                        var->green.offset = 5;
>> >                        var->blue.offset = 0;
>> >                }
>> >                var->red.length = 5;
>> > -               var->green.length = 5;
>> > +               var->green.length = 6;
>> >                var->blue.length = 5;
>> >                break;
>> >
>> > @@ -1180,7 +1180,7 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
>> >                /* pixel mask: pass-through all planes */
>> >                WGen(cinfo, VGA_PEL_MSK, 0xff);
>> >  #ifdef CONFIG_PCI
>> > -               WHDR(cinfo, 0xc0);      /* Copy Xbh */
>> > +               WHDR(cinfo, 0xc1);      /* Copy Xbh */
>> >  #elif defined(CONFIG_ZORRO)
>> >                /* FIXME: CONFIG_PCI and CONFIG_ZORRO may be defined both */
>> >                WHDR(cinfo, 0xa0);      /* hidden dac reg: nothing special */
>>
>> Does this need a similar or other change to cinfo for the Zorro case?
>>
>
> The Zorro offsets are: red = 2, green = -3, blue = 8. It seems that
> Zorro uses 5-6-5 already (offset between 2 and 8).

No, the code that uses 2/-3/8 is protected by isPReP, not by #ifdef
CONFIG_ZORRO.

PReP is the old PowerPC Reference Platform, i.e. the Motorola
PowerStack and some
IBM pSeries workstations.

Zorro is the Amiga AutoConfig bus.

> I contacted a person who reported that Zorro Cirrus card was not detected
> http://www.mail-archive.com/linux-m68k@vger.kernel.org/msg01505.html

Yeah, I saw that mail, too. It seems cirrusfb is broken on Amiga.

> I have to cross-compile a kernel for him.
>
> However, I have a chance to big the Cirrus GD5446 on online auction this week.
> The Cirrus 5446 is supposedly the same chip as the Picasso 4 card so I can
> fix it on x86 first. My experience shows that the cirrusfb driver has still
> many bugs and may not handle some of chips it claims to handle (like Laguna chips).
> After the driver is fixed for the x86 GD5446 I will try to help him.
>
> Many bugs found during my work with the Laguna chips are bugs
> in the common code (like wrong line length for the 32-bit modes or
> overwritten 9-bit of line pitch in the chip register). These fixes
> helps (almost) all chips on all platforms.

Thanks, that will help everybody!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
