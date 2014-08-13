From: Koen Kooi <koen@dominion.thruhere.net>
Date: Wed, 13 Aug 2014 08:21:19 +0000
Subject: Re: [linux-sunxi] simplefb: add clock handling
Message-Id: <BFCF4C2C-77ED-4719-903B-921DEB250B7A@dominion.thruhere.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <CANq1E4Re79+D5H-pf8pW87NZ5MWz9UFknd5Dk2GKCvhzm5MNSA@mail.gmail.com>
In-Reply-To: <CANq1E4Re79+D5H-pf8pW87NZ5MWz9UFknd5Dk2GKCvhzm5MNSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Op 13 aug. 2014, om 09:54 heeft David Herrmann <dh.herrmann@gmail.com> het volgende geschreven:

> Hi
> 
> On Wed, Aug 13, 2014 at 9:17 AM, Luc Verhaegen <libv@skynet.be> wrote:
>> This is needed for the sunxi platform, where the u-boot initialized display
>> engine gets disabled by the clocks framework if certain clocks are not
>> claimed. Once these clocks are disabled, register content is lost, and there
>> is no turning back unless a full display driver is loaded, which kind of
>> beats the purpose of having simplefb running.
>> 
>> The lack of clock handling should plague more hardware, but so far rpi is the
>> best known user of simplefb, and its stepmotherly handling of the arm core
>> has kept these sort of issues from the kernel.
>> 
>> The sunxi u-boot side code can be found here:
>> https://groups.google.com/forum/#!topic/linux-sunxi/dPs958sIXvY
>> 
>> Patch 3 might be controversial, as this does not achieve anything real today,
>> since the status property in dt is only really evaluated when dealing with a
>> nodes memory. It still seems like a good idea to at least flag this memory or
>> node as disabled, as we really have no way back when the clocks get disabled.
> 
> Hans de Goede shortly told me about this and, tbh, I am not very
> pleased. Stephen tried to keep simplefd "as simple as possible", your
> patch now adds hardware-specific features. To be fair, the patch is
> simple and clocks are easy to handle, but I somehow fear we have to
> add more and more hardware-support that is required to keep the
> framebuffer active. This really defeats the purpose of simplefb.
> 
> The biggest question I have, is why do you add the clocks to your DT
> at all? The framebuffer is set up by your boot-loader (or maybe
> platform code) and should prepare the clocks. I don't see why we add
> the clocks to DT now. If they're not added, then no-one will disable
> them and simplefb works just fine, right?

All clocks known to linux without a consumer will get disabled on most (all?) ARM systems to save power. Years ago OMAP had a Kconfig option to change that behaviour and add printk warnings for the clocks it would touch. 
To be honest, I don't get why sunxi needs a simplefb to begin with, only a proper kms/drm driver is needed which would register the clocks it needs properly. These patches and discussion seem like a lot of effort wasted on the wrong thing. But I can't complain about that since I'm not the one doing the work. 

regards,

Koen