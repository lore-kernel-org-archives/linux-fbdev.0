From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Date: Wed, 03 Dec 2014 18:29:34 +0000
Subject: Re: [PATCH 1/3] video: fbdev: vt8623fb: suppress build warning
Message-Id: <CA+V-a8vnv4B77XvbzwNkJk=vqGCFWoXxFoyUf0ZNiKwa+gY2ug@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417039645-5313-1-git-send-email-prabhakar.csengg@gmail.com> <547EF8CC.9030502@ti.com>
In-Reply-To: <547EF8CC.9030502@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, LFBDEV <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Dec 3, 2014 at 11:49 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 27/11/14 00:07, Lad, Prabhakar wrote:
>> this patch fixes following build warning:
>> drivers/video/fbdev/vt8623fb.c: In function ‘vt8623_pci_probe’:
>> drivers/video/fbdev/vt8623fb.c:734:23: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>>   par->state.vgabase = (void __iomem *) vga_res.start;
>>                        ^
>> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>> ---
>>  drivers/video/fbdev/vt8623fb.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/vt8623fb.c b/drivers/video/fbdev/vt8623fb.c
>> index 5c7cbc6..ea7f056 100644
>> --- a/drivers/video/fbdev/vt8623fb.c
>> +++ b/drivers/video/fbdev/vt8623fb.c
>> @@ -731,7 +731,7 @@ static int vt8623_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>
>>       pcibios_bus_to_resource(dev->bus, &vga_res, &bus_reg);
>>
>> -     par->state.vgabase = (void __iomem *) vga_res.start;
>> +     par->state.vgabase = (void __iomem *) (unsigned long) vga_res.start;
>
> This does look quite ugly... Where does the warning come from in the
> first place. Isn't vga_res.start (resource_size_t) the size of a pointer?
>
Yes looks ugly, I am not sure what you meant from 'where does this warning
come from' its in the commit message.

Thanks,
--Prabhakar Lad
