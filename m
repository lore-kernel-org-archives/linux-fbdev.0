From: =?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=  <benoit.thebaudeau@advansee.com>
Date: Thu, 23 Aug 2012 16:57:05 +0000
Subject: Re: [PATCH] pwm: Call pwm_enable() before pwm_config()
Message-Id: <36966374.2768747.1345741025741.JavaMail.root@advansee.com>
List-Id: <linux-fbdev.vger.kernel.org>
In-Reply-To: <50364FA4.7000401@metafoo.de>
References: <217877237.2758643.1345731587941.JavaMail.root@advansee.com>
In-Reply-To: <217877237.2758643.1345731587941.JavaMail.root@advansee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Thursday, August 23, 2012 5:43:32 PM, Lars-Peter Clausen wrote:
> On 08/23/2012 04:19 PM, Benoît Thébaudeau wrote:
> > Some PWM drivers enable the clock of the PWM peripheral in
> > pwm_enable(). Hence,
> > for these drivers, a call to pwm_config() does not have any effect
> > before
> > pwm_enable() has been called.
> > 
> > This patch fixes the PWM users to make sure that they call
> > pwm_enable() before
> > pwm_config().
> > 
> > This fixes the first setting of brightness through sysfs that had
> > no effect with
> > leds-pwm and the i.MX PWM driver.
> 
> But isn't this a bug in the PWM peripheral driver? With this change
> the PWM
> will start with the old settings first. While this is not so much of
> a problem
> for a backlight (although it might cause a short flickering) it might
> cause
> problems for other applications, like using the PWM pin as a timing
> generator.
> In my opinion it's better to fix the PWM peripheral drivers which
> have this
> problem instead of trying to work around it in every user of the PWM
> API.

I don't know. See my detailed description of this issue here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/115667.html

Where the bug is depends on the detailed definition of the PWM API, which I
don't find documented anywhere.

If pwm_enable() means "start PWM timer with the configured settings", then the
bug is in the drivers. If it means "enable the PWM peripheral so that we can
work with it", then the bug is in the PWM users.

I don't really have time to work on this, so I suggested this patch as a simple
solution. Otherwise, it means reworking several PWM drivers for different
hardware that is not available to everyone for testing.

If we decide to only change the i.MX PWM driver, the fix would be:
pwm_config()
{
        save passed config in private data;
        if (pwm enabled)
                apply passed config;
}

pwm_enable()
{
        if (!(pwm enabled)) {
                enable pwm ip clk;
                apply config from private data;
        }
}

If we fix only this driver, we must not forget that the same issue probably
exists with several other PWM drivers.

As I said in my bug description, the PWM users set the duty cycle to 0 before
calling pwm_disable(), so fixing the PWM users should not be an issue, even in
the timing generator use case you're talking about.

I don't have a strong opinion about what should be fixed here.

Best regards,
Benoît
