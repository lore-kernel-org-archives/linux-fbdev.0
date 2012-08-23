From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 23 Aug 2012 15:43:32 +0000
Subject: Re: [PATCH] pwm: Call pwm_enable() before pwm_config()
Message-Id: <50364FA4.7000401@metafoo.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <217877237.2758643.1345731587941.JavaMail.root@advansee.com>
In-Reply-To: <217877237.2758643.1345731587941.JavaMail.root@advansee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On 08/23/2012 04:19 PM, Benoît Thébaudeau wrote:
> Some PWM drivers enable the clock of the PWM peripheral in pwm_enable(). Hence,
> for these drivers, a call to pwm_config() does not have any effect before
> pwm_enable() has been called.
> 
> This patch fixes the PWM users to make sure that they call pwm_enable() before
> pwm_config().
> 
> This fixes the first setting of brightness through sysfs that had no effect with
> leds-pwm and the i.MX PWM driver.

But isn't this a bug in the PWM peripheral driver? With this change the PWM
will start with the old settings first. While this is not so much of a problem
for a backlight (although it might cause a short flickering) it might cause
problems for other applications, like using the PWM pin as a timing generator.
In my opinion it's better to fix the PWM peripheral drivers which have this
problem instead of trying to work around it in every user of the PWM API.

- Lars
