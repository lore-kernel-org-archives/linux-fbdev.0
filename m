From: Johan Hovold <jhovold@gmail.com>
Date: Thu, 03 May 2012 10:22:40 +0000
Subject: Re: [PATCH 1/4] mfd: add LM3533 lighting-power core driver
Message-Id: <1336040560-18185-1-git-send-email-jhovold@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120426124122.GA26692@sirena.org.uk>
In-Reply-To: <20120426124122.GA26692@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Richard Purdie <rpurdie@rpsys.net>, Johan Hovold <jhovold@gmail.com>

[ Sorry for the resend -- Android/gmail apparently added HTML to my previous
  attempt. ] 

On Apr 26, 2012 2:41 PM, "Mark Brown" <broonie@opensource.wolfsonmicro.com>
wrote:
> On Fri, Apr 20, 2012 at 05:30:23PM +0200, Johan Hovold wrote:
> > +static int __lm3533_read(struct lm3533 *lm3533, u8 reg, u8 *val)
> > +{
> > +     int ret;
> > +
> > +     ret = lm3533->read(lm3533, reg, val);
> > +     if (ret < 0) {
>
> Looks like you could save a bunch of code by using regmap for the
> register I/O.  This would also give you access to the cache and
> diagnostic infrastructure it has.

Using regmap only saves about ten lines for the actual io implementation,
but it does allow me to get rid of the custom debugfs interface. I'm not
enabling caching at this point but it'll probably come in handy later.

Thanks,
Johan
