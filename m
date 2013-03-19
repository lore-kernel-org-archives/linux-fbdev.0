From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Tue, 19 Mar 2013 17:11:11 +0000
Subject: Re: [PATCH 10/10] drivers: misc: use module_platform_driver_probe()
Message-Id: <CAHkwnC9FL9W07=n6bWvcwiE058zcBZwqUwtRB-VVNpU0gv0mNw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
 <CAHkwnC9fg7_uhLM2KD3vvj_oFx3EBoQfw8mCN=V9pyV5=k37aA@mail.gmail.com>
 <CAMuHMdVS56HRDSvr7XCpVEjEWnGti+V=J_m4qQzEid=23ON_fQ@mail.gmail.com>
 <201303191648.31527.arnd@arndb.de>
In-Reply-To: <201303191648.31527.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Mar 19, 2013 at 5:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 19 March 2013, Geert Uytterhoeven wrote:
>> Hmm, so we may have drivers that (now) work perfectly fine with
>> module_platform_driver_probe()/platform_driver_probe(), but will start
>> failing suddenly in the future?
>
> They will fail if someone changes the initialization order. That would
> already break drivers before deferred probing support (and was the reason
> we added feature in the first place), but now we can be much more liberal
> with the order in which drivers are initialized, except when they are
> using platform_driver_probe()
>
>> I guess we need a big fat WARN_ON(-EPROBE_DEFER) in
>> platform_driver_probe() to catch these?
>
> Yes, very good idea.
>
>         Arnd

If it's fine, I'll send a patch for that.

Regards
--
Fabio Porcedda
