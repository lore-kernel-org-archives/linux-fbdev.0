From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Wed, 20 Mar 2013 09:02:23 +0000
Subject: Re: [PATCH 10/10] drivers: misc: use module_platform_driver_probe()
Message-Id: <CAHkwnC-3_dDM3JO8y3yeNFz7=fpP=MtZ9D-3cMH8rNF9C1NZBA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
 <201303191648.31527.arnd@arndb.de>
 <CAHkwnC9FL9W07=n6bWvcwiE058zcBZwqUwtRB-VVNpU0gv0mNw@mail.gmail.com>
 <201303191759.27762.arnd@arndb.de>
In-Reply-To: <201303191759.27762.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Mar 19, 2013 at 6:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 19 March 2013, Fabio Porcedda wrote:
>> On Tue, Mar 19, 2013 at 5:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 19 March 2013, Geert Uytterhoeven wrote:
>> >> Hmm, so we may have drivers that (now) work perfectly fine with
>> >> module_platform_driver_probe()/platform_driver_probe(), but will start
>> >> failing suddenly in the future?
>> >
>> > They will fail if someone changes the initialization order. That would
>> > already break drivers before deferred probing support (and was the reason
>> > we added feature in the first place), but now we can be much more liberal
>> > with the order in which drivers are initialized, except when they are
>> > using platform_driver_probe()
>> >
>> >> I guess we need a big fat WARN_ON(-EPROBE_DEFER) in
>> >> platform_driver_probe() to catch these?
>> >
>> > Yes, very good idea.
>>
>> If it's fine, I'll send a patch for that.
>
> That would be cool, yes. I looked at it earlier (after sending my email above)
> and couldn't find an easy way to do it though, because platform_drv_probe
> does not know whether it is called from platform_driver_probe or not.
>
> Maybe using something other than platform_driver_register would work here.
>
>         Arnd

I think we can check inside the  deferred_probe_work_func()
if the dev->probe function pointer is equal to platform_drv_probe_fail().

Regards
--
Fabio Porcedda
