From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 25 Jun 2018 17:03:54 +0000
Subject: Re: [PATCH v2 2/2] fbdev/efifb: honour UEFI memory map attributes when mapping the fb
Message-Id: <CAKv+Gu_eODtKg7RfRZM9sfuX8_H=XrzZN3a4U-0uYN3uFnRGqw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180622075250.14075-3-ard.biesheuvel@linaro.org>
In-Reply-To: <20180622075250.14075-3-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 25 June 2018 at 18:49, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On Monday, June 25, 2018 11:58:11 AM Ard Biesheuvel wrote:
>> ,On 22 June 2018 at 09:52, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > If the framebuffer address provided by the Graphics Output Protocol
>> > (GOP) is covered by the UEFI memory map, it will tell us which memory
>> > attributes are permitted when mapping this region. In some cases,
>> > (KVM guest on ARM), violating this will result in loss of coherency,
>> > which means that updates sent to the framebuffer by the guest will
>> > not be observeable by the host, and the emulated display simply does
>> > not work.
>> >
>> > So if the memory map contains such a description, take the attributes
>> > field into account, and add support for creating WT or WB mappings of
>> > the framebuffer region.
>> >
>> > Cc: linux-fbdev@vger.kernel.org
>> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> > Cc: Peter Jones <pjones@redhat.com>
>> > Tested-by: Laszlo Ersek <lersek@redhat.com>
>> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> Bartlomiej, do you have any comments on this patch? If not, I would
>> like to queue it in the efi tree.
>
>> > @@ -164,6 +168,8 @@ static int efifb_probe(struct platform_device *dev)
>> >         unsigned int size_remap;
>> >         unsigned int size_total;
>> >         char *option = NULL;
>> > +       efi_memory_desc_t md;
>> > +
>> >
>
> minor nit: redundant newline
>
> the rest looks fine to me
>
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>

Thanks. Queued in efi/next with the redundant newline removed.
