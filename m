From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 25 Nov 2014 12:52:02 +0000
Subject: Re: [PATCH v3 2/2] dt-bindings: simplefb-sunxi: Add sunxi simplefb extensions
Message-Id: <54747B72.1050406@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416309051-26784-1-git-send-email-hdegoede@redhat.com>
 <1416309051-26784-3-git-send-email-hdegoede@redhat.com>
 <547476DA.2030004@ti.com>
In-Reply-To: <547476DA.2030004@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 11/25/2014 01:32 PM, Tomi Valkeinen wrote:
> On 18/11/14 13:10, Hans de Goede wrote:
>> If pre-filled framebuffer nodes are used, the firmware may need extra
>> properties to find the right node. This documents the properties to use
>> for this on sunxi platforms.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Acked-by: Grant Likely <grant.likely@linaro.org>
>> ---
>>   .../bindings/video/simple-framebuffer-sunxi.txt    | 33 ++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt b/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
>> new file mode 100644
>> index 0000000..c46ba64
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
>> +on which pipeline is being used. As such they are solely intended for
>> +firmware / bootloader use, and the OS should ignore them.
>> +
>> +Required properties:
>> +- compatible: "allwinner,simple-framebuffer"
>> +- allwinner,pipeline, one of:
>
> Sorry my ignorance, but what's sunxi and what's allwinner? Both names
> are mixed here.

sunxi is the sun#i SoCs from Allwinner, Allwinner is the manufacturer and the
SoC "code" names used everywhere in the kernel for their SoCs are sun4i, sun5i,
sun6i, etc. Most people refer to these SoCs as sunxi. This is also what the
linux-sunxi mailinglist in the Cc is about.

The official devicetree vendor prefix for Allwinner is allwinner, hence the
allwinner in the compatible name, see e.g. also

Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt

Which also uses sunxi / sun4i everywhere except in the compatible vendor prefix.

Regards,

Hans
