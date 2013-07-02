From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Date: Tue, 02 Jul 2013 09:27:57 +0000
Subject: Re: [PATCH 2/2] video:da8xx-fb: Convert to devm_* api
Message-Id: <CA+V-a8vij-4s1FsePmSZrdUTBZJPWZV6Wq9s=uurOHh2k47JNA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1368688257-18705-1-git-send-email-prabhakar.csengg@gmail.com>
 <1368688257-18705-3-git-send-email-prabhakar.csengg@gmail.com>
 <51CAD305.30407@ti.com> <CA+V-a8uhK5-QJKifkiSUN6Nz0aBc2moraWQUJPCmZg9zaFX0eg@mail.gmail.com>
 <51CAD7E4.2000403@ti.com> <CA+V-a8u6vjSc5EV3z4FCQ8LEHxL79bUXtHzX8svhQwqVtj6w=g@mail.gmail.com>
 <51CADA58.2030602@ti.com>
In-Reply-To: <51CADA58.2030602@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Etheridge, Darren" <detheridge@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, DLOS <davinci-linux-open-source@linux.davincidsp.com>, LFBDEV <linux-fbdev@vger.kernel.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, LKML <linux-kernel@vger.kernel.org>

Hi Darren,

On Wed, Jun 26, 2013 at 5:41 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 26/06/13 15:06, Prabhakar Lad wrote:
>> Hi Tomi,
>>
>> On Wed, Jun 26, 2013 at 5:30 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>> On 26/06/13 14:56, Prabhakar Lad wrote:
>>>> Hi Tomi,
>>>>
>>>> On Wed, Jun 26, 2013 at 5:09 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>>>> On 16/05/13 10:10, Lad Prabhakar wrote:
>>>>>> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>>>>>>
>>>>>> Use devm_ioremap_resource instead of reques_mem_region()/ioremap() and
>>>>>> devm_request_irq() instead of request_irq().
>>>>>>
>>>>>> This ensures more consistent error values and simplifies error paths.
>>>>>>
>>>>>> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>>>>>> ---
>>>>>>  drivers/video/da8xx-fb.c |   39 +++++++--------------------------------
>>>>>>  1 files changed, 7 insertions(+), 32 deletions(-)
>>>>>
>>>>> There's something similar in Darren's da8xx-fb series. Can you check if
>>>>> there are differences?
>>>>>
>>>> I don't see similar changes in his patch series.
>>>
>>> [PATCH 14/23] video: da8xx-fb: use devres
>>>
>> Oops missed it out :), patch is almost similar except
>> for following block,
>>
>> -       fb_clk = clk_get(&device->dev, "fck");
>> +       fb_clk = devm_clk_get(&device->dev, "fck");
>>         if (IS_ERR(fb_clk)) {
>>                 dev_err(&device->dev, "Can not get device clock\n");
>> -               ret = -ENODEV;
>> -               goto err_ioremap;
>> +               return -ENODEV;
>>         }
>>
>> How do you suggest to handle it ?
>
> I think it's easiest if Darren handles the da8xx-fb series for 3.11. So
> if there's something missing from Darren's series, please discuss with him.
>
Either you merge this patch with yours or rebase your patch on top of my patch.
Let me know how you would like to handle it ?

Regards,
--Prabhakar Lad
