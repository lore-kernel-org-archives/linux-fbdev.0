From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Mon, 21 Sep 2015 18:20:29 +0000
Subject: Re: [PATCH v3 01/12] pwm: introduce default period and polarity concepts
Message-Id: <877fnjr5w2.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1442828009-6241-2-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1442828009-6241-2-git-send-email-boris.brezillon@free-electrons.com>
 (Boris Brezillon's message of "Mon, 21 Sep 2015 11:33:18 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Boris Brezillon <boris.brezillon@free-electrons.com> writes:

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
For pwm-pxa.c :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
