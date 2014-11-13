From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 13 Nov 2014 08:28:25 +0000
Subject: Re: [PATCH 2/4] simplefb: Add support for enumerating simplefb dt nodes in /chosen
Message-Id: <54646BA9.10909@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415830124-28787-1-git-send-email-hdegoede@redhat.com>	<1415830124-28787-2-git-send-email-hdegoede@redhat.com>	<CAMuHMdWdtxcmDc7fDbQHfVa425sR3MGwJ70cRnh2Wb50iAo2CQ@mail.gmail.com>
 <CAMuHMdWCF5+N3h890fUpPjAYWBEf6HcFEacz0j5GsLwNoF1Smw@mail.gmail.com>
In-Reply-To: <CAMuHMdWCF5+N3h890fUpPjAYWBEf6HcFEacz0j5GsLwNoF1Smw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Geert,

On 11/13/2014 09:16 AM, Geert Uytterhoeven wrote:
> On Thu, Nov 13, 2014 at 9:15 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Wed, Nov 12, 2014 at 11:08 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>> --- a/drivers/video/fbdev/simplefb.c
>>> +++ b/drivers/video/fbdev/simplefb.c
>>
>>> @@ -385,7 +386,37 @@ static struct platform_driver simplefb_driver = {
>>>         .probe = simplefb_probe,
>>>         .remove = simplefb_remove,
>>>  };
>>> -module_platform_driver(simplefb_driver);
>>> +
>>> +static int __init simplefb_init(void)
>>> +{
>>> +       int i, ret;
>>
>> unsigned int i;

Although you're right that it will never become negative, making this
unsigned really gains us nothing, and it is normal C programming
practice to use signed ints to loop over arrays even if the array
index never becomes negative. So I see no reason to change this.

Regards,

Hans
