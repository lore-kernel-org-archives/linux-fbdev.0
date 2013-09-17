From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 17 Sep 2013 09:36:22 +0000
Subject: Re: [PATCH] pwm-backlight: allow for non-increasing brightness levels
Message-Id: <20130917093622.GB30088@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379010952-8928-1-git-send-email-mikedunn@newsguy.com>
In-Reply-To: <1379010952-8928-1-git-send-email-mikedunn-kFrNdAxtuftBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Dunn <mikedunn-kFrNdAxtuftBDgjK7y7TUQ@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Hi Mike,

On Thu, Sep 12, 2013 at 11:35:52AM -0700, Mike Dunn wrote:
> Currently the driver assumes that the values specified in the brightness-levels
> device tree property increase as they are parsed from left to right.  But boards
> that invert the signal between the PWM output and the backlight will need to
> specify decreasing brightness-levels.  This patch removes the assumption that
> the last element of the array is the max value, and instead searches the array
> for the max value and uses that as the normalizing value when determining the
> duty cycle.

Note there's also support for inverted PWMs in the PWM framework
provided your hardware supports this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
