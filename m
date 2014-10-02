From: Stephen Warren <swarren@wwwdotorg.org>
Date: Thu, 02 Oct 2014 15:49:09 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <542D73F5.9040605@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140929101805.GB26008@ulmo>	<20140929114643.GB4081@lukather>	<20140929134708.GB30998@ulmo>	<20140929155517.GR16977@sirena.org.uk>	<20140930050923.GB29874@ulmo>	<20140930173928.GH4273@sirena.org.uk>	<20141001074139.GB18463@ulmo>	<CABxcv=nKErHGPRLM5yer2YnOc2VJPWLmeKgwXbXEU3r_XvsCyg@mail.gmail.com>	<20141001123250.GY4273@sirena.org.uk>	<20141001124800.GA21733@ulmo>	<20141001170517.GF4273@sirena.org.uk>	<542C3934.3040409@redhat.com>
 <CAKON4OxzerMyuza-GSfmYiLMqA=Y3HOXko7a8rOcP_8PkHVF3w@mail.gmail.com>
 <542C4404.8040501@wwwdotorg.org> <542CF3C3.2050708@redhat.com>
In-Reply-To: <542CF3C3.2050708@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 10/02/2014 12:42 AM, Hans de Goede wrote:
...
> The whole reason why we want to use simplefb is not just to get things
> running until HW specific driver is in place, but also to have early console
> output (to help debugging boot problems on devices without a serial console),
> in a world where most video drivers are build as loadable modules, so we
> won't have video output until quite late into the boot process.

That's a very different use-case than what was originally envisaged.

...
> You indicate that you don't have the time for this discussion, and I note that
> there is no MAINTAINERS entry for drivers/video/fbdev/simplefb.c . So how about
> the following, I pick up drivers/video/fbdev/simplefb.c maintainership, adding
> MAINTAINERS entry for it with my name in it. Then as the maintainer it will be
> my responsibility (and in my own benefit) to stop this from growing into
> a monster ?

I have no issue with you being the maintainer.

I would suggest you track down whoever it was that was involved in the 
original discussion and objected to simplefb performing resource 
management, and get their explicit ack for the addition of 
clocks/regulators/... to it. But, that's just a suggestion.
