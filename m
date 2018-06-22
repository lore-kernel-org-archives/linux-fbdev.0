From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 22 Jun 2018 07:54:22 +0000
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if translated by the bridge
Message-Id: <CAKv+Gu9dFGudOr1uTmOnM=X47gsOAgpdUJ6UMiDJJ_7phH1ZzA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <CGME20180613154552epcas5p4877f53310b66cf9d3e17196b0d028e41@epcas5p4.samsung.com>
 <CAKv+Gu9+M8zOtACPQ4_UMgp-M1LfZnciYe1VTQNqn_zNWJea4g@mail.gmail.com> <6376822.ENUjdQ58sn@amdc3058>
In-Reply-To: <6376822.ENUjdQ58sn@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Peter Jones <pjones@redhat.com>, Sinan Kaya <okaya@codeaurora.org>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 13 June 2018 at 18:08, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On Wednesday, June 13, 2018 05:45:48 PM Ard Biesheuvel wrote:
>> On 18 May 2018 at 16:17, Sinan Kaya <okaya@codeaurora.org> wrote:
>> > A host bridge is allowed to remap BAR addresses using _TRA attribute in
>> > _CRS windows.
>> >
>> > pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff window] (bus address [0x00100000-0x1fffffff])
>> > pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
>> >
>> > When a VGA device is behind such a host bridge and the resource is
>> > translated efifb driver is trying to do ioremap against bus address
>> > rather than the resource address and is failing to probe.
>> >
>> > efifb: probing for efifb
>> > efifb: cannot reserve video memory at 0x1e000000
>> > efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
>> > efifb: mode is 800x600x32, linelength200, pages=1
>> > efifb: scrolling: redraw
>> > efifb: Truecolor: size=8:8:8:8, shift$:16:8:0
>> >
>> > Use the host bridge offset information to convert bus address to
>> > resource address in the fixup.
>> >
>> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>
>> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> Bartlomiej, could you please take these via the fbdev tree for v4.19?
>
> Sure, I will queue it after the current merge window.
>
>> Peter already gave his ack but Sinan dropped it (presumably because of
>> the split in v2)
>
> Peter, can I (re)add your ACK to V2 patches?
>

Actually, it would be better if we could take this through the EFI
tree instead, with your ack. Would you mind?

There are some other efifb changes coming up, some of which depend on
core EFI changes, and taking these through different trees is going to
be more trouble than it's worth.

https://marc.info/?l=linux-efi&m2929425329015&w=2 from Hans, and the series

[PATCH v2 0/2] efi: add support for cacheable efifb mappings

that I just cc'ed you on a minute ago.

Thanks.
