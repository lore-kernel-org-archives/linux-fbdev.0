From: Alex Courbot <acourbot@nvidia.com>
Date: Tue, 31 Jul 2012 10:11:41 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <5017AF5D.2010204@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com> <1343390750-3642-2-git-send-email-acourbot@nvidia.com> <CAPnjgZ0H2xrJcL-ytMaX11iYrrhCg7LEM00u_NgEaveM4gHMPw@mail.gmail.com> <50179933.9090501@nvidia.com> <20120731091324.GA15557@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20120731091324.GA15557-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>

On 07/31/2012 06:13 PM, Thierry Reding wrote:
>> I don't see any need for microseconds myself - anybody sees use for
>> finer-grained delays?
>>
>> Btw, I noticed I was using mdelay instead of msleep - caught and fixed that.
>
> You might want to take a look at Documentation/timers/timers-howto.txt.
> msleep() isn't very accurate for periods shorter than 20 ms.

Ok, looks like usleep_range is the way to go here. In that case it would 
probably not hurt to specify delays in microseconds in the DT and 
platform data as well.

>>>> +Device tree
>>>> +-----------
>>>> +All the same, power sequences can be encoded as device tree nodes. The following
>>>> +properties and nodes are equivalent to the platform data defined previously:
>>>> +
>>>> +               power-supply = <&mydevice_reg>;
>>>> +               enable-gpio = <&gpio 6 0>;
>>>> +
>>>> +               power-on-sequence {
>>>> +                       regulator@0 {
>>>> +                               id = "power";
>>>
>>> Is there a reason not to put the phandle here, like:
>>>
>>>                                     id = <&mydevice_reg>;
>>>
>>> (or maybe 'device' instead of id?)
>>
>> There is one reason, but it might be a bad one. On Tegra, PWM
>> phandle uses an extra cell to encode the duty-cycle the PWM should
>> have when we call get_pwm().
>
> This is not only the case on Tegra, but it is the default unless a
> driver specifically overrides it. The second cell specifies the index of
> the PWM device within the PWM chip.  The third cell doesn't specify the
> duty cycle but the period of the PWM.

Then I think there is a mistake in 
Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt:

"the second cell is the duty cycle in nanoseconds."

>> This makes it possible to address the
>> same PWM with different phandles (and different duty cycles),
>
> How so? A phandle will always refer to a PWM chip. Paired with the
> second cell, of_pwm_request() will resolve that into the correct PWM
> device.

For tegra, we can only address PWMs this way IIRC:

pwm = <&pwm 2 5000000>;

If we had <&pwm 2>, I agree that there would be no problem. But here the 
period of the PWM is also given - and in practice, we can request the 
same PWM using different phandles. For instance, if the above property 
was part of the power-on sequence, and the following

pwm = <&pwm 2 0>;

was part of power-off, how can I know that these two different phandles 
refer to the same PWM without calling pwm_get a second time and getting 
-EBUSY?

Of course if the same period is specified for both, I will not have this 
issue as the phandles will be identical, but the possibility remains 
open that we are given a faulty tree here.

More generally speaking, wouldn't it make more sense to have the 
period/duty cycle of a PWM encoded into separate properties when needed 
and have the phandle just reference the PWM instance? This also seems to 
stand from an API point of view, since the period is not specified when 
invoking pwm_request or pwm_get, but set by its own pwm_set_period function?

On an unrelated note, I also don't understand why the period is also a 
parameter of pwm_config and why pwm_set_period does not do anything 
beyond setting a struct member that is returned by pwm_get_period (but 
maybe I am missing something here).

Alex.

