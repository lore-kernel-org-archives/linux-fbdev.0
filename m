From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 11 Jun 2015 12:30:05 +0000
Subject: Re: [PATCH 00/21] On-demand device registration
Message-Id: <CACRpkdaZgBR5rHwrEYqcm5K4w3y8MXG8a0k=Y+oQY+jukHfuyw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <CACRpkdasLwMfEHGMRd1X3K_DU7NMPreE8TMwqqDTg8k9wj=wJQ@mail.gmail.com>
 <CAAObsKCP-C+TY8Wkk6bQzxZeGYL9X01trtjxfaYp--ZnH07C+w@mail.gmail.com>
 <CACRpkdZuSj+S2x1yz6n5PgcRK=3ZCcq_To124b2Y+Oj54aydpg@mail.gmail.com>
 <5577F533.1060007@ahsoftware.de>
 <CACRpkdYF5K7ckGbgvZc6qRzGFJTQ4WqXdu_7Tcqczn2LkFbn3A@mail.gmail.com>
 <5579602F.1070801@ahsoftware.de>
In-Reply-To: <5579602F.1070801@ahsoftware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Holler <holler@ahsoftware.de>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, open@wandq.ahsoftware, dmaengine@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "list@wandq.ahsoftware:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Grant Likely <grant.likely@linaro.org>, Dan Williams <dan.j.williams@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-usb@vger.kernel.org" <linux-i2c@vger.>

On Thu, Jun 11, 2015 at 12:17 PM, Alexander Holler <holler@ahsoftware.de> wrote:
> Am 11.06.2015 um 10:12 schrieb Linus Walleij:
>> On Wed, Jun 10, 2015 at 10:28 AM, Alexander Holler <holler@ahsoftware.de>
>> wrote:

>>> You would end up with the same problem of deadlocks as currently, and you
>>> would still need something ugly like the defered probe brutforce to avoid
>>> them.
>>
>>
>> Sorry I don't get that. Care to elaborate on why?
>
>
> Because loading/initializing on demand doesn't give you any solved order of
> drivers to initialize. And it can't because it has no idea about the
> requirements of other drivers. The reason why it might work better in the
> case of the tegra is that it might give you another initialization order
> than the one which is currently choosen, which, by luck, might be a better
> one.
>
> But maybe I missed something, I haven't looked at the patches at all. But
> just loading on demand, can't magically give you a working order of drivers
> to initialize. E.g. how do you choose the first driver to initialize?

So the current patch set introduces dependencies (just for device tree)
and Tomeu is working on a more generic dependency approach for
any HW description.

The first driver to initialize will be as usual the first one in the list for
that initlevel, then walking up the initilevels.

However if any driver runs into a resource roadblock it will postpone
and wait for dependencies to probe first.

Certainly it is possible to create deadlocks in this scenario, but the
scope is not to create an ubreakable system.

Yours,
Linus Walleij
