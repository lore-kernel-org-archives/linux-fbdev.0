From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 08 Jan 2014 14:34:53 +0000
Subject: Re: [PATCH] video: vgacon: Don't build on arm64
Message-Id: <CAMuHMdWus8nJ4ik3RDnGc3gvjw58QLmUgKex4YM0YZKjmyxvMA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387323421-26126-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1387323421-26126-1-git-send-email-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Jan 8, 2014 at 2:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 08 January 2014 15:43:20 Tomi Valkeinen wrote:
>> On 2013-12-18 01:37, Mark Brown wrote:
>> > From: Mark Brown <broonie@linaro.org>
>> >
>> > arm64 is unlikely to have a VGA console and does not export screen_info
>> > causing build failures if the driver is build, for example in all*config.
>> > Add a dependency on !ARM64 to prevent this.
>> >
>> > This list is getting quite long, it may be easier to depend on a symbol
>> > which architectures that do support the driver can select.
>>
>> I agree, that depends on looks horrible =).
>
> I've suggested creating a "CONFIG_PC_IO" symbol before that could used
> to simplify this one and a couple of other similar Kconfig statements.
> It is unfortunately a bit tricky because out of the dozen drivers that
> are similar to this one, each one has a slightly different list of
> architectures, and it's not clear which of the differences are intentional
> rather than mistakes.

VGA is special, in that it uses "ISA memory space". This is not a subset of
"PCI memory space", but something different. Some PCI host bridges
(IIRC, e.g. on Mac) do not allow access to this space.
Most other "PC I/O" use ISA I/O space, which is a subset of PCI I/O space.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
