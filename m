From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 25 Jun 2018 08:20:01 +0000
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if translated by the bridge
Message-Id: <CAKv+Gu96HQf0oJ1RC+wVU34FqqcCWrnDGag48vjNP_z86HhLBQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org> <20180619222921.GA90490@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_voOZ7YUL8pckww4mTt4PVcu7y69mf-z7ZZe1bJ81Shw@mail.gmail.com>
 <2a805337-c0b5-e134-7695-5a543ecaa26a@codeaurora.org> <CAKv+Gu9HAJRHwjYLNjf+gg=1vFoFu3BJphifKKE-aR4o_MW84A@mail.gmail.com>
 <CAKv+Gu-WXLXqHSmiS2MmAMXHLKK_kg+3EK6L2rvO0SzN-c0UMg@mail.gmail.com>
 <37289a27-eb99-6a73-4d32-4a75edd11dcd@codeaurora.org> <CAKv+Gu-bwCFhCKiA7P1amMLeBaSxsjk0d6aPjAr9nCvOBPJA6w@mail.gmail.com>
In-Reply-To: <CAKv+Gu-bwCFhCKiA7P1amMLeBaSxsjk0d6aPjAr9nCvOBPJA6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, Peter Jones <pjones@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 22 June 2018 at 21:29, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 22 June 2018 at 20:30, Sinan Kaya <okaya@codeaurora.org> wrote:
>> On 6/22/2018 2:01 PM, Ard Biesheuvel wrote:
>>>> Yes, it is part of the PCI I/O protocol definition. FrameBufferBase is
>>>> described as
>>>>
>>>> """
>>>> Base address of graphics linear frame buffer. Info contains
>>>> information required to allow software to draw directly to the
>>>> frame buffer without using Blt().Offset zero in
>>>> FrameBufferBase represents the upper left pixel of the
>>>> display.
>>>> """
>>> I just tried AMD Radeon and NVidia graphics cards on a system with
>>> non-1:1 mapped MMIO windows, and in both cases, the GOP protocol
>>> structure is populated correctly, i.e., using the CPU address not the
>>> PCIe address.
>>>
>>> EDK2 only recently gained support for MMIO translation in the host
>>> bridge driver, so I so wonder if this is a platform issue rather than
>>> a driver issue. It may be worth a try to dump the results of
>>> GetBarAttributes() of all PCI I/O protocol instances (either in UEFI
>>> or in the stub), to double check that the correct values are returned.
>>>
>>
>> Thanks for checking out other platforms. I'll mark the issue as a BIOS
>> issue and bounce your feedback to the BIOS provider.
>>
>
> I screwed up my testing, unfortunately. Both the public AMD GOP driver
> I tried, and the Nvidia GT218 under x86 emulation break when using
> MMIO translation. However, GraphicsOutputDxe in the EDK2 tree gets it
> right, and uses PciIo->GetBarAttributes() to get the address of the
> framebuffer region, which will return the CPU address not the PCI
> address.
>
>> Let's hold onto this patch for the moment.
>>
>
> Yes. I'd like to get this resolved as well, but if the drivers are
> dereferencing BAR values as CPU addresses, this is unlikely to be the
> only thing that is broken under outbound translation.

Note that this was fixed fairly recently in EDK2, so BIOS vendors
providing UEFI firmware for ARM platforms with outbound MMIO
translation should probably incorporate this EDK2 patch

commit dc080d3b61e570e7a3163fc24afa6f8388d0c0bf
Author: Heyi Guo <heyi.guo@linaro.org>
Date:   Thu Feb 8 11:13:27 2018 +0800

    MdeModulePkg/PciBus: return CPU address for GetBarAttributes

    According to UEFI spec 2.7, PciIo->GetBarAttributes should return host
    address (CPU view ddress) rather than device address (PCI view
    address), and
    device address = host address + address translation offset,
    so we subtract translation from device address before returning.

Note that this is not the only MMIO translation related change made by
Heyi Guo to the generic PCI host bridge and bus drivers, but given
that those did not support MMIO translation at all, I take it your
affected platforms will already have their own changes to accommodate
this.
