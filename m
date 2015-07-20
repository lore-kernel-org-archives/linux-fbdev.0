From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 20 Jul 2015 10:01:16 +0000
Subject: Re: [RFC PATCH 06/15] pwm: define a new pwm_state struct
Message-Id: <20150720120116.2358b829@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-7-git-send-email-boris.brezillon@free-electrons.com>
 <20150720080458.GG29614@ulmo>
In-Reply-To: <20150720080458.GG29614@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 20 Jul 2015 10:04:59 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Jul 01, 2015 at 10:21:52AM +0200, Boris Brezillon wrote:
> [...]
> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> [...]
> > +struct pwm_state {
> > +	unsigned int		period; 	/* in nanoseconds */
> > +	unsigned int		duty_cycle;	/* in nanoseconds */
> > +	enum pwm_polarity	polarity;
> > +};
> 
> No need for the extra padding here.

What do you mean by "extra padding" ?
I just reused the indentation used in the pwm_device struct.

Would you prefer something like that ?

struct pwm_state {
	unsigned int period; 		/* in nanoseconds */
	unsigned int duty_cycle;	/* in nanoseconds */
	enum pwm_polarity polarity;
};

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
