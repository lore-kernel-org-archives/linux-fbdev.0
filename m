From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Feb 2016 13:08:22 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <CACRpkdZ9PQ5Wk2sADW5=ZQngAnx+mSfpOKpwV1-vz1XZtZ3Xkg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
In-Reply-To: <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 23, 2016 at 12:56 PM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 23 February 2016 at 09:58, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> I'm not quite sure how it works if, as in versatile display case, there
>> are multiple DT overlays of which one has to be enabled. I hope there's
>> support to choose which one to use via kernel cmdline or similar.
>>
>> I would personally like it much more if the bootloader would either
>> compose a final dtb from DT fragments and pass it to the kernel, or
>> alternatively the bootloader would pass the base dtb image and a bunch
>> of DT overlays to the kernel, and the kernel would deal with the DT
>> overlays.
>
> Speaking as somebody who's written the "bootloader" code that's
> used for what I guess are the majority of versatile kernel boots,
> i.e. the one in QEMU, I think that requiring the bootloader to do this
> would be a significant worsening from the current state.
>
> Right now the bootloader doesn't need to do much at all with device
> trees, except pass the kernel the DT that the user gave us, which
> is just the kernel's own data structures in a separate file for
> convenience. You need to do some very minor tweaks to the /chosen
> node, but these can be handled the same way for any board and aren't
> hardware specific. There's no need to worry about dt fragments
> either for the bootloader or for the user. Imposing a new requirement
> for the bootloader to have to probe hardware which it otherwise
> has no need to even care about, and then edit and update the DT
> in a board-specific manner, or have board-specific DT fragments,
> seems like a totally unnecessary imposition on both bootloader
> authors and end-users, and of course it would break booting newer
> kernels on the great mass of already existing boot loaders and
> QEMU installs.
>
> The kernel is in a position to probe the display hardware and determine
> what is there, and do the right thing, and that's exactly what it
> does today. The kernel should continue to do this.
> The advantage of DT is that it allows moving information about
> non-probeable hardware that was previously hardwired in the kernel
> C sources into a separate data structure, but the versatile displays
> are not non-probeable. I can see no benefit at all from hardwiring into
> the dt something which the kernel has previously been successfully
> dynamically getting right without any bootloader intervention -- it just
> makes the kernel less flexible and less user-friendly.

I agree with Peter and Russell on this, as you could guess.
Today the kernel knows about all the hardware and it
JustWorks(TM) and that is so neat.

I'm still trying to appeal to the subsystem maintainer as well.
Pretty tough deal.

Yours,
Linus Walleij
