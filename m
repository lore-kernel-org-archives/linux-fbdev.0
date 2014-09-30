From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Sep 2014 10:43:36 +0000
Subject: Re: [PATCH/RFC] fbdev: sh_mobile_hdmi: Re-init regs before irq re-enable on resume
Message-Id: <CAPDyKFoPUEuMEbedFARhQzJy5sFgw8w++KZk=H7CE946tiO77g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1411474918-2955-1-git-send-email-geert+renesas@glider.be>
	<542A84F7.5020005@ti.com>
In-Reply-To: <542A84F7.5020005@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On 30 September 2014 12:24, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi Geert, Ulf,
>
> On 23/09/14 15:21, Geert Uytterhoeven wrote:
>> When the PM domain containing the HDMI hardware block is powered down,
>> the HDMI register values (incl. interrupt polarity settings) are lost.
>> During resume, after powering up the PM domain, interrupts are
>> re-enabled, and an interrupt storm happens due to incorrect interrupt
>> polarity settings:
>>
>>     irq 163: nobody cared (try booting with the "irqpoll" option)
>>     ...
>>     Disabling IRQ #163
>>
>> To fix this, re-initialize the interrupt polarity settings, and the
>> htop1 register block (if present), during resume.
>>
>> As the .suspend_noirq() and .resume_noirq() callbacks are not called
>> when using the generic PM domain, the normal .resume() callback is used,
>> and the device interrupt needs to be disabled/enabled manually.
>>
>> This fixes resume from s2ram with power down of the A4MP PM domain on
>> r8a7740/Armadillo.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Is there a specific reason why the .suspend_noirq() and .resume_noirq()
>> callbacks are not called when using genpd, unlike .suspend(),
>> .suspend_late(), .resume_early(), and .resume()?
>> ---
>>  drivers/video/fbdev/sh_mobile_hdmi.c | 44 ++++++++++++++++++++++++++++++++++--
>>  1 file changed, 42 insertions(+), 2 deletions(-)
>
> Should I queue this version for 3.18, or is there some modifications you
> think needs to be done first?

I have no objections for this patch. Please go ahead.

The reason for my comments was to try to figure out if there were any
impact to the generic PM domain.

Kind regards
Uffe
