From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 22 Jun 2018 11:21:29 +0000
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if translated by the bridge
Message-Id: <CAKv+Gu_voOZ7YUL8pckww4mTt4PVcu7y69mf-z7ZZe1bJ81Shw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org> <20180619222921.GA90490@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180619222921.GA90490@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, Peter Jones <pjones@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 20 June 2018 at 00:29, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Minor subject nit: From the caller's point of view, we must convert a bus
> address to a resource *always* (the caller has no knowledge of "whether it
> is translated by the host bridge").
>
> On Fri, May 18, 2018 at 10:17:51AM -0400, Sinan Kaya wrote:
>> A host bridge is allowed to remap BAR addresses using _TRA attribute in
>> _CRS windows.
>
> Also, _TRA/_CRS are ACPI-specific terms and non-ACPI host bridges can
> also do the same sort of translation.  Another trivial nit.
>
>> pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff window] (bus address [0x00100000-0x1fffffff])
>> pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
>>
>> When a VGA device is behind such a host bridge and the resource is
>> translated efifb driver is trying to do ioremap against bus address
>> rather than the resource address and is failing to probe.
>>
>> efifb: probing for efifb
>> efifb: cannot reserve video memory at 0x1e000000
>> efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
>> efifb: mode is 800x600x32, linelength200, pages=1
>> efifb: scrolling: redraw
>> efifb: Truecolor: size=8:8:8:8, shift$:16:8:0
>>
>> Use the host bridge offset information to convert bus address to
>> resource address in the fixup.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Thanks a lot for fixing this!
>

Apologies for only bringing this up now, but I think this patch is
wrong after all.

screen_info.lfb_base is supposed to be a CPU address, and so
translating it like this is wrong. If you end up with a PCI address
here, you have made a mistake in hacking support for PCI outbound
translations into UEFI. Other users such as UEFI itself or GRUB will
treat this as a CPU physical address as well, so the kernel should not
treat it any differently.


>> ---
>>  drivers/video/fbdev/efifb.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
>> index 6daac8d..429cc85 100644
>> --- a/drivers/video/fbdev/efifb.c
>> +++ b/drivers/video/fbdev/efifb.c
>> @@ -431,6 +431,7 @@ static void efifb_fixup_resources(struct pci_dev *dev)
>>               .end = screen_info.lfb_base + screen_info.lfb_size - 1,
>>               .flags = IORESOURCE_MEM,
>>       };
>> +     struct pci_bus_region region;
>>       int i;
>>
>>       if (efifb_pci_dev || screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
>> @@ -442,6 +443,10 @@ static void efifb_fixup_resources(struct pci_dev *dev)
>>       if (!screen_res.start)
>>               return;
>>
>> +     region.start = screen_res.start;
>> +     region.end = screen_res.end;
>> +     pcibios_bus_to_resource(dev->bus, &screen_res, &region);
>> +
>>       for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
>>               struct resource *res = &dev->resource[i];
>>
>> --
>> 2.7.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
