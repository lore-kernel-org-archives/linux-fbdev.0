From: Ian Campbell <ijc@hellion.org.uk>
Date: Tue, 18 Nov 2014 08:47:18 +0000
Subject: Re: [PATCH 2/2] dt-bindings: simplefb-sunxi: Add sunxi simplefb extensions
Message-Id: <1416300438.25454.40.camel@hellion.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416224086-5698-1-git-send-email-hdegoede@redhat.com>
 <1416224086-5698-3-git-send-email-hdegoede@redhat.com>
 <20141117124721.GQ6414@lukather>
 <CACxGe6vqiC08sP+o3bduGfvUdwRtHm8+_7EdZccJjS86qVKvxQ@mail.gmail.com>
 <20141117155514.GU6414@lukather> <546B0026.2010107@redhat.com>
In-Reply-To: <546B0026.2010107@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 2014-11-18 at 09:15 +0100, Hans de Goede wrote:
> Hi,
> 
> On 11/17/2014 04:55 PM, Maxime Ripard wrote:
> > On Mon, Nov 17, 2014 at 01:39:18PM +0000, Grant Likely wrote:
> >> On Mon, Nov 17, 2014 at 12:47 PM, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >>> On Mon, Nov 17, 2014 at 12:34:46PM +0100, Hans de Goede wrote:
> >>>> If pre-filled framebuffer nodes are used, the firmware may need extra
> >>>> properties to find the right node. This documents the properties to use
> >>>> for this on sunxi platforms.
> >>>>
> >>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>>> ---
> >>>>  .../bindings/video/simple-framebuffer-sunxi.txt    | 33 ++++++++++++++++++++++
> >>>>  1 file changed, 33 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt b/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
> >>>> new file mode 100644
> >>>> index 0000000..84ca264
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
> >>>> @@ -0,0 +1,33 @@
> >>>> +Sunxi specific Simple Framebuffer bindings
> >>>> +
> >>>> +This binding documents sunxi specific extensions to the simple-framebuffer
> >>>> +bindings. The sunxi simplefb u-boot code relies on the devicetree containing
> >>>> +pre-populated simplefb nodes.
> >>>> +
> >>>> +These extensions are intended so that u-boot can select the right node based
> >>>> +on which pipeline and output is being used. As such they are solely intended
> >>>> +for firmware / bootloader use, and the OS should ignore them.
> >>>> +
> >>>> +Required properties:
> >>>> +- compatible: "sunxi,framebuffer"
> >>>> +- sunxi,pipeline:
> >>>> +  <0> for the de_be0 -> lcdc0 -> output pipeline
> >>>> +  <1> for the de_be1 -> lcdc1 -> output pipeline
> >>>> +- sunxi,output: One of: "hdmi", "lcd", "vga", and "composite"
> >>>> +
> >>>> +Example:
> >>>> +
> >>>> +chosen {
> >>>> +     #address-cells = <1>;
> >>>> +     #size-cells = <1>;
> >>>> +     ranges;
> >>>> +
> >>>> +     framebuffer@0 {
> >>>> +             compatible = "sunxi,framebuffer", "simple-framebuffer";
> >>>> +             sunxi,pipeline = <0>;
> >>>> +             sunxi,output = "hdmi";
> >>>> +             clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
> >>>> +                      <&ahb_gates 44>;
> >>>
> >>> If we're going that way, then maybe having to specify clock-names
> >>> would be better in order to know which clock is what?
> >>
> >> I wouldn't go that way with this binding since the driver has no need
> >> to differentiate between the clocks, and driver authors shouldn't be
> >> encouraged to do so. The purpose of the clocks in this node is only
> >> for itemizing dependencies, not for how to configure the clocks.
> >> Firmware shouldn't care at all about the clocks list, it only needs to
> >> find the correct pre-populated node to fill in and enable.
> > 
> > Well, if we want to play the "DT as an ABI" stuff, you have no
> > guarantee that in the future, simplefb will still be the driver bound
> > to "sunxi,framebuffer"
> 
> Huh? We do have that guarantee, or at least that a simplefb bindings
> compatible driver is, the "sunxi,framebuffer" bindings live in:
> 
> Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
> 
> With the filename already being a big hint, further more it states that:
> 
> "This binding documents sunxi specific extensions to the simple-framebuffer
> bindings. The sunxi simplefb u-boot code relies on the devicetree containing
> pre-populated simplefb nodes.
> 
> These extensions are intended so that u-boot can select the right node based
> on which pipeline is being used. As such they are solely intended for
> firmware / bootloader use, and the OS should ignore them."

There may be an argument here for using the slightly redundant compat
string "allwinner,simple-framebuffer" in order to reinforce that this is
an extension to simple-framebuffer, as opposed to a binding for a
completely separate "non-simple" sunxi framebuffer driver which I think
is what Maxime may be imagining.

Alternatively (or as well) perhaps these extension should be a series of
extensions (one per platform) described in "appendices" of the main
simple-framebuffer.txt. I know Grant expressed a preference for a
separate document though and I think just using the more expressive name
above would be sufficient, but thought I'd mention it as a possible
option.

Ian.

