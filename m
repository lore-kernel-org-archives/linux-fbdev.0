From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 21 Sep 2010 17:54:55 +0000
Subject: Re: [PATCH 2/2] viafb: Add OLPC XO-1.5 port configs
Message-Id: <4C98F16F.7080505@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921153726.21D609D401B@zog.reactivated.net>
In-Reply-To: <20100921153726.21D609D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

(cc'ed Jon)

Daniel Drake schrieb:
> On 21 September 2010 18:15, Florian Tobias Schandinat
> <FlorianSchandinat@gmx.de> wrote:
>> Why? What happens if this patch is not applied?
>> Please understand, that I, as a maintainer, try to avoid platform specific
>> code as much as possible so a little explanation would be good.
> 
> Without the patch, the GPIO/I2C lines are not set up correctly so
> we're unable to access the hardware connected there.

*after a deeper look at the patch*
Hm, one of my patches enables 0x26 also as I2C. So the only difference between 
the current config and your config is whether 0x2c is GPIO or I2C where your 
version make a lot more sense.
Jon, do you agree that this should become the default config?
Handling a GPIO device as such and not as an I2C device sounds right to me, 
although we have to take care about the old code which is doing so.


Thanks,

Florian Tobias Schandinat
