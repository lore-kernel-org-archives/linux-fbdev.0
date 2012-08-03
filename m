From: Alex Courbot <acourbot@nvidia.com>
Date: Fri, 03 Aug 2012 01:15:46 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <501B2642.4080805@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com> <1343390750-3642-2-git-send-email-acourbot@nvidia.com> <50170EA0.1010408@wwwdotorg.org> <501A338D.7080105@nvidia.com> <20120802082157.GA14866@avionic-0098.adnet.avionic-design.de> <20120802181111.GM4537@opensource.wolfsonmicro.com>
In-Reply-To: <20120802181111.GM4537-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>

On Fri 03 Aug 2012 03:11:12 AM JST, Mark Brown wrote:
> On Thu, Aug 02, 2012 at 10:21:57AM +0200, Thierry Reding wrote:
>> On Thu, Aug 02, 2012 at 05:00:13PM +0900, Alex Courbot wrote:
>
>>> The problem is, how do we turn these phandles into the resource of
>>> interest. The type of the resource can be infered by the name of the
>>> property. The hard part is resolving the resource from the phandle -
>>> it seems like the API just does not allow to do this. GPIO has
>>> of_get_named_gpio, but AFAIK there are no equivalent for regulator
>>> consumer and PWM: the only way to use the DT with them is through
>>> get_regulator and get_pwm which work at the device level.
>
>>> Or is there a way that I overlooked?
>
>> No, you are right. Perhaps we should add exported functions that do the
>> equivalent of of_pwm_request() or the regulator_dev_lookup() and
>> of_get_regulator() pair.
>
> I missed some of the earlier bits of the thread here but why can't we do
> device based lookups?

That is because the phandles would not be properties of the device node 
but rather of its sub-nodes:

backlight {
     compatible = "pwm-backlight";
     ...
     power-on-sequence {
         step@0 {
             regulator = <&backlight_reg>;
             enable;
         };


So here simply using regulator_get on the backlight device would not work.

Alex.
