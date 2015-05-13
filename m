From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Wed, 13 May 2015 06:14:18 +0000
Subject: Re: [PATCH v3 2/3] Phy: DT binding documentation for Broadcom Cygnus USB PHY driver
Message-Id: <5552E8EA.9060003@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429744479-10410-1-git-send-email-arun.ramamurthy@broadcom.com> <1429744479-10410-3-git-send-email-arun.ramamurthy@broadcom.com> <5550B878.7060608@ti.com> <55527935.5060907@broadcom.com>
In-Reply-To: <55527935.5060907@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Gabriel FERNANDEZ <gabriel.fernandez@st.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com

Hi,

On Wednesday 13 May 2015 03:35 AM, Arun Ramamurthy wrote:
> Hi
>
> On 15-05-11 07:11 AM, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Thursday 23 April 2015 04:44 AM, Arun Ramamurthy wrote:
>>> Broadcom's Cygnus chip has a USB 2.0 host controller connected to
>>> three separate phys. One of the phs (port 2) is also connectd to
>>> a usb 2.0 device controller
>>>
>>> Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
>>> Reviewed-by: Ray Jui <rjui@broadcom.com>
>>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>>> ---
>>>    .../bindings/phy/brcm,cygnus-usb-phy.txt           | 69
>>> ++++++++++++++++++++++
>>>    include/dt-bindings/phy/phy.h                      |  2 +
>>>    2 files changed, 71 insertions(+)
>>>    create mode 100644
>>> Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
>>> b/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
>>> new file mode 100644
>>> index 0000000..ec62044
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
>>> @@ -0,0 +1,69 @@
>>> +BROADCOM CYGNUS USB PHY
>>> +
>>> +Required Properties:
>>> +    - compatible:  brcm,cygnus-usb-phy
>>> +    - reg : usbphy_regs - Base address of phy registers
>>> +            usb2h_idm_regs - Base address of host idm registers
>>> +            usb2d_idm_regs - Base address of device idm registers
>>> +    - phy-cells - must be 1 for each port declared. The node
>>> +              that uses the phy must provide either PHY_CONFIG_DEVICE
>>> for device
>>> +              or PHY_CONFIG_HOST for host
>>> +
>>> +NOTE: port 0 and port 1 are host only and port 2 can be configured
>>> for host or
>>> +device.
>>> +
>>> +Example of phy :
>>> +    usbphy0: usbphy@0x0301c000 {
>>> +        compatible = "brcm,cygnus-usb-phy";
>>> +        reg = <0x0301c000 0x2000>,
>>> +              <0x18115000 0x1000>,
>>> +              <0x18111000 0x1000>;
>>> +        status = "okay";
>>> +
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +        usbphy0_0: usbphy0@0 {
>>> +            #phy-cells = <1>;
>>> +            reg = <0>;
>>> +            status = "okay";
>>> +            phy-supply = <&vbus_p0>;
>>> +        };
>>> +
>>> +        usbphy0_1: usbphy0@1 {
>>> +            #phy-cells = <1>;
>>> +            reg = <1>;
>>> +            status = "okay";
>>> +        };
>>> +
>>> +        usbphy0_2: usbphy0@2 {
>>> +            #phy-cells = <1>;
>>> +            reg = <2>;
>>> +            status = "okay";
>>> +            phy-supply = <&vbus_p2>;
>>> +        };
>>> +    };
>>> +
>>> +Example of node using the phy:
>>> +
>>> +    /* This nodes declares all three ports as host */
>>> +
>>> +    ehci0: usb@0x18048000 {
>>> +        compatible = "generic-ehci";
>>> +        reg = <0x18048000 0x100>;
>>> +        interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>>> +        phys = <&usbphy0_0 PHY_CONFIG_HOST &usbphy0_1 PHY_CONFIG_HOST
>>> &usbphy0_2 PHY_CONFIG_HOST>;
>>> +        status = "okay";
>>> +    };
>>> +
>>> +    /*
>>> +     * This node declares port 2 phy
>>> +     * and configures it for device
>>> +     */
>>> +
>>> +    usbd_udc_dwc1: usbd_udc_dwc@0x1804c000 {
>>> +        compatible = "iproc-udc";
>>> +        reg = <0x1804c000 0x2000>;
>>> +        interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
>>> +        phys = <&usbphy0_2 PHY_CONFIG_DEVICE>;
>>> +        phy-names = "usb";
>>> +    };
>>> diff --git a/include/dt-bindings/phy/phy.h
>>> b/include/dt-bindings/phy/phy.h
>>> index 6c90193..3f6b1ac 100644
>>> --- a/include/dt-bindings/phy/phy.h
>>> +++ b/include/dt-bindings/phy/phy.h
>>> @@ -15,5 +15,7 @@
>>>    #define PHY_TYPE_PCIE        2
>>>    #define PHY_TYPE_USB2        3
>>>    #define PHY_TYPE_USB3        4
>>> +#define PHY_CONFIG_HOST        1
>>> +#define PHY_CONFIG_DEVICE    0
>>
>> '0' and '1' are already defined for "PHY_NONE" and "PHY_TYPE_SATA". Is
>> this for USB2 or for USB3?
>>
> This is for USB2, do you want me to prefix the defines with USB2?

yes. That will avoid confusion when someone tries to add USB3 HOST PHY or USB3 
DEVICE PHY.
> I think It would be misleading to use PHY_TYPE_SATA or PHY_NONE in this
> scenario

I meant to use the next available values like 5 and 6.

Thanks
Kishon
