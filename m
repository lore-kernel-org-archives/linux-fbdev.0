From: Stephen Warren <swarren@wwwdotorg.org>
Date: Tue, 17 Sep 2013 21:38:49 +0000
Subject: Re: [PATCH v3 1/2] video: ARM CLCD: Add DT support
Message-Id: <5238CBE9.2060800@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379351934-25415-1-git-send-email-pawel.moll@arm.com>
 <52376180.1090001@wwwdotorg.org> <1379435799.9205.16.camel@hornet>
In-Reply-To: <1379435799.9205.16.camel@hornet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 09/17/2013 10:36 AM, Pawel Moll wrote:
> On Mon, 2013-09-16 at 20:52 +0100, Stephen Warren wrote:
>> I think the binding should either always use names as the key, or use
>> indices in interrupts as the key. Hence, I'd word that more like:

>> Do we really need so many examples?
> 
> They cover all standard cases. If I was to write a tree for a new
> platform not knowing anything about CLCD, I think I'd appreciate this
> and don't believe this extra kB or two is a problem. Do you?

I guess it's not a problem. It's just unusual.

>>> +Optional properties:
>>> +
>>> +- arm,pl11x,framebuffer-base: a pair of two values, address and size,
>>> +				defining the framebuffer to be used;
>>> +				to be used only if it is *not*
>>> +				part of normal memory, as described
>>> +				in /memory node
>>
>> If the framebuffer is part of /memory, what happens then? Is the address
>> not fixed (so the HW isn't yet set up) and hence a driver should
>> allocate it?
> 
> Yes, if it wants to display anything :-) And as this is a normal and
> expected behaviour, I don't think it deserves a note in the
> documentation. I'm open to any suggestions that would make the wording
> above emphasize the "weirdness" of situations requiring the property.

Perhaps:

A pair of two values, address and size, defining the framebuffer to be
used. If not present, the framebuffer may be located anywhere in memory.

Or, is this intended to represent where the HW is already scanning out
from? If so, then perhaps:

A pair of two values, address and size, defining the location of the
framebuffer that the controller is currently configured to display. If
not present, the controller may or may not already be active.

(although presumably if the controller is already active, then the
address can simply be read out of the HW register, so there's no need
for a DT property).
