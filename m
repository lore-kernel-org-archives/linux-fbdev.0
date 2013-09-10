From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Tue, 10 Sep 2013 21:41:12 +0000
Subject: Re: [PATCH 1/2] video: ARM CLCD: Add DT support
Message-Id: <522F91F8.6010207@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378488201-21146-1-git-send-email-pawel.moll@arm.com>
 <522BAED9.4020301@gmail.com> <1378725559.4082.28.camel@hornet>
In-Reply-To: <1378725559.4082.28.camel@hornet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 09/09/2013 01:19 PM, Pawel Moll wrote:
> On Sat, 2013-09-07 at 23:55 +0100, Sylwester Nawrocki wrote:
>> H --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/video/arm,pl11x.txt
>>> @@ -0,0 +1,87 @@
>>> +* ARM PrimeCell Color LCD Controller (CLCD) PL110/PL111
>>
>> nit: Shouldn't the abbreviation be CLCDC ?
>
> The commonly used acronym for this cell is CLCD. For what its worth, I
> can make the line read:
>
> ARM PrimeCell Color LCD (CLCD) Controller PL110/PL111

OK, that's probably better. A meaningless detail, I've just seen mostly
CLCDC used in the PL100/PL111 TRM and LCDC would presumably be more 
intuitive
for this type of IP block.

>>> +- video-ram: phandle to a node describing specialized video memory
>>> +		(that is *not* described in the top level "memory" node)
>>> +                that must be used as a framebuffer, eg. due to restrictions
>>> +		of the system interconnect; the node must contain a
>>> +		standard reg property describing the address and the size
>>> +		of the memory area
>>
>> It seems the "specialized video memory" is described by some vendor specific
>> DT binding ? Is it documented ? It sounds like you are unnecessarily
>> repeating the memory node details here.
>
> I appreciate this property being the hardest to swallow, but the problem
> it is trying to solve is quite simple, really. System can be designed in
> such a way that CLCD is *not* able to read data from the main memory. In
> such case there will be a separate block of (usually static) memory
> "next" to CLCD, which *must* be used for the framebuffer. And I've got
> two choices here: to simply define an address and size, or to define a
> phandle to a node with standard reg property. I'll be really grateful
> for ideas how to describe the situation better.

I though about reusing the binding only, the part defining reserved
(carve out) memory regions.

>> Perhaps this binding/driver should use the common reserved memory bindings,
>> see thread http://www.spinics.net/lists/devicetree/msg02880.html
>
> No, not really - as I said, this is *not* the main RAM of the system.
> CMA doesn't even know about its existence.

I'm really not an expert in this area, I'll assume we don't list such
separate memory chips in the 'memory' node.

But if such memory could be used not only by this single IP block it would
probably make sense to have it listed in memory/reserved-memory, so it 
could
be used by other devices of which drivers possibly wouldn't have to contain
all the detailed dt parsing/memory handling code.

>>> +- max-framebuffer-size: maximum size in bytes of the framebuffer the
>>> +			system can handle, eg. in terms of available
>>> +			memory bandwidth
>>> +
>>> +In the simplest case of a display panel being connected directly to the
>>> +CLCD, it can be described in the node:
>>> +
>>> +- panel-dimensions: (optional) array of two numbers (width and height)
>>> +			describing physical dimension in mm of the panel
>>> +- panel-type: (required) must be "tft" or "stn", defines panel type
>>> +- panel-tft-interface: (for "tft" panel type) array of 3 numbers defining
>>> +			widths in bits of the R, G and B components
>>> +- panel-tft-rb-swapped: (for "tft" panel type) if present means that
>>> +			the R&   B components are swapped on the board
>>> +- panel-stn-color: (for "stn" panel type) if present means that
>>> +			the panel is a colour STN display, if missing
>>> +			is a monochrome display
>>> +- panel-stn-dual: (for "stn" panel type) if present means that there
>>> +			are two STN displays connected
>>> +- panel-stn-4bit: (for monochrome "stn" panel) if present means
>>> +			that the monochrome display is connected
>>> +			via 4 bit-wide interface
>>
>> Are this vendor specific or common properties ? Shouldn't those be prefixed
>> with the vendor name ?
>
> I have no answer to this question. My guts are telling me - nope. TFT is
> TFT, STN is STN, nothing to do with "arm,". But I welcome other
> opinions.

I thought about documenting such a common properties in a common place. 
  It's
not immediately clear from names of these properties that they apply to 
PL110/
PL111 devices only.  If we let such generic names being redefined across DT
bindings of different devices it is going to be pretty messy IMHO.  Same
property in two different dts files would potentially have different 
meaning.

So perhaps instead of panel-dimensions we could define common 
properties, e.g.

  - display-phys-width: physical horizontal dimension of a display in 
millimetres
                        (micrometres ?);
  - display-phys-height: physical vertical dimension of a display in 
millimetres
                        (micrometres ?);

Instead of 'panel-stn-color' a boolean property 'monochrome-display', 
the default
when this property was missing would be "colour display".

I'd like to leave defining such common properties to someone having more 
experience
in the display area.  I don't think it would take much time come up with 
generic
names for that couple properties you need.  Then CDF implementation 
would simply
use whatever gets agreed.

>> Anyway I think we need an RFC to possibly standardize properties that are
>> common across multiple panels and have them listed in a common DT binding.
>>
>> It sounds a bit disappointing that for same class devices there are being
>> introduced custom DT properties for each available device. For instance,
>> the first 3 properties above look like they could apply to various display
>> panels and controllers.
>
> No argument from here. The Common Display Framework was supposed to
> address this issue. And the first version of this patch used it:
>
> http://thread.gmane.org/gmane.linux.drivers.video-input-infrastructure/63417
>
> But you'll notice that it's been almost 10 months since the last version
> of CDF saw the daylight, and Laurent seems to be too busy with other
> duties to carry on with this. Additionally the KMS/DRM guys don't look
> too kindly on it. The bottom line is: there are 3 different platform
> suffering from lack of DT bindings for CLCD and I've got fed up with
> waiting. Anyway, I've intentionally kept the panel properties in a
> separate section and wrote "can be described", to keep an open way for
> future "display bindings", if and when they appear.

I might risk people start yelling at me, but perhaps you could explicitly
mark this binding as "preliminary", so it is clear that the intention was
to switch to whatever common design in future.

The recently posted v3 of the CDF uses DT bindings specified at:
  Documentation/devicetree/bindings/media/video-interfaces.txt,
  Documentation/devicetree/bindings/video/display-timing.txt.

Theoretically, the bindings are independent of any OS implementation, thus
I guess if you used the above bindings, perhaps extended with couple more
properties, it might have been possible to switch to any common OS API in
future, without changing the bindings. That all might be highly theoretical
though. :)

--
Thanks,
Sylwester
