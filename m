From: Alexander Holler <holler@ahsoftware.de>
Date: Sat, 13 Jun 2015 18:27:21 +0000
Subject: Re: [PATCH 00/21] On-demand device registration
Message-Id: <557C7609.30400@ahsoftware.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>	<CACRpkdasLwMfEHGMRd1X3K_DU7NMPreE8TMwqqDTg8k9wj=wJQ@mail.gmail.com>	<CAAObsKCP-C+TY8Wkk6bQzxZeGYL9X01trtjxfaYp--ZnH07C+w@mail.gmail.com>	<CACRpkdZuSj+S2x1yz6n5PgcRK=3ZCcq_To124b2Y+Oj54aydpg@mail.gmail.com>	<5577F533.1060007@ahsoftware.de>	<CACRpkdYF5K7ckGbgvZc6qRzGFJTQ4WqXdu_7Tcqczn2LkFbn3A@mail.gmail.com>	<5579602F.1070801@ahsoftware.de>	<CACRpkdaZgBR5rHwrEYqcm5K4w3y8MXG8a0k=Y+oQY+jukHfuyw@mail.gmail.com>	<5579B9E8.9040609@ahsoftware.de>
 <CACRpkdbDSS0yw=q_cR17Bvg+kgTfU3Vcd2gSjx1p4V-CzOZ_SA@mail.gmail.com>
 <557AC040.40803@ahsoftware.de> <557AC437.9000607@ahsoftware.de>
In-Reply-To: <557AC437.9000607@ahsoftware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, dmaengine@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, DRM PANEL DRIVERS <dri-devel@lists.freedesktop.org>, Grant Likely <grant.likely@linaro.org>, Dan Williams <dan.j.williams@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-usb@vger.kernel.org, linux-i2c@vger.kernel.org

Am 12.06.2015 um 13:36 schrieb Alexander Holler:
> Am 12.06.2015 um 13:19 schrieb Alexander Holler:
>> Am 12.06.2015 um 09:25 schrieb Linus Walleij:
>>> On Thu, Jun 11, 2015 at 6:40 PM, Alexander Holler
>>> <holler@ahsoftware.de> wrote:
>>>> Am 11.06.2015 um 14:30 schrieb Linus Walleij:
>>>
>>>>> Certainly it is possible to create deadlocks in this scenario, but the
>>>>> scope is not to create an ubreakable system.
>>>>
>>>> IAnd what happens if you run into a deadlock? Do you print "you've
>>>> lost, try
>>>> changing your kernel config" in some output hidden by a
>>>> splash-screen? ;)
>>>
>>> Sorry it sounds like a blanket argument, the fact that there are
>>> mutexes in the kernel makes it possible to deadlock, it doesn't
>>> mean we don't use mutexes. Some programming problems are
>>> just like such.
>>
>> I'm not talking about specific deadlocks through mutexes. I'm talking
>> about what happens when driver A needs driver B which needs driver A.
>> How do you recognise and handle that with your instrumented on-demand
>> device initialization? Such a circular dependency might happen by just
>> adding a new fucntion call or by changing the kernel configuration. And
>> with the on-demand stuff, the possibility that the developer introducing
>> this new (maybe optional) call will never hit such a circular dependency
>> is high. So you will end up with a never ending stream of problem
>> reports whenever someone introduced such a circular dependecy without
>> having noticed it.
>>
>> And to come back to specific deadlocks, if you are extending function
>> calls from something former simple to something which might initialize a
>> whole bunch of drivers, needing maybe seconds, I wouldn't say this is a
>> blanket argument, but a real thread.
>
> Keep in mind, that the possibility that a function call ends up with
> initializing a whole bunch of other drivers, is not determined
> statically, but depends on the configuration and runtime behaviour of
> the actual system the on-demand stuff actually happens.
>
> E.g. if driver A is faster one system that driver B, the whole bunch of
> drivers might become initialized by a call in driver A. But if driver B
> was faster on the developers system (or the system is configured to
> first init driver B), than the whole bunch of drivers might have become
> initialized by driver B on the developers system. Thus he never might
> have hit a possible problem when the whole bunch of drivers got
> initialized in driver A.
>
> That means it isn't always a good idea to create dynamic systems (like
> on-demand device initialization), because it's very hard to foresee and
> correctly handle their runtime behaviour.

And because you've said that "problem space is a bit convoluted" and I 
disagree, here's a summary from my point of view:

1. All the necessary information (dependencies between drivers) already 
exists at compile time. The set of dependencies between drivers might 
become smaller by configuration, but will not become larger. So there 
should be NO need to collect them at runtime, e.g. by instrumenting 
function calls. I've described the problems I see with that above. I've 
choosen DT as source of dependencies because it offers an easy 
accessible and almost complete set of dependencies. I just had to add 
some type information to the dtb in order to identify the dependencies 
(phandles). But other ways to collect the dependencies would work too. 
Even the most simple way to add a static list of dependencies to each 
driver (which later on might be automated by some more clever stuff than 
adding them manually) would do the trick.

2. The problem to sort a set of nodes (drivers) with dependencies is 
solved since a long time and almost any developers uses it regularly in 
form of make. And everyone who used make -jN knows that the possible 
parallel initialization of drivers I've talked about, is already solved too.

3. In order to initialize the drivers in some specific order, their 
initcalls must be identified. I've offered a possible solution to that 
without much changes, but many other, even better ways, are possible 
too. It just depends on how much you want to change and on how much of 
these changes you will be able to feed into mainline kernel (which 
depends on your connections/relations inside the core kernel crew). E.g. 
instead of still just relying on one-dimensional arrays with (anonymous) 
pointers to initcalls, a multidimensional array of initcalls and 
drivername (and maybe more information) might be thinkable.

4. x86/amd64/ACPI-people, so most longtime and core kernel maintainers 
obviously don't have much interest until you've solved 1. in a way they 
can use too. So the necessary changes for 2. or 3. will have a big 
hurdle to take if 1. isn't solved usable for them too.

>> Alexander Holler

