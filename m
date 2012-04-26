From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 26 Apr 2012 12:41:23 +0000
Subject: Re: [PATCH 1/4] mfd: add LM3533 lighting-power core driver
Message-Id: <20120426124122.GA26692@sirena.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334935826-12527-1-git-send-email-jhovold@gmail.com>
 <1334935826-12527-2-git-send-email-jhovold@gmail.com>
In-Reply-To: <1334935826-12527-2-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johan Hovold <jhovold@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, Apr 20, 2012 at 05:30:23PM +0200, Johan Hovold wrote:

> +static int __lm3533_read(struct lm3533 *lm3533, u8 reg, u8 *val)
> +{
> +	int ret;
> +
> +	ret = lm3533->read(lm3533, reg, val);
> +	if (ret < 0) {

Looks like you could save a bunch of code by using regmap for the
register I/O.  This would also give you access to the cache and
diagnostic infrastructure it has.
