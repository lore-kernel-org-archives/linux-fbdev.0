From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 01 Oct 2014 17:26:12 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <542C3934.3040409@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140929101805.GB26008@ulmo> <20140929114643.GB4081@lukather>
 <20140929134708.GB30998@ulmo> <20140929155517.GR16977@sirena.org.uk>
 <20140930050923.GB29874@ulmo> <20140930173928.GH4273@sirena.org.uk>
 <20141001074139.GB18463@ulmo>
 <CABxcv=nKErHGPRLM5yer2YnOc2VJPWLmeKgwXbXEU3r_XvsCyg@mail.gmail.com>
 <20141001123250.GY4273@sirena.org.uk> <20141001124800.GA21733@ulmo>
 <20141001170517.GF4273@sirena.org.uk>
In-Reply-To: <20141001170517.GF4273@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 10/01/2014 07:05 PM, Mark Brown wrote:
> On Wed, Oct 01, 2014 at 02:48:02PM +0200, Thierry Reding wrote:
>> On Wed, Oct 01, 2014 at 01:32:50PM +0100, Mark Brown wrote:
> 
>>> So don't do that if you're worried about it then, provide the bits of DT
>>> that hook everything up from the start or otherwise describe things as
>>> being in use.
> 
>> "Otherwise describe things as being in use" doesn't work for clocks for
>> example. And Mike already said he wasn't willing to add something like
>> an always-on DT property for clocks.
> 
> That's not the only way of doing things - another way would be to have a
> stub driver that just holds the resources while working on getting a
> full one in place for example.

That won't work because the real driver which will eventually replace the
stub one will likely be a module, and then we will loose video output
between the kernel finalizing the initial boot, and the module actually
loading.

We've been over all this again and again and again.

AAAARRRRRGGGGGGGGGGGGGGGGGHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH!

All solutions provided sofar are both tons more complicated, then the
simple solution of simply having the simplefb dt node declare which
clocks it needs. And to make things worse all of them sofar have
unresolved issues (due to their complexity mostly).

With the clocks in the simplefb node, then all a real driver has to do,
is claim those same clocks before unregistering the simplefb driver,
and everything will just work.

Yet we've been discussing this for months, all because of some
vague worries from Thierry, and *only* from Thierry that this will
make simplefb less generic / not abstract enough, while a simple
generic clocks property is about as generic as things come.

This madness has to end! Thierry can we please have a clear and
unambiguous NACK from you on having the clocks property in the simplefb
dt node, and if you do so I expect a proof of concept patch from you
with an alternative solution within a week, or can you please stop
blocking this from getting merged?

And again, if you believe this will cause some sort of dt compat
issues or whatever, no one is making you use this property for
your boards!

Regards,

Hans





