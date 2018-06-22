From: Sinan Kaya <okaya@codeaurora.org>
Date: Fri, 22 Jun 2018 18:30:10 +0000
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if translated by the bridge
Message-Id: <37289a27-eb99-6a73-4d32-4a75edd11dcd@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
 <20180619222921.GA90490@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_voOZ7YUL8pckww4mTt4PVcu7y69mf-z7ZZe1bJ81Shw@mail.gmail.com>
 <2a805337-c0b5-e134-7695-5a543ecaa26a@codeaurora.org>
 <CAKv+Gu9HAJRHwjYLNjf+gg=1vFoFu3BJphifKKE-aR4o_MW84A@mail.gmail.com>
 <CAKv+Gu-WXLXqHSmiS2MmAMXHLKK_kg+3EK6L2rvO0SzN-c0UMg@mail.gmail.com>
In-Reply-To: <CAKv+Gu-WXLXqHSmiS2MmAMXHLKK_kg+3EK6L2rvO0SzN-c0UMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, Peter Jones <pjones@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 6/22/2018 2:01 PM, Ard Biesheuvel wrote:
>> Yes, it is part of the PCI I/O protocol definition. FrameBufferBase is
>> described as
>>
>> """
>> Base address of graphics linear frame buffer. Info contains
>> information required to allow software to draw directly to the
>> frame buffer without using Blt().Offset zero in
>> FrameBufferBase represents the upper left pixel of the
>> display.
>> """
> I just tried AMD Radeon and NVidia graphics cards on a system with
> non-1:1 mapped MMIO windows, and in both cases, the GOP protocol
> structure is populated correctly, i.e., using the CPU address not the
> PCIe address.
> 
> EDK2 only recently gained support for MMIO translation in the host
> bridge driver, so I so wonder if this is a platform issue rather than
> a driver issue. It may be worth a try to dump the results of
> GetBarAttributes() of all PCI I/O protocol instances (either in UEFI
> or in the stub), to double check that the correct values are returned.
> 

Thanks for checking out other platforms. I'll mark the issue as a BIOS
issue and bounce your feedback to the BIOS provider.

Let's hold onto this patch for the moment.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
