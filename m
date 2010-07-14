From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 14 Jul 2010 19:35:13 +0000
Subject: Re: [PATCH] viafb: Add transitive dependencies via gpiolib
Message-Id: <4C3E1171.9060706@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279063845.6139.129.camel@localhost>
In-Reply-To: <1279063845.6139.129.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Ben Hutchings schrieb:
> On Wed, 2010-07-14 at 09:35 +1000, Dave Airlie wrote:
>> On Wed, Jul 14, 2010 at 9:30 AM, Ben Hutchings <ben@decadent.org.uk> wrote:
>>> FB_VIA now selects GPIOLIB, but that is not available on all
>>> architectures.  Change FB_VIA dependencies to include GPIOLIB
>>> dependencies.
>> If you can find a via chipset on anything not x86 I'd be impressed.
> 
> If it's really restricted to x86 then that should be added to its
> dependencies instead.

True.
The new VIA ARM tablets aside I don't know anything non-x86 from VIA.
And even if there exists anything non-x86 that includes these IGPs I 
really doubt that the driver is close to supporting it. Hell I do even 
wonder whether it works well on 64 bit but unless there are bug reports 
that's nothing I worry about.


Regards,

Florian Tobias Schandinat

