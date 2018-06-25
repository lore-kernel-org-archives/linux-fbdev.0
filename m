From: Sinan Kaya <okaya@codeaurora.org>
Date: Mon, 25 Jun 2018 17:28:14 +0000
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if translated by the bridge
Message-Id: <eb16a77f-7950-7fa1-c436-0ce99a992d3b@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
 <20180619222921.GA90490@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_voOZ7YUL8pckww4mTt4PVcu7y69mf-z7ZZe1bJ81Shw@mail.gmail.com>
 <2a805337-c0b5-e134-7695-5a543ecaa26a@codeaurora.org>
 <CAKv+Gu9HAJRHwjYLNjf+gg=1vFoFu3BJphifKKE-aR4o_MW84A@mail.gmail.com>
 <CAKv+Gu-WXLXqHSmiS2MmAMXHLKK_kg+3EK6L2rvO0SzN-c0UMg@mail.gmail.com>
 <37289a27-eb99-6a73-4d32-4a75edd11dcd@codeaurora.org>
 <CAKv+Gu-bwCFhCKiA7P1amMLeBaSxsjk0d6aPjAr9nCvOBPJA6w@mail.gmail.com>
 <CAKv+Gu96HQf0oJ1RC+wVU34FqqcCWrnDGag48vjNP_z86HhLBQ@mail.gmail.com>
 <7777f7bfead902f2f5175d48907fccec@codeaurora.org>
In-Reply-To: <7777f7bfead902f2f5175d48907fccec@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, Peter Jones <pjones@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 6/25/2018 11:52 AM, okaya@codeaurora.org wrote:
>> Note that this is not the only MMIO translation related change made by
>> Heyi Guo to the generic PCI host bridge and bus drivers, but given
>> that those did not support MMIO translation at all, I take it your
>> affected platforms will already have their own changes to accommodate
>> this.
> 
> Platform has been doing mmio translation for quite a while. Because all accesses go through pci io protocol, the rest of the UEFI never needed to be aware of bar address or do direct access.
> 
> This is the first time I hear of direct access. Maybe, GOP is a special case.
> 
> I started copying your response to the bios vendor.
> 
> They are probably missing that patch. I will pass it along.

I was informed that they fixed the issue in BIOS by presenting CPU physical
address instead of PCI bus address in FrameBufferBase of the AST GOP UEFI driver.

We can drop this patch now.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
