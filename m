From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 08 Dec 2016 14:22:09 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <CAMuHMdWtajvNmPvCzWhBTU0iXU0=Ho=9pHHRM=ZiEbWOwA325A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <1481158879.26959.41.camel@kernel.crashing.org> <20161208101005.6ufl3d4qvwprosju@phenom.ffwll.local>
 <CAMuHMdWsKqgvB8QtG6SjHO-mceB5fRK9G51y8RYeos0Ym7pgdA@mail.gmail.com> <20161208140210.rfyjf2265flsfpfj@phenom.ffwll.local>
In-Reply-To: <20161208140210.rfyjf2265flsfpfj@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Daniel,

On Thu, Dec 8, 2016 at 3:02 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, Dec 08, 2016 at 01:15:56PM +0100, Geert Uytterhoeven wrote:
>> On Thu, Dec 8, 2016 at 11:10 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
>> > On Thu, Dec 08, 2016 at 12:01:19PM +1100, Benjamin Herrenschmidt wrote:
>> >> On Wed, 2016-11-23 at 10:03 +0200, Tomi Valkeinen wrote:
>> >> > Since the fbdev framework is in maintenance mode and all new display drivers
>> >> > should be made with the DRM framework, remove the fbdev drivers from staging.
>> >> >
>> >> > Note: the patches are created with git format-patch -D, so they can't be
>> >> > applied. Only for review.
>> >>
>> >> I missed the discussion where this decision was made, I admit I am
>> >> unimpressed by it.
>> >>
>> >> DRM drivers don't strike me as suitable for small/slow cores with dumb
>> >> framebuffers or simple 2D only accel, such as the one found in the ASpeed
>> >> BMCs.
>> >
>> > We have a helper for simple drivers now, if you take into account the
>> > massive helper libraries for everything that comes along with drm I expect
>> > if even dumb panels behind slow spi buses drm is now the more suitable
>> > subsytem.
>>
>> This has been going on your years:
>>   1. Fbdev is obsolete, everybody should use DRM instead!
>>   2. Can you please point me to a small sample driver for a dumb frame buffer?
>>   3. Several are being written, but none of them is upstream yet.
>>   4. Goto 1.
>
> Wut. We have like 20+ small atomic drivers nowdays.

That's fast! Only two weeks ago you said:

| Bummer, they still haven't landed. But afaik there's at least 4 of
| them floating around in various places ...

>> > That's correct, and drm can cope. And compared to fbdev there's a very
>> > active community who improves&refactors it every kernel release to make it
>> > even better. Since about 2 years (when atomic landed) we merge new drivers at
>> > a rate of 2-3 per kernel release, and those new drivers get ever simpler
>> > and smaller thanks to all this work.
>>
>> You mean the kind of refactoring that causes severe merge conflicts between
>> drm-next and Linus' tree about every single day?
>> (sorry, couldn't resist ;-)
>
> Yeah, for a subsystem that only consists of 10% of the overall kernel (by
> patch count) we do an extremly shitty job. Maybe we should just all slow
> down and stop merging support for new hw, and fuck Android and CrOS and
> the billions of devices that don't ship upstream, who cares about those
> folks.

My apologies. In hindsight, my comment sounded much more insulting than it
was meant to be.

> If you're this good at mainting gpu and display subsystems, maybe you want
> to take over?

No please ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
