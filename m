From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 22 Jun 2018 18:01:03 +0000
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if translated by the bridge
Message-Id: <CAKv+Gu-WXLXqHSmiS2MmAMXHLKK_kg+3EK6L2rvO0SzN-c0UMg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org> <20180619222921.GA90490@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_voOZ7YUL8pckww4mTt4PVcu7y69mf-z7ZZe1bJ81Shw@mail.gmail.com>
 <2a805337-c0b5-e134-7695-5a543ecaa26a@codeaurora.org> <CAKv+Gu9HAJRHwjYLNjf+gg=1vFoFu3BJphifKKE-aR4o_MW84A@mail.gmail.com>
In-Reply-To: <CAKv+Gu9HAJRHwjYLNjf+gg=1vFoFu3BJphifKKE-aR4o_MW84A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, Peter Jones <pjones@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 22 June 2018 at 15:55, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 22 June 2018 at 15:52, Sinan Kaya <okaya@codeaurora.org> wrote:
>> Hi Ard,
>>
>> On 6/22/2018 7:21 AM, Ard Biesheuvel wrote:
>>> Apologies for only bringing this up now, but I think this patch is
>>> wrong after all.
>>>
>>> screen_info.lfb_base is supposed to be a CPU address, and so
>>> translating it like this is wrong. If you end up with a PCI address
>>> here, you have made a mistake in hacking support for PCI outbound
>>> translations into UEFI. Other users such as UEFI itself or GRUB will
>>> treat this as a CPU physical address as well, so the kernel should not
>>> treat it any differently.
>>
>> The behavior I'm seeing is from a UEFI BIOS vendor. I did not write the
>> code for it...
>>
>> I was asked to debug it.
>>
>> I'd like to dive into your statement about UEFI and GRUB using this address
>> as physical addresses.
>>
>> AFAIK, all PCI outbound requests go through PCI IO protocol in UEFI and the
>> translation information is hidden inside the UEFI PCI Host Bridge driver.
>> Drivers are not allowed to access PCI resources directly especially as a
>> memory mapped address.
>>
>> This particular vendor is programming the BAR address into the GOP protocol.
>> Since the host bridge driver is doing a translation, we are hitting this
>> issue.
>>
>> Is there a UEFI spec reference about the definition of this field?
>>
>
> Yes, it is part of the PCI I/O protocol definition. FrameBufferBase is
> described as
>
> """
> Base address of graphics linear frame buffer. Info contains
> information required to allow software to draw directly to the
> frame buffer without using Blt().Offset zero in
> FrameBufferBase represents the upper left pixel of the
> display.
> """

I just tried AMD Radeon and NVidia graphics cards on a system with
non-1:1 mapped MMIO windows, and in both cases, the GOP protocol
structure is populated correctly, i.e., using the CPU address not the
PCIe address.

EDK2 only recently gained support for MMIO translation in the host
bridge driver, so I so wonder if this is a platform issue rather than
a driver issue. It may be worth a try to dump the results of
GetBarAttributes() of all PCI I/O protocol instances (either in UEFI
or in the stub), to double check that the correct values are returned.
