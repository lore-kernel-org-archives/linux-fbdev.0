From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Mar 2013 11:28:48 +0000
Subject: Re: [PATCH 10/10] drivers: misc: use module_platform_driver_probe()
Message-Id: <201303151128.48432.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
 <20130314140631.GM1906@pengutronix.de>
 <CAHkwnC9nGsdgOTQZ6VpeDyPWXw7tpP+2oHvnLv6LEr1cNdnrsg@mail.gmail.com>
In-Reply-To: <CAHkwnC9nGsdgOTQZ6VpeDyPWXw7tpP+2oHvnLv6LEr1cNdnrsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday 15 March 2013, Fabio Porcedda wrote:
> >> * Regarding the use of module_platform_driver_probe, I'm a little worried about
> >>   the interactions with deferred probing. I don't think there are any regressions,
> >>   but we should probably make people aware that one cannot return -EPROBE_DEFER
> >>   from a platform_driver_probe function.
> 
> The use of module_platform_driver_probe() doesn't change anything about that,
> it's exactly the same thing as using "return platform_driver_probe()".
> I'm right or I'm missing something? Maybe are you just speaking about
> the misuse of "platform_driver_probe"?

Yes, that was what I meant. The point is that if we need to review or remove
all uses of platform_driver_probe, it would be better not to introduce a
module_platform_driver_probe() interface to make it easier to use.

	Arnd
