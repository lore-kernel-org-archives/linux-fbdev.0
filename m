From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 11 Nov 2010 16:01:00 +0000
Subject: Re: [PATCH 2/2] viafb: Add OLPC XO-1.5 port configs
Message-Id: <4CDC133C.4060706@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921153726.21D609D401B@zog.reactivated.net>
In-Reply-To: <20100921153726.21D609D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

Daniel Drake schrieb:
> On 29 October 2010 15:03, Daniel Drake <dsd@laptop.org> wrote:
>> I now realise that all the #ifdefs are unnecessary, the code should be
>> there unconditionally and the compiler will remove it on non-OLPC
>> kernels.
>>
>> The other option we have is to detect the XO-1.5 using DMI. That's the
>> more conventional way of detecting a specific platform in the kernel.
>> Florian, what do you think?
> 
> Bump
> 
> Florian, still hoping for your input on this, and a review of the S/R
> infrastructure patches posted recently.

sorry for the delay, but I'm very busy at the moment.
I already pushed those patches forward to my -next branch and it should be in 
the linux-next branch of today.
I'm still not happy with how GPIO or more precisely I2C on GPIO ports is 
handled. But given that I don't have much time at the moment and that there are 
more important things in viafb that require work and most important that I don't 
see any opportunity/hardware to test whether the current (or an alternative) 
implementation allows I2C devices work on port 2C pushing this patch forward 
seems reasonable. I only removed the #ifdefs as you suggested in your last email 
to make the code more readable.
The other two patches were good.


Thanks,

Florian Tobias Schandinat

