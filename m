From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 11 Jun 2019 15:04:27 +0000
Subject: Re: [PATCH] efifb: BGRT: Add check for new BGRT status field rotation bits
Message-Id: <a05daac4-7d54-ec32-618d-fd0f2d0d6641@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190529154635.2659-1-hdegoede@redhat.com>
 <CAKv+Gu8bLcDROFNFfqHaN1Z+EK5bnXMNDSJbBK-pCmq5XP_kBw@mail.gmail.com>
 <CAKv+Gu8w2Vj-AS-cfaB8cms+ZJ7qppS-Du_334_xm51rz0CYsA@mail.gmail.com>
 <3065d32f-add7-4e48-164b-c248cc116cea@redhat.com>
 <CAKv+Gu8_+6MNtM3_muP8YqHYYij58LzRFgV_UPaWp4vbjPkm5w@mail.gmail.com>
In-Reply-To: <CAKv+Gu8_+6MNtM3_muP8YqHYYij58LzRFgV_UPaWp4vbjPkm5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi <linux-efi@vger.kernel.org>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, Peter Jones <pjones@redhat.com>, dri-devel <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi,

On 11-06-19 16:37, Ard Biesheuvel wrote:
> On Tue, 11 Jun 2019 at 16:24, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 11-06-19 16:04, Ard Biesheuvel wrote:
>>> On Mon, 10 Jun 2019 at 17:12, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>>>
>>>> On Wed, 29 May 2019 at 17:46, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>
>>>>> Starting with ACPI 6.2 bits 1 and 2 of the BGRT status field are no longer
>>>>> reserved. These bits are now used to indicate if the image needs to be
>>>>> rotated before being displayed.
>>>>>
>>>>> The efifb code does not support rotating the image before copying it to
>>>>> the screen.
>>>>>
>>>>> This commit adds a check for these new bits and if they are set leaves the
>>>>> fb contents as is instead of trying to use the un-rotated BGRT image.
>>>>>
>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>
>>>> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>
>>>
>>> BTW should we make sure that this patch and the efi-bgrt patch get
>>> merged at the same time?
>>
>> The 2 patches are related but merging them at the same time is not
>> necessary.
>>
>>> I guess the net result is just that we get
>>> rid of some error in the log, but a rotated BMP will be ignored
>>> otherwise.
>>
>> Right, worse case (if the bmp fits pre-rotation) it will be displayed
>> rotated. Note on the one machine I'm aware of which uses these bits
>> the bmp does not fit pre-rotation, so we end up triggering:
>>
>> error:
>>           memunmap(bgrt_image);
>>           pr_warn("efifb: Ignoring BGRT: unexpected or invalid BMP data\n");
>> }
>>
> 
> Doesn't that mean we may now end up breaking 'quiet', by exchanging a
> pr_notice() in the efi-bgrt driver for a pr_warn() in this one?

quiet has only logged pr_err and more severe for as long as I can
remember, so notice / warn does not matter for quiet.

Also for flickerfree boot I've made the quiet cut-off configurable
(CONFIG_CONSOLE_LOGLEVEL_QUIET) and in Fedora at least we set it to only
show messages at KERN_CRIT and more severe levels, since there are
simply too many false-positive pr_err messages in the kernel and
I quickly got tired of the whack-a-mole game.

Regards,

Hans
