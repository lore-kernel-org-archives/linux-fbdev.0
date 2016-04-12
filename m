From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Tue, 12 Apr 2016 11:32:55 +0000
Subject: Re: [PATCH v5 04/46] pwm: get rid of pwm->lock
Message-Id: <20160412133255.73cea027@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
	<1459368249-13241-5-git-send-email-boris.brezillon@free-electrons.com>
	<20160412112246.GJ18882@ulmo.ba.sec>
In-Reply-To: <20160412112246.GJ18882-EkSeR96xj6Pcmrwk2tT4+A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones@li>

Hi Thierry,

On Tue, 12 Apr 2016 13:22:46 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Mar 30, 2016 at 10:03:27PM +0200, Boris Brezillon wrote:
> > PWM devices are not protected against concurrent accesses. The lock in
> > pwm_device might let PWM users think it is, but it's actually only
> > protecting the enabled state.
> > 
> > Removing this lock should be fine as long as all PWM users are aware that
> > accesses to the PWM device have to be serialized, which seems to be the
> > case for all of them except the sysfs interface.
> > Patch the sysfs code by adding a lock to the pwm_export struct and making
> > sure it's taken for all accesses to the exported PWM device.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/pwm/core.c  | 19 ++++--------------
> >  drivers/pwm/sysfs.c | 57 ++++++++++++++++++++++++++++++++++++++++++-----------
> >  include/linux/pwm.h |  2 --
> >  3 files changed, 50 insertions(+), 28 deletions(-)
> 
> This is a little overzealous. Only accesses that can cause races need to
> be protected by the lock. All of the *_show() callbacks don't modify the
> PWM device in any way, so there is no need to protect them against
> concurrent accesses.

This is probably true for this set of changes, but what will happen
when we'll switch to the atomic API? There's no guarantee that
pwm->state = *newstate is done atomically, and you may see a partially
updated state when calling pwm_get_state() while another thread is
calling pwm_apply_state().

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
