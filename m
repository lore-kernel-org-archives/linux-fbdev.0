From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 16 Aug 2012 21:47:34 +0000
Subject: Re: [PATCH v4 0/3] Runtime Interpreted Power Sequences
Message-Id: <201208162347.34810.rjw@sisk.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345097337-24170-1-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1345097337-24170-1-git-send-email-acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

On Thursday, August 16, 2012, Alexandre Courbot wrote:
> Overdue revision of this new feature, some changes required additional thought
> and rework.
> 
> The most important change is in the way power sequences are expressed in the
> device tree. In order to avoid having to specify #address-cells, #size-cells and
> reg properties, the @ notation in the step names is dropped, and instead a
> fixed, sequential naming is adopted. The type of the resource used by a step is
> decided by the presence of some recognized properties:
> 
> power-on-sequence {
> 	step0 {
> 		regulator = "power";
> 		enable;
> 	};
> 	step1 {
> 		delay = <10000>;
> 	};
> 	step2 {
> 		pwm = "backlight";
> 		enable;
> 	};
> 	...
> 
> To me this looks safe, clear and close to the platform data representation, but
> needs approval from DT experts.
> 
> Resources are still referenced by name instead of having their phandles defined
> directly inside the sequences, as previous discussion came to the conclusion
> that doing so would require controversial changes to the regulator and PWM
> frameworks, and that having the resources declared at the device level was
> making sense logically speaking.
> 
> Other changes/fixes since last revision:
> * Move to drivers/power/ (hope this is ok with the maintainers?)
> * Use microseconds for delay
> * Use devm for PWM resources and remove cleanup function as all resources are
>   devm-managed
> * Remove "-gpio" suffix for GPIO reference in the driver
> * Remove params structure
> * Make power_seq structure private
> * Number of steps in a sequence is explicitly stated instead of resorting to a
>   "stop" sequence step
> * Delays are a step instead of being a step parameter
> * Use flexible member arrays to limit number of memory allocations
> * Add documentation to DT bindings
> 
> There was a lot of feedback on the previous version (thanks!) so if I forgot
> to address some important point, please bring it to my attention again.
> 
> Alexandre Courbot (3):
>   Runtime Interpreted Power Sequences
>   pwm_backlight: use power sequences
>   tegra: add pwm backlight device tree nodes

May I ask that the next version of this patchset be CCed to
linux-pm@vger.kernel.org?

Thanks,
Rafael
