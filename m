From: Grant Likely <grant.likely@linaro.org>
Date: Wed, 19 Nov 2014 14:05:48 +0000
Subject: Re: [PATCH 2/2] dt-bindings: simplefb-sunxi: Add sunxi simplefb extensions
Message-Id: <CACxGe6tqRS=oCeqbrez86uLLXtQ_C4ETEesNqgxKGb38QOQ8SQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416224086-5698-1-git-send-email-hdegoede@redhat.com>
 <1416224086-5698-3-git-send-email-hdegoede@redhat.com>
 <20141117124721.GQ6414@lukather>
 <CACxGe6vqiC08sP+o3bduGfvUdwRtHm8+_7EdZccJjS86qVKvxQ@mail.gmail.com>
 <20141117155514.GU6414@lukather>
In-Reply-To: <20141117155514.GU6414@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 17, 2014 at 3:55 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, Nov 17, 2014 at 01:39:18PM +0000, Grant Likely wrote:
>> On Mon, Nov 17, 2014 at 12:47 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > On Mon, Nov 17, 2014 at 12:34:46PM +0100, Hans de Goede wrote:
>> >> If pre-filled framebuffer nodes are used, the firmware may need extra
>> >> properties to find the right node. This documents the properties to use
>> >> for this on sunxi platforms.
>> >>
>> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> >> ---
>> >>  .../bindings/video/simple-framebuffer-sunxi.txt    | 33 ++++++++++++++++++++++
>> >>  1 file changed, 33 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt b/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
>> >> new file mode 100644
>> >> index 0000000..84ca264
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
>> >> @@ -0,0 +1,33 @@
>> >> +Sunxi specific Simple Framebuffer bindings
>> >> +
>> >> +This binding documents sunxi specific extensions to the simple-framebuffer
>> >> +bindings. The sunxi simplefb u-boot code relies on the devicetree containing
>> >> +pre-populated simplefb nodes.
>> >> +
>> >> +These extensions are intended so that u-boot can select the right node based
>> >> +on which pipeline and output is being used. As such they are solely intended
>> >> +for firmware / bootloader use, and the OS should ignore them.
>> >> +
>> >> +Required properties:
>> >> +- compatible: "sunxi,framebuffer"
>> >> +- sunxi,pipeline:
>> >> +  <0> for the de_be0 -> lcdc0 -> output pipeline
>> >> +  <1> for the de_be1 -> lcdc1 -> output pipeline
>> >> +- sunxi,output: One of: "hdmi", "lcd", "vga", and "composite"
>> >> +
>> >> +Example:
>> >> +
>> >> +chosen {
>> >> +     #address-cells = <1>;
>> >> +     #size-cells = <1>;
>> >> +     ranges;
>> >> +
>> >> +     framebuffer@0 {
>> >> +             compatible = "sunxi,framebuffer", "simple-framebuffer";
>> >> +             sunxi,pipeline = <0>;
>> >> +             sunxi,output = "hdmi";
>> >> +             clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
>> >> +                      <&ahb_gates 44>;
>> >
>> > If we're going that way, then maybe having to specify clock-names
>> > would be better in order to know which clock is what?
>>
>> I wouldn't go that way with this binding since the driver has no need
>> to differentiate between the clocks, and driver authors shouldn't be
>> encouraged to do so. The purpose of the clocks in this node is only
>> for itemizing dependencies, not for how to configure the clocks.
>> Firmware shouldn't care at all about the clocks list, it only needs to
>> find the correct pre-populated node to fill in and enable.
>
> Well, if we want to play the "DT as an ABI" stuff, you have no
> guarantee that in the future, simplefb will still be the driver bound
> to "sunxi,framebuffer", and that this driver doesn't need to
> differentiate which clocks it needs to protect and which are not
> needed. Especially with the combination of the output that you now
> hardcode.

As long as the node claims compatibility with "simple-framebuffer",
then it must abide by the simple framebuffer rules. It cannot depend
on the driver having special knowledge about what to do with the
clocks. It is fine for a driver that understands "sunxi,framebuffer"
to enable additional features over and above simple-framebuffer,
providing it doesn't break the vanilla "simple-framebuffer" interface.

The simple-framebuffer binding is clear that it will treat the clocks
as dependencies only.

> Of course, if now we don't care at all about this ABI thing, it's
> completely fine for me. But I'll archive this email preciously.

I do not in any way mean to say it is okay to break ABI.

Also, my comments above are advice that I would give to U-Boot
authors, not something that should go in the binding. The
simple-framebuffer binding doesn't need to know about the clock names
at all, and if the assumption is that firmware will merely enable a
pre-populated framebuffer node in the tree, then it probably doesn't
need to parse the clocks property either. However, if it actually is
better for the U-Boot implementation to have clocks with names in the
node, then I'm not going to object.

g.
