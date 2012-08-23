From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 23 Aug 2012 17:19:36 +0000
Subject: Re: [PATCH] pwm: Call pwm_enable() before pwm_config()
Message-Id: <50366628.5020007@metafoo.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <36966374.2768747.1345741025741.JavaMail.root@advansee.com>
 <50366464.4070801@metafoo.de>
In-Reply-To: <50366464.4070801@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/23/2012 07:12 PM, Lars-Peter Clausen wrote:
>[...]
> Or maybe just use the runtime pm API for this. This probably makes even more
> sense and grab a reference to the pm context when the enable() is called,
> release it when disable() is called and also grab it before calling the
> device's config callback and release it afterward.

Btw. this seems to be exactly what the pwm-tiecap and pwm-tiehrpwm drivers
already do today. I'd just make that a core PWM framework feature.
