From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 21 Jun 2019 11:38:31 +0000
Subject: Re: [PATCH] efifb: BGRT: Add check for new BGRT status field rotation bits
Message-Id: <82a83a92-a99f-520c-921f-3f7b57f5bebf@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190529154635.2659-1-hdegoede@redhat.com>
 <CAKv+Gu8bLcDROFNFfqHaN1Z+EK5bnXMNDSJbBK-pCmq5XP_kBw@mail.gmail.com>
 <CAKv+Gu8w2Vj-AS-cfaB8cms+ZJ7qppS-Du_334_xm51rz0CYsA@mail.gmail.com>
 <CGME20190611142502epcas2p35cbca6e4ef78d061a631012f0ca5d49a@epcas2p3.samsung.com>
 <3065d32f-add7-4e48-164b-c248cc116cea@redhat.com>
In-Reply-To: <3065d32f-add7-4e48-164b-c248cc116cea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-efi <linux-efi@vger.kernel.org>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, Peter Jones <pjones@redhat.com>, dri-devel <dri-devel@lists.freedesktop.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>


On 6/11/19 4:24 PM, Hans de Goede wrote:
> Hi,
> 
> On 11-06-19 16:04, Ard Biesheuvel wrote:
>> On Mon, 10 Jun 2019 at 17:12, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>>
>>> On Wed, 29 May 2019 at 17:46, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Starting with ACPI 6.2 bits 1 and 2 of the BGRT status field are no longer
>>>> reserved. These bits are now used to indicate if the image needs to be
>>>> rotated before being displayed.
>>>>
>>>> The efifb code does not support rotating the image before copying it to
>>>> the screen.
>>>>
>>>> This commit adds a check for these new bits and if they are set leaves the
>>>> fb contents as is instead of trying to use the un-rotated BGRT image.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>
>>
>> BTW should we make sure that this patch and the efi-bgrt patch get
>> merged at the same time?
> 
> The 2 patches are related but merging them at the same time is not
> necessary.
> 
>> I guess the net result is just that we get
>> rid of some error in the log, but a rotated BMP will be ignored
>> otherwise.
> 
> Right, worse case (if the bmp fits pre-rotation) it will be displayed
> rotated. Note on the one machine I'm aware of which uses these bits
> the bmp does not fit pre-rotation, so we end up triggering:
> 
> error:
>         memunmap(bgrt_image);
>         pr_warn("efifb: Ignoring BGRT: unexpected or invalid BMP data\n");
> }
> 
> Which this patch replaces with hitting:
> 
>         if (bgrt_tab.status & 0x06) {
>                 pr_info("efifb: BGRT rotation bits set, not showing boot graphics\n");
>                 return;
>         }
> 
> Instead. So at least on the one machine I know of this is 99% cosmetic.
> 
>> Or is it relevant for userland in some other way?
> 
> No.
> 
> Regards,
> 
> Hans

Patch queued for v5.3, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
