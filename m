From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Wed, 11 Sep 2013 21:14:04 +0000
Subject: Re: [PATCH 1/2] video: ARM CLCD: Add DT support
Message-Id: <5230DD1C.6060606@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378488201-21146-1-git-send-email-pawel.moll@arm.com>
 <522BAED9.4020301@gmail.com> <1378725559.4082.28.camel@hornet>
 <522F91F8.6010207@gmail.com> <1378907036.4082.105.camel@hornet>
In-Reply-To: <1378907036.4082.105.camel@hornet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 09/11/2013 03:43 PM, Pawel Moll wrote:
> On Tue, 2013-09-10 at 22:41 +0100, Sylwester Nawrocki wrote:
>> On 09/09/2013 01:19 PM, Pawel Moll wrote:
>>> On Sat, 2013-09-07 at 23:55 +0100, Sylwester Nawrocki wrote:
[...]
>>>>> +- video-ram: phandle to a node describing specialized video memory
>>>>> +		(that is *not* described in the top level "memory" node)
>>>>> +                that must be used as a framebuffer, eg. due to restrictions
>>>>> +		of the system interconnect; the node must contain a
>>>>> +		standard reg property describing the address and the size
>>>>> +		of the memory area
>>>>
>>>> It seems the "specialized video memory" is described by some vendor specific
>>>> DT binding ? Is it documented ? It sounds like you are unnecessarily
>>>> repeating the memory node details here.
>>>
>>> I appreciate this property being the hardest to swallow, but the problem
>>> it is trying to solve is quite simple, really. System can be designed in
>>> such a way that CLCD is *not* able to read data from the main memory. In
>>> such case there will be a separate block of (usually static) memory
>>> "next" to CLCD, which *must* be used for the framebuffer. And I've got
>>> two choices here: to simply define an address and size, or to define a
>>> phandle to a node with standard reg property. I'll be really grateful
>>> for ideas how to describe the situation better.
>>
>> I thought about reusing the binding only, the part defining reserved
>> (carve out) memory regions.
>
> Em, what exactly do you mean? Referring to the definition of "reserved
> memory region" as an example how to use reg =<(address) (size)>?
> (because, I don't think it can be  "linux,contiguous-memory-region",
> "reserved-memory-region"). Can do, however I'm not sure if it won't
> cause even more confusion, as I hope that the CMA bindings will be
> useful here on their own, to allocate "normal" contiguous framebuffers.
> Keep in mind those two use cases are very very different.

Yes, I wasn't aware then that your "video RAM" is a separate chip attached
to a distinct bus.
My idea was to reuse memory node structure, including "reserved-memory"
compatible value (note there are some fixups pending and those names are
subject to change). Not sure about the property in CLCD device node
containing phandle to the memory node (currently 'memory-region').

>>>> Perhaps this binding/driver should use the common reserved memory bindings,
>>>> see thread http://www.spinics.net/lists/devicetree/msg02880.html
>>>
>>> No, not really - as I said, this is *not* the main RAM of the system.
>>> CMA doesn't even know about its existence.
>>
>> I'm really not an expert in this area, I'll assume we don't list such
>> separate memory chips in the 'memory' node.
>
> ePAPR spec, regarding the memory node, states: "The client program may
> access memory not covered by any memory reservations (see section 8.3)
> using any storage attributes it chooses." (note that the reservations
> mentioned are "the other" reservations, /memreserve/ ones ;-)
>
> Now, I wouldn't want my "client program" (read: Linux kernel) to use the
> "video memory" in question for general allocations, if only because of
> its rather poor performance (resulting from the interconnect design, not
> the memory chip characteristics), so I treat it more as a memory mapped
> device which happens to have a lot of word-long registers...
>
>> But if such memory could be used not only by this single IP block it would
>> probably make sense to have it listed in memory/reserved-memory, so it
>> could be used by other devices of which drivers possibly wouldn't have to
>> contain all the detailed dt parsing/memory handling code.
>
> The "video RAM" on my platform could be used for other purposes. If you
> don't mind latencies :-) It's just that the CLCD itself can't use
> anything else.

