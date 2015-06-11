From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Thu, 11 Jun 2015 13:09:45 +0000
Subject: Re: [PATCH 00/21] On-demand device registration
Message-Id: <55798899.10504@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>	<CACRpkdasLwMfEHGMRd1X3K_DU7NMPreE8TMwqqDTg8k9wj=wJQ@mail.gmail.com>	<CAAObsKCP-C+TY8Wkk6bQzxZeGYL9X01trtjxfaYp--ZnH07C+w@mail.gmail.com>	<CACRpkdZuSj+S2x1yz6n5PgcRK=3ZCcq_To124b2Y+Oj54aydpg@mail.gmail.com>	<5577F533.1060007@ahsoftware.de>
 <CACRpkdYF5K7ckGbgvZc6qRzGFJTQ4WqXdu_7Tcqczn2LkFbn3A@mail.gmail.com>
 <5579602F.1070801@ahsoftware.de>
In-Reply-To: <5579602F.1070801@ahsoftware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Holler <holler@ahsoftware.de>, Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, open@wandq.ahsoftware, dmaengine@vger.kernel.org, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "list@wandq.ahsoftware:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Grant Likely <grant.likely@linaro.org>, Dan Williams <dan.j.williams@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-usb@vger.kernel.org" <linux-i2c@vger.kernel.org>

On 06/11/2015 12:17 PM, Alexander Holler wrote:
> Am 11.06.2015 um 10:12 schrieb Linus Walleij:
>> On Wed, Jun 10, 2015 at 10:28 AM, Alexander Holler <holler@ahsoftware.de> wrote:
>>> Am 10.06.2015 um 09:30 schrieb Linus Walleij:
>>
>>>> i2c host comes out, probes the regulator driver, regulator driver
>>>> probes and then the regulator_get() call returns.
>>>>
>>>> This requires instrumentation on anything providing a resource
>>>> to another driver like those I mentioned and a lot of overhead
>>>> infrastructure, but I think it's the right approach. However I don't
>>>> know if I would ever be able to pull that off myself, I know talk
>>>> is cheap and I should show the code instead.
>>>
>>> You would end up with the same problem of deadlocks as currently, and you
>>> would still need something ugly like the defered probe brutforce to avoid
>>> them.
>>
>> Sorry I don't get that. Care to elaborate on why?
> 
> Because loading/initializing on demand doesn't give you any solved order 
> of drivers to initialize. And it can't because it has no idea about the 
> requirements of other drivers.

So, this is only about ordering device probing. All built-in drivers
have already registered themselves by when we start probing.

> The reason why it might work better in 
> the case of the tegra is that it might give you another initialization 
> order than the one which is currently choosen, which, by luck, might be 
> a better one.

Note that this series was also tested on iMX.6, Exynos and OMAP4.

> But maybe I missed something, I haven't looked at the patches at all. 

It's a really small patchset :)

  19 files changed, 130 insertions(+), 45 deletions(-)

Thanks,

Tomeu

> But just loading on demand, can't magically give you a working order of 
> drivers to initialize. E.g. how do you choose the first driver to 
> initialize?
> 
> Regards,
> 
> Alexander Holler
> 

