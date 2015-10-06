From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Tue, 06 Oct 2015 10:09:35 +0000
Subject: Re: [PATCH v2 01/10] pwm: introduce default period and polarity concepts
Message-Id: <20151006100935.GK2694@piout.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
 <1437406327-6207-2-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1437406327-6207-2-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 20/07/2015 at 17:31:58 +0200, Boris Brezillon wrote :
> When requested by a user, the PWM is assigned a default period and polarity
> extracted from the DT, the platform data or statically set by the driver.
> Those default values are currently stored in the period and polarity
> fields of the pwm_device struct, but they will be stored somewhere else
> once we have introduced the architecture allowing for hardware state
> retrieval.
> 
> The pwm_set_default_polarity and pwm_set_default_period should only be
> used by PWM drivers or the PWM core infrastructure to specify the
> default period and polarity values.
> 
> PWM users might call the pwm_get_default_period to query the default
> period value. There is currently no helper to query the default
> polarity, but it might be added later on if there is a need for it.
> 
> This patch also modifies all the places where the default helpers should
> be used in place of the standard ones.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
