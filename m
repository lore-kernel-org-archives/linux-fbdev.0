From: "Pihet-XID, Jean" <j-pihet@ti.com>
Date: Mon, 06 Aug 2012 08:45:02 +0000
Subject: Re: Gethering power management/policy hw drivers under drivers/power/? (Re: [RFC][PATCH v3 1/3] runt
Message-Id: <CAN5iSWokvOPa775CNF2XXeg4vM5QTmViJwH32J_=353ckFyt7A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com>
	<1343390750-3642-2-git-send-email-acourbot@nvidia.com>
	<20120727181923.GB23564@kroah.com>
	<5015E8AE.8060404@nvidia.com>
	<20120730024049.GA10442@lizard>
In-Reply-To: <20120730024049.GA10442@lizard>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, KEERTHY J <j-keerthy-l0cyMroinI0@public.gmane.org>

Hi Anton,

Sorry for the late reply. I was away and back now.

On Mon, Jul 30, 2012 at 4:40 AM, Anton Vorontsov <cbouatmailru@gmail.com> wrote:
> On Mon, Jul 30, 2012 at 10:51:42AM +0900, Alex Courbot wrote:
> [...]
>> On the other hand I have just noticed that the apparently unrelated
>> Adaptive Voltage Scaling driver just appeared in drivers/power/avs.
>> So if Anton and David are ok with this, maybe I could put the power
>> sequences code in its own subdirectory within drivers/power.
>
> Well, currently drivers/power/ is indeed just for power supply class
> subsystem and drivers. But if the trend is to gather power management
> ("policy") stuff under one directory, i.e.
>
> drivers/
>   power/
>     supplies/    <- former "power supply class and drivers"
>     regulators/
>     idle/
>     cpuidle/
>     cpufreq/
>     devfreq/
>     avs/
>     ...
>
> That would probably make sense, we could easily see the big picture.
> But if we're not going to do this long-term, I would suggest to stick
> to just a new directory under drivers (and move drivers/power/avs/ to
> drivers/avs).
>
> Cc'ing some more people...
>
> Thanks,
>
> p.s. Jean, why am I the last person who discovers drivers/power/avs/?
> Would be nice to Cc me on such patches; by moving AVS under
> drivers/power/ you effectively nominated me as its maintainer. :-)
Oops, I am really sorry about that ;-( . I wrongly assumed Rafael and
Greg KH were the contact persons for drivers/power and so I contacted
them before moving the code.

Thanks for letting me know. Are you ok with the changes? Let me know
if some more changes are needed.

Regards,
Jean

>
> --
> Anton Vorontsov
> Email: cbouatmailru@gmail.com
