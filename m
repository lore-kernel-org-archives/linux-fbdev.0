From: Alex Courbot <acourbot@nvidia.com>
Date: Thu, 02 Aug 2012 09:20:41 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <501A4669.9090707@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com> <1343390750-3642-2-git-send-email-acourbot@nvidia.com> <50170EA0.1010408@wwwdotorg.org> <501A338D.7080105@nvidia.com> <20120802082157.GA14866@avionic-0098.adnet.avionic-design.de> <501A3A00.7070207@nvidia.com> <20120802084541.GA15042@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20120802084541.GA15042@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Arnd Bergmann <arnd@arndb.de>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Thu 02 Aug 2012 05:45:41 PM JST, Thierry Reding wrote:
> * PGP Signed by an unknown key
>
> On Thu, Aug 02, 2012 at 05:27:44PM +0900, Alex Courbot wrote:
>> On Thu 02 Aug 2012 05:21:57 PM JST, Thierry Reding wrote:
>>>> Old Signed by an unknown key
>>>
>>> On Thu, Aug 02, 2012 at 05:00:13PM +0900, Alex Courbot wrote:
>>>> On 07/31/2012 07:45 AM, Stephen Warren wrote:
>>>>> Oh I see. That's a little confusing. Why not just reference the relevant
>>>>> resources directly in each step; something more like:
>>>>>
>>>>> 		gpio@1 {
>>>>> 			action = "enable-gpio";
>>>>> 			gpio = <&gpio 1 0>;
>>>>> 		};
>>>>>
>>>>> I guess that might make parsing/building a little harder, since you'd
>>>>> have to detect when you'd already done gpio_request() on a given GPIO
>>>>> and not repeat it or something like that, but to me this makes the DT a
>>>>> lot easier to comprehend.
>>>>
>>>> I tried to move towards having the phandles directly in the
>>>> sequences themselves - that reminded me why I did not do that in the
>>>> first place. Let's say we have a sequence like this (reg property
>>>> omitted on purpose):
>>>>
>>>> 	power-on-sequence {
>>>> 		step@0 {
>>>> 			regulator = <&backlight_reg>;
>>>> 			enable;
>>>> 		};
>>>> 		step@1 {
>>>> 			delay = <10000>;
>>>> 		};
>>>> 		step@2 {
>>>> 			pwm = <&pwm 2 5000000>;
>>>> 			enable;
>>>> 		};
>>>> 		step@3 {
>>>> 			gpio = <&gpio 28 0>;
>>>> 			enable;
>>>> 		};
>>>> 	};
>>>>
>>>> The problem is, how do we turn these phandles into the resource of
>>>> interest. The type of the resource can be infered by the name of the
>>>> property. The hard part is resolving the resource from the phandle -
>>>> it seems like the API just does not allow to do this. GPIO has
>>>> of_get_named_gpio, but AFAIK there are no equivalent for regulator
>>>> consumer and PWM: the only way to use the DT with them is through
>>>> get_regulator and get_pwm which work at the device level.
>>>>
>>>> Or is there a way that I overlooked?
>>>
>>> No, you are right. Perhaps we should add exported functions that do the
>>> equivalent of of_pwm_request() or the regulator_dev_lookup() and
>>> of_get_regulator() pair.
>>
>> How would that be looked with respect to "good DT practices"? I can
>> somehow understand the wish to restrain DT access to these functions
>> that integrate well with current workflows. Aren't we going to be
>> frowned upon if we make more low-level functions public?
>
> Yes, I think that's exactly what will happen.

Probably not worth to try this then?

Alex.
