From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 11 Sep 2013 17:39:55 +0000
Subject: Re: [PATCH v2 1/2] video: ARM CLCD: Add DT support
Message-Id: <5230AAEB.2030607@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378808726-32535-1-git-send-email-pawel.moll@arm.com>
 <522F57B9.5000001@wwwdotorg.org> <1378899931.4082.75.camel@hornet>
In-Reply-To: <1378899931.4082.75.camel@hornet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 09/11/2013 05:45 AM, Pawel Moll wrote:
> On Tue, 2013-09-10 at 18:32 +0100, Stephen Warren wrote:
>>> +Optional properties:
>>> +
>>> +- video-ram: phandle to a node describing specialized video memory
>>> +		(that is *not* described in the top level "memory" node)
>>> +		that must be used as a framebuffer, eg. due to restrictions
>>> +		of the system interconnect; the node must contain a
>>> +		standard reg property describing the address and the size
>>> +		of the memory area
>>
>> Should this use the "CMA bindings" that are being proposed at the moment?
> 
> I expected this bit to be the hardest to get through :-)
> 
> The memory in question is *not* a part of "normal" RAM, therefore CMA
> doesn't even know about it. The situation I have to deal with is a
> system when CLCD's AHB master can *not* access the normal RAM, so the
> designers kindly ;-) provided some static RAM which it can address.
> 
>> Even if not, I'm not quite clear on what the referenced node is supposed
>> to contain; is just a reg property enough, so you'd see the following at
>> a completely arbitrary location in the DT:
>>
>> framebuffer-mem {
>>     reg = <0x80000000 0x00100000>;
>> };
> 
> The place wouldn't be random, no. Getting back to my scenario, the
> "video" RAM, being close to CLCD, is (obviously) also addressable by the
> core, as any other memory-mapped device. So its position is determined
> by the platform memory map:
> 
> \ {
> 	#address-cell = <2>;
> 	#size-cell = <2>;
> 	static-memory-bus {
> 		#address-cell = <2>;
> 		#size-cell = <1>;
> 		ranges = <2 0 0 0x18000000 64M>;
> 		motherboard {
> 			ranges; 
> 			video-ram {
> 				reg = <2 0 8MB>;
> 			};
> 		};
> 	};
> };
> 
> From the core's perspective it's just a bit of extra memory, you could,
> for example, put a MTD ram disk on it. It seems to deserve a
> representation in the tree then.

Yes, that's a good point. Perhaps it is reasonable to represent the
memory somewhere then.

I don't see why this memory couldn't exist in the regular /memory node;
it is after all (admittedly slow) RAM. Obviously you'd want to cover the
region with a /memreserve/ to avoid it being used just like any other
RAM. Perhaps the CLCD could reference the memreserve then?

Alternatively, if you want to represent the region as a regular node
rather than a /memory entry, I'd expect there to be a binding defining
what that node was, and the node to at least have a compatible value as
well. I'm not sure how you would indicate that the node should be MTD
vs. a resource for CLCD though; perhaps you'd use a different compatible
value depending on the intended use of the memory?

>> I'm not sure what the benefit of making this a standalone node is; why
>> not just put the base/size directly into the video-ram property in the
>> CLCD node?
> 
> This is certainly an option. I've considered this as well, but thought
> that the above made more sense.
> 
> Having said that, there is actually a use case, although a very
> non-probable one, for having a direct number there... The interconnect
> that CLCD is connected to could have different mapping than the
> processor's one. In other word, the memory seen by the core at X, could
> be accessed by the CLCD at Y. Or, in even more quirky situation, the
> core may not have access to the memory at all, with the graphics being
> generated only by GPU (or any other third party). Then the value would
> mean "the address you have to use when generating AMBA read transactions
> to be get some meaningful data" and would have to be known explicitly.
> 
> I guess it won't be hard to convince me it's a better option ;-)

