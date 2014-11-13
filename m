From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 13 Nov 2014 12:01:36 +0000
Subject: Re: [PATCH 3/4] simplefb: Change simplefb_init from module_init to fs_initcall
Message-Id: <54649DA0.8060308@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415830124-28787-1-git-send-email-hdegoede@redhat.com>
 <1415830124-28787-3-git-send-email-hdegoede@redhat.com>
 <20141113085238.GE20972@lukather> <546478B5.2040002@redhat.com>
 <CACxGe6u8B854PEWw8XzwhyX8joMWwOsHOOXtmBmC1TgCGjGtdg@mail.gmail.com>
 <CACxGe6sYD-Ow2wcwAKuXpR3A9VZozo2sgz=eEcWXi5ayKd2jWQ@mail.gmail.com>
In-Reply-To: <CACxGe6sYD-Ow2wcwAKuXpR3A9VZozo2sgz=eEcWXi5ayKd2jWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 11/13/2014 11:31 AM, Grant Likely wrote:
> On Thu, Nov 13, 2014 at 10:29 AM, Grant Likely <grant.likely@linaro.org> wrote:
>> On Thu, Nov 13, 2014 at 9:24 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>> Hi,
>>>
>>> On 11/13/2014 09:52 AM, Maxime Ripard wrote:
>>>> On Wed, Nov 12, 2014 at 11:08:43PM +0100, Hans de Goede wrote:
>>>>> One of the reasons for having the simplefb nodes in /chosen, and doing
>>>>> explicit enumeration of the nodes there, is too allow enumerating them sooner,
>>>>> so that we get a console earlier on.
>>>>>
>>>>> Doing this earlier then fs_initcall is not useful, since the fb only turns into
>>>>> a console when fbcon intializes, which is a fs_initcall too.
>>>>>
>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>> ---
>>>>>  drivers/video/fbdev/simplefb.c | 6 +++++-
>>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
>>>>> index be7d288..8c0c972 100644
>>>>> --- a/drivers/video/fbdev/simplefb.c
>>>>> +++ b/drivers/video/fbdev/simplefb.c
>>>>> @@ -415,7 +415,11 @@ static void __exit simplefb_exit(void)
>>>>>      platform_driver_unregister(&simplefb_driver);
>>>>>  }
>>>>>
>>>>> -module_init(simplefb_init);
>>>>> +/*
>>>>> + * While this can be a module, if builtin it's most likely the console
>>>>> + * So let's leave module_exit but move module_init to an earlier place
>>>>> + */
>>>>
>>>> Not really related to this patch itself, but do we want to support
>>>> simplefb as a module? It seems like it's going to be most of the time
>>>> broken.
>>>
>>> A valid point, my mean reasoning here is that some may see not being able to
>>> use it as a module as a regression, so I just kept things as is, but I do
>>> agree that it is advisable to just build it in.
>>
>> Like a lot of things, if it is made a modules, and it breaks for the
>> user, the user gets to keep the pieces. There are potentially some
>> valid scenarios where it is fine to have it as a module. I don't
>> recommend changing this unless is actually starts causing problems.
> 
> I assume that you've tested this and it actually makes a difference,
> correct? If so,
> 
> Acked-by: Grant Likely <grant.likely@linaro.org>

Yes I've tested the entire set on 4 boards / 4 SoCs (A10, A10s, A20 and A31),
and yes it makes a difference.

Regards,

Hans
