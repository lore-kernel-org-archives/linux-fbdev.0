From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 02 Jul 2018 11:46:09 +0000
Subject: Re: [PATCH v2 1/2] efi/bgrt: Drop __initdata from bgrt_image_size
Message-Id: <CAKv+Gu9-=cjZy72-V99VXRmjRtZN93Azafxduwvmy8OOVobXnw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180618151358.4830-1-hdegoede@redhat.com>
 <0333a338-fc21-7f78-7785-f62a67f232a5@redhat.com>
In-Reply-To: <0333a338-fc21-7f78-7785-f62a67f232a5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 2 July 2018 at 13:26, Hans de Goede <hdegoede@redhat.com> wrote:
> Bartlomiej,
>
> Now that the fbcon deferred console takeover patches have been
> merged I believe this series can be merged too ?
>
> Note the first patch has an ack from Ard for merging the
> 1 line efi change through the fbdev tree.
>

... or I could take everything through the efi tree instead, as
already discussed between Bartlomiej and me in the context of another
patch series that touches both the fbdev and efi trees.

Bartlomiej, that would require your ack on patch

[PATCH v2 2/2] efifb: Copy the ACPI BGRT boot graphics to the framebuffer

https://marc.info/?l=linux-fbdev&m2933484616993&w=2

so if you're ok with that, I will queue both of these for v4.19


>
> On 18-06-18 17:13, Hans de Goede wrote:
>>
>> bgrt_image_size is necessary to (optionally) show the boot graphics from
>> the efifb code. The efifb driver is a platform driver, using a normal
>> driver probe() driver callback. So even though it is always builtin it
>> cannot reference __initdata.
>>
>> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/firmware/efi/efi-bgrt.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/efi/efi-bgrt.c
>> b/drivers/firmware/efi/efi-bgrt.c
>> index 50793fda7819..b22ccfb0c991 100644
>> --- a/drivers/firmware/efi/efi-bgrt.c
>> +++ b/drivers/firmware/efi/efi-bgrt.c
>> @@ -20,7 +20,7 @@
>>   #include <linux/efi-bgrt.h>
>>     struct acpi_table_bgrt bgrt_tab;
>> -size_t __initdata bgrt_image_size;
>> +size_t bgrt_image_size;
>>     struct bmp_header {
>>         u16 id;
>>
>