That's true. Everything in DT is currently set up to describe the CPU's
memory map. Either we need to add some more properties to describe the
potentially different memory map for other bus masters, and/or we should
represent the various buses in DT, and any driver doing DMA should ask
each bus's driver in turn to translate the core-visible address to a bus
address so we can eventually end up with the address needed by the bus
masters.

That is indeed complex, and could at least in many situations simple be
short-circuited by putting the relevant base address in each other bus
master's own node/property. Hopefully we wouldn't get bitten by how
non-general that could be.

>>> +- max-framebuffer-size: maximum size in bytes of the framebuffer the
>>> +			system can handle, eg. in terms of available
>>> +			memory bandwidth
>>
>> Size doesn't imply bandwidth, due to the potential for varying bpp,
>> frame-rates, margin/porch sizes, etc. If this is a bandwidth limit,
>> shouldn't we instead represent that value directly, perhaps along with
>> some multiplier to convert theoretical bandwidth to practical bandwidth
>> (to account for memory protocol and controller overheads)?
> 
> It's a *memory interface* bandwidth, so synchronization fields are
> irrelevant here.

For average bandwidth, sure. However, the peak bandwidth is affected; if
your active region is 80% vs 95% of your line length, that's a
difference in the required region during the active period only. Of
course, your HW may start pre-fetching much earlier than the start of
the active region, so there are many variables.

> And the bpp limit is actually being calculated from
> this value, not the other way round. But I forgot about differing frame
> rates, that's fact. So it probably should be:
> 
> - max-memory-bandwidth: maximum bandwidth in bytes per second that the
> 			cell's memory interface can handle
> 
> and can be then used to calculate maximum bpp depending on the selected
> mode.

Yes, that's a better property definition.

> As to the multipliers... Although I hope that the SOC designer can
> provide theoretical throughput data, the only practical way of getting
> the value I was able to come up with was just trying different
> combinations till cross the line, so there isn't much math to be done
> further.

I don't know how constrained of a system CLCD is, but I do know that
mode validation is a very complex process in some real-life graphics
drivers. There are many complex calculations/modelling/heuristics
applied. I guess it would be very difficult to fully parametrize this
through DT; a real/complete solution is going to have to know enormous
detail of the memory system. So it's probably not worth pushing for DT
to represent the information required for this. I suppose in practice,
for a simple solution, the best idea is to revise max-memory-bandwidth
down (internally to the driver to maintain DT ABI I suppose) if any
problems are found in practice with the calculations.

>> ...
>>> +- panel-type: (required) must be "tft" or "stn", defines panel type
>> ...
>>> +- panel-stn-4bit: (for monochrome "stn" panel) if present means
>>> +			that the monochrome display is connected
>>> +			via 4 bit-wide interface
>>
>> I just wanted to confirm that those are a complete/direct representation
>> of all the HW options the module supports?
> 
> Yes. TFT or STN. There can be one or STN panels connected. STN(s) can be
> color or mono. Mono STN(s) can be driven via 4 or 8 bit wide interfaces.
> Disclaimer: I'm not trying to pretend an expert here. I'm just basing
> the above on the cell's spec.
> 
>>> +- display-timings: standard display timings sub-node, see
>>> +			Documentation/devicetree/bindings/video/display-timing.txt
>>
>> Should that be in a "Required sub-nodes" section (I assume required not
>> optional) rather than "Optional Properties"?
> 
> Right, the whole "panel" section is kept separately in a hope that CDF
> (or DRM or whatever ;-) generic display pipeline bindings will deprecate
> it. So the display-timings is required when optional panel properties
> are present. Maybe I should split them into a separate sub-node?
> Something along these lines (including the bandwidth example):

I would assume that TFT-vs-STN is a pretty direct representation of the
HW (IO bus to panel in particular), and hence wouldn't be replaced by
CDF? I would expect CDF to represent the more generic properties. But, I
haven't been following CDF too closely, so perhaps that's not true.

If you're expecting this binding to change if/when CDF appears, perhaps
it'd be better to wait for CDF, or plan for a new compatible property at
that time, or add some property indicating old-style configuration vs
new-style configuration once CDF is supported?

