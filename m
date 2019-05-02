From: Brian Masney <masneyb@onstation.org>
Date: Thu, 02 May 2019 10:42:39 +0000
Subject: Re: [PATCH v6 1/3] backlight: lm3630a: return 0 on success in update_status functions
Message-Id: <20190502104239.GA24563@basecamp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190424092505.6578-1-masneyb@onstation.org>
 <20190424092505.6578-2-masneyb@onstation.org>
 <864c1ddc-1008-0041-1559-e491ca0186ef@linaro.org>
In-Reply-To: <864c1ddc-1008-0041-1559-e491ca0186ef@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: lee.jones@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dmurphy@ti.com, jonathan@marek.ca, Daniel Thompson <daniel@redfelineninja.org.uk>

On Thu, May 02, 2019 at 11:07:51AM +0100, Daniel Thompson wrote:
> On 24/04/2019 10:25, Brian Masney wrote:
> > lm3630a_bank_a_update_status() and lm3630a_bank_b_update_status()
> > both return the brightness value if the brightness was successfully
> > updated. Writing to these attributes via sysfs would cause a 'Bad
> > address' error to be returned. These functions should return 0 on
> > success, so let's change it to correct that error.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > Fixes: 28e64a68a2ef ("backlight: lm3630: apply chip revision")
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> Hi Brian, sorry for the delay. For some reason your mails are being dumped
> before they reach me so I only discovered these patches when I paid proper
> attention to the replies and fetched them from patchwork.
> 
> Hi Lee, is the same thing happening for you? ;-)

Huh, that's odd. I haven't ran into that issue when working with people
from Linaro in other subsystems.

As a sanity check, I used 'git send-email' to send this patch to
check-auth@verifier.port25.com and it verified that I still have SPF,
DKIM, reverse DNS, etc. all setup properly on this domain.

hotmail.com addresses are the only ones I've had issues with in the
past, but I doubt you're forwarding your email there. :)

Brian
