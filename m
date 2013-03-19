From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 Mar 2013 16:48:31 +0000
Subject: Re: [PATCH 10/10] drivers: misc: use module_platform_driver_probe()
Message-Id: <201303191648.31527.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
 <CAHkwnC9fg7_uhLM2KD3vvj_oFx3EBoQfw8mCN=V9pyV5=k37aA@mail.gmail.com>
 <CAMuHMdVS56HRDSvr7XCpVEjEWnGti+V=J_m4qQzEid=23ON_fQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVS56HRDSvr7XCpVEjEWnGti+V=J_m4qQzEid=23ON_fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 19 March 2013, Geert Uytterhoeven wrote:
> Hmm, so we may have drivers that (now) work perfectly fine with
> module_platform_driver_probe()/platform_driver_probe(), but will start
> failing suddenly in the future?

They will fail if someone changes the initialization order. That would
already break drivers before deferred probing support (and was the reason
we added feature in the first place), but now we can be much more liberal
with the order in which drivers are initialized, except when they are
using platform_driver_probe()

> I guess we need a big fat WARN_ON(-EPROBE_DEFER) in
> platform_driver_probe() to catch these?

Yes, very good idea.

	Arnd
