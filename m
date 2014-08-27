From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 Aug 2014 08:37:36 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAMuHMdVkEPBtVT0dcDqQOQ_J0p+zYJwaUW8LqQX0Z+h6CHihRg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <53FB46FF.1010208@redhat.com>
 <20140825145303.GC14763@ulmo.nvidia.com>
 <20140825150705.GB15297@lukather> <20140826082626.GE17263@ulmo>
 <20140826090035.GB17528@sirena.org.uk>
 <20140826091853.GI17263@ulmo>
 <20140826100612.GH17528@sirena.org.uk>
 <20140826105451.GD31124@ulmo> <1409078409.2701.17.camel@localhost>
 <20140827074057.GS17528@sirena.org.uk>
 <20140827082208.GQ15297@lukather>
In-Reply-To: <20140827082208.GQ15297@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Maxime,

On Wed, Aug 27, 2014 at 10:22 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Aug 27, 2014 at 08:40:57AM +0100, Mark Brown wrote:
>> On Tue, Aug 26, 2014 at 08:40:09PM +0200, Henrik Nordstr=C3=B6m wrote:
>>
>> > It is not clear to me where the hardware resources should be listed in
>> > DT, being it a simplefb node or part of the actual hardware device node
>> > properly marked as dynamic boot defaults or something else? It's
>> > somewhere inbetween hardware and virtual device, and somewhat volatile.
>> > As far as simplefb is concerned it is a hardware desription of the
>> > framebuffer, but for a kms driver it's no more than firmware handover =
of
>> > boottime settings and ceases to exists once the kms driver have
>> > reconfigured the hardware.
>>
>> Is simplefb something that should be in the device tree distinctly in
>> the first place - shouldn't it be a subset of the functionality of the
>> video nodes?  It's the same hardware being driven differently.
>
> Therorically, yes, but that would mean knowing beforehand what the
> final binding will look like, even before submitting the driver. Since
> the bindings are always reviewed, and most of the time changed
> slightly, that wouldn't work very well with the DT as a stable ABI
> policy I guess.

If you don't know how the bindings for a device will look like at the time =
of
writing your DTS, you're always screwed, whether you add a simpefb
node or not.

If you know how the bindings look like, just add the device, with an extra
"linux,simplefb" compatibility value.
If you don't know how the bindings look like, do your utter best in
guessing. Your DTS must be amended later anyway, either because
you guessed wrong[*] (in case you added a node to have simplefb
working), or because you have to add a real device node (in case you
didn't add one for simplefb).

[*] Actually you may have guessed right, in which case it'll continue
    working as-is, and everybody will be happy.
    Whether you want to keep backwards-compatibility in your future driver
    with the "guessed wrong" node is up to you.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
