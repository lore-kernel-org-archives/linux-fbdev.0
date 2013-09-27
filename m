From: Mike Dunn <mikedunn@newsguy.com>
Date: Fri, 27 Sep 2013 13:35:31 +0000
Subject: Re: [PATCH] pwm-backlight: add support for device tree gpio control
Message-Id: <524589A3.50700@newsguy.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378236372-15711-1-git-send-email-mikedunn@newsguy.com> <20130910172130.GC22111@ulmo> <523056A6.5060000@newsguy.com> <524408BE.40402@ti.com> <20130926120248.GB1680@ulmo> <524427E5.50403@ti.com> <20130926125020.GA2141@ulmo>
In-Reply-To: <20130926125020.GA2141@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

On 09/26/2013 05:50 AM, Thierry Reding wrote:
> On Thu, Sep 26, 2013 at 03:26:13PM +0300, Tomi Valkeinen wrote:
>> On 26/09/13 15:02, Thierry Reding wrote:
>>> On Thu, Sep 26, 2013 at 01:13:18PM +0300, Tomi Valkeinen wrote:
>>>> On 11/09/13 14:40, Mike Dunn wrote:
>>>>> On 09/10/2013 10:21 AM, Thierry Reding wrote:
>>>>
>>>>>> Do you have a real setup that actually needs multiple GPIOs? Usually
>>>>>> such a setup requires some kind of timing or other additional constraint
>>>>>> which can't be represented by this simple binding.
>>>>>>
>>>>>> Looking at the Palm Treo code it seems like the reason why multiple
>>>>>> GPIOs are needed is because one is to enable the backlight, while the
>>>>>> other is in fact used to enable the LCD panel. 
>>>>>
>>>>>
>>>>> There are actually four GPIOs involved!  (There is an embarrasingly horrible
>>>>> hack in arch/arm/mach-pxa/palmtreo.c that handles the others.)  One is almost
>>>>> certainly simply backlight power.  The other three are probably LCD related.
>>>>
>>>> When you say "power", do you mean the gpio enables a regulator to feed
>>>> power to the backlight? If so, wouldn't that be a regulator, not gpio,
>>>> from the bl driver's point of view?
>>>>
>>>> Generally speaking, this same problem appears in many places, but for
>>>> some reason especially in display. I'm a bit hesitant in adding "free
>>>> form" gpio/regulator support for drivers, as, as Thierry pointed out,
>>>> there are often timing requirements, or sometimes the gpios are
>>>> inverted, or sometimes the gpio is, in fact, a reset gpio, where you'll
>>>> assert the gpio for a short moment only.
>>>
>>> I sent out another series a few days ago that somewhat obsoletes this
>>> patch. What it does is basically add a single enable GPIO that can be
>>> used to turn the backlight on and off. In a separate patch, support is
>>> added for a power regulator. The combination of both should be able to
>>> cover the majority of use-cases.
>>
>> But Mike's case required 4 GPIOs? Or can that be reduced to one gpio and
>> one regulator?
> 
> Well, at least for the backlight it only seemed to involve a single
> GPIO. The other three were probably related to LCD and therefore not
> really suitable for a backlight driver. Traditionally it has been that
> the backlight driver handled these things as well (via the callbacks
> installed by board setup code). While really they should be handled by a
> separate driver (for the LCD).


Yes, this is currently my best guess.  This is reverse-engineered and
unfortunately I'm not yet able to accurately describe my particular use-case.
Probably as wacky as anything you can imagine, Thierry :)

The gpio and regulator patches will probably suffice.  Thierry, can you please
point me to those patches?  I don't see them in your gitorious tree.  If they
were posted to linux-pwm, I missed them; sorry.

Thanks,
Mike

