From: Alex Courbot <acourbot@nvidia.com>
Date: Fri, 17 Aug 2012 08:54:32 +0000
Subject: Re: [PATCH v4 0/3] Runtime Interpreted Power Sequences
Message-Id: <502E06C8.8090508@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345097337-24170-1-git-send-email-acourbot@nvidia.com> <201208162347.34810.rjw@sisk.pl>
In-Reply-To: <201208162347.34810.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Stephen Warren <swarren@nvidia.com>, Thierry Reding <thierry.reding@avionic-design.de>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Leela Krishna Amudala <leelakrishna.a@gmail.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On 08/17/2012 06:47 AM, Rafael J. Wysocki wrote:
> On Thursday, August 16, 2012, Alexandre Courbot wrote:
>> Overdue revision of this new feature, some changes required additional thought
>> and rework.
>>
>> The most important change is in the way power sequences are expressed in the
>> device tree. In order to avoid having to specify #address-cells, #size-cells and
>> reg properties, the @ notation in the step names is dropped, and instead a
>> fixed, sequential naming is adopted. The type of the resource used by a step is
>> decided by the presence of some recognized properties:
>>
>> power-on-sequence {
>> 	step0 {
>> 		regulator = "power";
>> 		enable;
>> 	};
>> 	step1 {
>> 		delay = <10000>;
>> 	};
>> 	step2 {
>> 		pwm = "backlight";
>> 		enable;
>> 	};
>> 	...
>>
>> To me this looks safe, clear and close to the platform data representation, but
>> needs approval from DT experts.
>>
>> Resources are still referenced by name instead of having their phandles defined
>> directly inside the sequences, as previous discussion came to the conclusion
>> that doing so would require controversial changes to the regulator and PWM
>> frameworks, and that having the resources declared at the device level was
>> making sense logically speaking.
>>
>> Other changes/fixes since last revision:
>> * Move to drivers/power/ (hope this is ok with the maintainers?)
>> * Use microseconds for delay
>> * Use devm for PWM resources and remove cleanup function as all resources are
>>    devm-managed
>> * Remove "-gpio" suffix for GPIO reference in the driver
>> * Remove params structure
>> * Make power_seq structure private
>> * Number of steps in a sequence is explicitly stated instead of resorting to a
>>    "stop" sequence step
>> * Delays are a step instead of being a step parameter
>> * Use flexible member arrays to limit number of memory allocations
>> * Add documentation to DT bindings
>>
>> There was a lot of feedback on the previous version (thanks!) so if I forgot
>> to address some important point, please bring it to my attention again.
>>
>> Alexandre Courbot (3):
>>    Runtime Interpreted Power Sequences
>>    pwm_backlight: use power sequences
>>    tegra: add pwm backlight device tree nodes
>
> May I ask that the next version of this patchset be CCed to
> linux-pm@vger.kernel.org?

Will do.

Alex.

