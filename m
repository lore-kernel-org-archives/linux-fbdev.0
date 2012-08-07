From: Alex Courbot <acourbot@nvidia.com>
Date: Tue, 07 Aug 2012 05:10:10 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <5020A332.3010206@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com> <1343390750-3642-2-git-send-email-acourbot@nvidia.com> <50170EA0.1010408@wwwdotorg.org> <501A338D.7080105@nvidia.com> <20120802082157.GA14866@avionic-0098.adnet.avionic-design.de> <20120802181111.GM4537@opensource.wolfsonmicro.com> <501B2642.4080805@nvidia.com> <20120804141155.GJ10523@opensource.wolfsonmicro.com> <501F2BAA.8000808@nvidia.com> <501FEDE7.1060202@wwwdotorg.org>
In-Reply-To: <501FEDE7.1060202@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@nvidia.com>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Thierry Reding <thierry.reding@avionic-design.de>

On 08/07/2012 01:16 AM, Stephen Warren wrote:
> On 08/05/2012 08:27 PM, Alex Courbot wrote:
>> On 08/04/2012 11:12 PM, Mark Brown wrote:
>>> On Fri, Aug 03, 2012 at 10:15:46AM +0900, Alex Courbot wrote:
>>>> On Fri 03 Aug 2012 03:11:12 AM JST, Mark Brown wrote:
>>>
>>>>> I missed some of the earlier bits of the thread here but why can't
>>>>> we do
>>>>> device based lookups?
> ...
>> I think we only have two choices for this:
>>
>> 1) Stick to the scheme where resources are declared at the device level,
>> such as they can be referenced by name in the sub-nodes (basically what
>> I did in this patch):
>>
>> backlight {
>>       compatible = "pwm-backlight";
>>       ...
>>       backlight-supply = <&backlight_reg>;
>>
>>       power-on-sequence {
>>           step@0 {
>>               regulator = "backlight";
>>               enable;
>>           };
>>
>> This would translate by a get_regulator(dev, "backlight") in the code
>> which would be properly resolved.
>
> Yes, upon reflection, that scheme does make sense. I withdraw the
> comments I made re: whether it'd be better to just stick the phandles
> into the steps.

Right - having the phandles directly in the sequences has its merits, 
but logically speaking resources are related to a device, so this 
declarative approach is probably closer to reality anyway.

I will revise the patch according to all the feedback received and 
submit a new version soon.

Thanks,
Alex.


