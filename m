From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 17 Nov 2014 13:07:23 +0000
Subject: Re: [PATCH 2/2] dt-bindings: simplefb-sunxi: Add sunxi simplefb extensions
Message-Id: <5469F30B.7080507@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416224086-5698-1-git-send-email-hdegoede@redhat.com>
 <1416224086-5698-3-git-send-email-hdegoede@redhat.com>
 <20141117124721.GQ6414@lukather>
In-Reply-To: <20141117124721.GQ6414@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 11/17/2014 01:47 PM, Maxime Ripard wrote:
> On Mon, Nov 17, 2014 at 12:34:46PM +0100, Hans de Goede wrote:
>> If pre-filled framebuffer nodes are used, the firmware may need extra
>> properties to find the right node. This documents the properties to use
>> for this on sunxi platforms.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  .../bindings/video/simple-framebuffer-sunxi.txt    | 33 ++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt b/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
>> new file mode 100644
>> index 0000000..84ca264
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
>> @@ -0,0 +1,33 @@
>> +Sunxi specific Simple Framebuffer bindings
>> +
>> +This binding documents sunxi specific extensions to the simple-framebuffer
>> +bindings. The sunxi simplefb u-boot code relies on the devicetree containing
>> +pre-populated simplefb nodes.
>> +
>> +These extensions are intended so that u-boot can select the right node based
>> +on which pipeline and output is being used. As such they are solely intended
>> +for firmware / bootloader use, and the OS should ignore them.
>> +
>> +Required properties:
>> +- compatible: "sunxi,framebuffer"
>> +- sunxi,pipeline:
>> +  <0> for the de_be0 -> lcdc0 -> output pipeline
>> +  <1> for the de_be1 -> lcdc1 -> output pipeline
>> +- sunxi,output: One of: "hdmi", "lcd", "vga", and "composite"  
>> +
>> +Example:
>> +
>> +chosen {
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	ranges;
>> +
>> +	framebuffer@0 {
>> +		compatible = "sunxi,framebuffer", "simple-framebuffer";
>> +		sunxi,pipeline = <0>;
>> +		sunxi,output = "hdmi";
>> +		clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
>> +			 <&ahb_gates 44>;
> 
> If we're going that way, then maybe having to specify clock-names
> would be better in order to know which clock is what?

I agree that using clock-names is more human readable then phandle's,
but that is simply not how clocks are specified anywhere in dt.

Regards,

Hans


