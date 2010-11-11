From: Daniel Drake <dsd@laptop.org>
Date: Thu, 11 Nov 2010 17:07:29 +0000
Subject: Re: [PATCH 2/2] viafb: Add OLPC XO-1.5 port configs
Message-Id: <AANLkTimSP=7tH7ZbZNA4tf1-K_TU6F9=uY-EyJEkP4MW@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921153726.21D609D401B@zog.reactivated.net>
In-Reply-To: <20100921153726.21D609D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 11 November 2010 16:01, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> sorry for the delay, but I'm very busy at the moment.
> I already pushed those patches forward to my -next branch and it should be
> in the linux-next branch of today.
> I'm still not happy with how GPIO or more precisely I2C on GPIO ports is
> handled. But given that I don't have much time at the moment and that there
> are more important things in viafb that require work and most important that
> I don't see any opportunity/hardware to test whether the current (or an
> alternative) implementation allows I2C devices work on port 2C pushing this
> patch forward seems reasonable. I only removed the #ifdefs as you suggested
> in your last email to make the code more readable.
> The other two patches were good.

Thanks!
I'm open to testing new approaches if/when they appear.

Daniel
