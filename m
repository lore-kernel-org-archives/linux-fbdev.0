From: Stephen Warren <swarren@wwwdotorg.org>
Date: Mon, 06 Aug 2012 16:16:39 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <501FEDE7.1060202@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com> <1343390750-3642-2-git-send-email-acourbot@nvidia.com> <50170EA0.1010408@wwwdotorg.org> <501A338D.7080105@nvidia.com> <20120802082157.GA14866@avionic-0098.adnet.avionic-design.de> <20120802181111.GM4537@opensource.wolfsonmicro.com> <501B2642.4080805@nvidia.com> <20120804141155.GJ10523@opensource.wolfsonmicro.com> <501F2BAA.8000808@nvidia.com>
In-Reply-To: <501F2BAA.8000808-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>

On 08/05/2012 08:27 PM, Alex Courbot wrote:
> On 08/04/2012 11:12 PM, Mark Brown wrote:
>> On Fri, Aug 03, 2012 at 10:15:46AM +0900, Alex Courbot wrote:
>>> On Fri 03 Aug 2012 03:11:12 AM JST, Mark Brown wrote:
>>
>>>> I missed some of the earlier bits of the thread here but why can't
>>>> we do
>>>> device based lookups?
...
> I think we only have two choices for this:
> 
> 1) Stick to the scheme where resources are declared at the device level,
> such as they can be referenced by name in the sub-nodes (basically what
> I did in this patch):
> 
> backlight {
>      compatible = "pwm-backlight";
>      ...
>      backlight-supply = <&backlight_reg>;
> 
>      power-on-sequence {
>          step@0 {
>              regulator = "backlight";
>              enable;
>          };
> 
> This would translate by a get_regulator(dev, "backlight") in the code
> which would be properly resolved.

Yes, upon reflection, that scheme does make sense. I withdraw the
comments I made re: whether it'd be better to just stick the phandles
into the steps.
