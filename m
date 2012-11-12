From: Pantelis Antoniou <panto@antoniou-consulting.com>
Date: Mon, 12 Nov 2012 10:21:39 +0000
Subject: Re: [PATCH] pwm-backlight: Pinctrl-fy
Message-Id: <29FD452C-C0A0-4D22-BB52-823ACCD0D479@antoniou-consulting.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351699047-4487-1-git-send-email-panto@antoniou-consulting.com> <20121109080604.GA25611@avionic-0098.mockup.avionic-design.de> <CACRpkdY_sXu12k455XcEBOj3_3syxromdCWObE4didKiU_F2cA@mail.gmail.com>
In-Reply-To: <CACRpkdY_sXu12k455XcEBOj3_3syxromdCWObE4didKiU_F2cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org

Hi Linus,

On Nov 11, 2012, at 7:26 PM, Linus Walleij wrote:

> On Fri, Nov 9, 2012 at 9:06 AM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
>> On Wed, Oct 31, 2012 at 05:57:27PM +0200, Pantelis Antoniou wrote:
> 
>>> +     pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
>>> +     if (IS_ERR(pinctrl))
>>> +             dev_warn(&pdev->dev, "unable to select pin group\n");
>>> +
>> 
>> I just saw this done in a similar way in some other driver and then
>> remembered your patch. When I reviewed this I wasn't sure if a warning
>> was good enough in this case. I've checked the kernel tree and it seems
>> like a majority handled this as failure instead of a warning. I took a
>> look at the pinctrl core and it seems like indeed if neither pinctrl is
>> enabled or if there isn't actually a pinmux configuration for a device,
>> then devm_pinctrl_get_select_default() will actually not return an
>> error, so in those cases where an error is returned it should actually
>> be handled as a fatal error.
> 
> So it depends.
> 
> One good reason to just error out and return the error code is
> if the error returned is -EPROBE_DEFER, right?
> 
> Because then you're pinctrl driver is not up yet, and you
> need to bail out and be revisited later.
> 
> On a related key we have this debate going on with some
> subsystem maintainers as to whether we should try do
> centralize boilerplate like this, the lates suggestion is:
> http://marc.info/?l=linux-kernel&m5263661110528&w=2
> 

Interesting... This is certainly much nicer than peppering all the
devices with pinctrl calls.

> The fun never ends...
> 

Indeed.

> Yours,
> Linus Walleij

Regards

-- Pantelis