It seems then you just need to assign specific memory region to the device.
That's one of the main requirements the recent "CMA" memory bindings were
supposed to address.

> So, if the memory/reserved-memory described areas *not* to be used as
> "normal RAM", yes - we could use it. I don't think it's the case now,
> though.

AFAIU it's the case, you just need to have compatible property set to
"reserved-memory-region". Then the kernel will early call memblock_remove()
on that region, which will subsequently be declared for use by the device
DMA with a call to dma_declare_coherent_memory(), while populating devices
from DT [1]. It's likely I'm missing some details though, that would make
this unsuitable for your environment.

[1] http://www.spinics.net/lists/devicetree/msg02880.html

> Also, Steven mentioned the other option I talked about - just raw
> address/size pair. See me deliberation there...
>
>>>>> +- panel-dimensions: (optional) array of two numbers (width and height)
>>>>> +			describing physical dimension in mm of the panel
>>>>> +- panel-type: (required) must be "tft" or "stn", defines panel type
>>>>> +- panel-tft-interface: (for "tft" panel type) array of 3 numbers defining
>>>>> +			widths in bits of the R, G and B components
>>>>> +- panel-tft-rb-swapped: (for "tft" panel type) if present means that
>>>>> +			the R&    B components are swapped on the board
>>>>> +- panel-stn-color: (for "stn" panel type) if present means that
>>>>> +			the panel is a colour STN display, if missing
>>>>> +			is a monochrome display
>>>>> +- panel-stn-dual: (for "stn" panel type) if present means that there
>>>>> +			are two STN displays connected
>>>>> +- panel-stn-4bit: (for monochrome "stn" panel) if present means
>>>>> +			that the monochrome display is connected
>>>>> +			via 4 bit-wide interface
>>>>
>>>> Are this vendor specific or common properties ? Shouldn't those be prefixed
>>>> with the vendor name ?
>>>
>>> I have no answer to this question. My guts are telling me - nope. TFT is
>>> TFT, STN is STN, nothing to do with "arm,". But I welcome other
>>> opinions.
>>
>> I thought about documenting such a common properties in a common place.
>>    It's
>> not immediately clear from names of these properties that they apply to
>> PL110/
>> PL111 devices only.  If we let such generic names being redefined across DT
>> bindings of different devices it is going to be pretty messy IMHO.  Same
>> property in two different dts files would potentially have different
>> meaning.
>>
>> So perhaps instead of panel-dimensions we could define common
>> properties, e.g.
>>
>>    - display-phys-width: physical horizontal dimension of a display in
>> millimetres
>>                          (micrometres ?);
>>    - display-phys-height: physical vertical dimension of a display in
>> millimetres
>>                          (micrometres ?);
>>
>> Instead of 'panel-stn-color' a boolean property 'monochrome-display',
>> the default
>> when this property was missing would be "colour display".
>>
>> I'd like to leave defining such common properties to someone having more
>> experience
>> in the display area.  I don't think it would take much time come up with
>> generic
>> names for that couple properties you need.  Then CDF implementation
>> would simply use whatever gets agreed.
>
> Ok, I see what you're saying. Yes, this could be done. No, I don't claim
> to have enough expertise either (micrometers??? :-O ;-) The other thing
> is that I don't really expect generic CDF bindings to cover such things.
> They will (hopefully) only describe what's connected with what. And the
> drivers should know how. Of course they may need the dimensions&  alike
> in the tree (of course having them standardised would help here), but
> it's not a CDF job to provide those.

Of course it's always easier to define couple of DT properties that would
cover part of functionality of some specific device. But then such 
properties
should be prefixed with vendor name AFAIU, since they are not approved as
common ones and useful for wider set of devices.
 From the device tree perspective CDF is just a collection of (display
related) devices and a complete set of DT properties will be needed to
describe them. Certainly some share of device-specific properties should
be expected. Links between (sub)devices can be already described in DT by
the binding documented in video-interfaces.txt.

--
Thanks,
Sylwester
