From: Denis Carikli <denis@eukrea.com>
Date: Fri, 14 Mar 2014 11:23:22 +0000
Subject: Re: [PATCH v7][ 3/5] video: mx3fb: Introduce regulator support.
Message-Id: <5322E6AA.1010400@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394788369-5096-1-git-send-email-denis@eukrea.com>
 <1394788369-5096-3-git-send-email-denis@eukrea.com>
 <1394789035.649593084@f301.i.mail.ru>
In-Reply-To: <1394789035.649593084@f301.i.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 03/14/2014 10:23 AM, Alexander Shiyan wrote:
> Why this cannot be devm_regulator_get(dev, "lcd") in both DT and non-DT case?

I need to add device tree support to the mx3fb driver.
My first approach gave a binding that looked like that:

cmo_qvga: display {
   model = "CMO-QVGA";
   [...]
   display-timings {
     qvga_timings: 320x240 {
       hactive = <320>;
       vactive = <240>;
       [...]
    };
};

ipu: ipu@53fc0000 {
   compatible = "fsl,imx31-ipu";
   reg = < 0x53fc0000 0x5f
   0x53fc0088 0x2b >;
   interrupts = <42 41>;
   dma-channels = <32>;
   #dma-cells = <1>;
   clocks = <&clks 55>;
   clock-names = "";
};

lcdc: mx3fb@53fc00b4 {
   compatible = "fsl,mx3-fb";
   reg = <0x53fc00b4 0x0b>;
   clocks = <&clks 55>;
   dmas = <&ipu 14>;
   dma-names = "tx";
   display = <&cmo_qvga>;
};

The issue was that exporting the "dma ipu driver" was not a good idea.
I was told to instead make bindings that looks very similar to the ipuv3 
driver[1]
So at the end that gave something like that:

cmo_qvga: display@di0 {
   compatible = "fsl,mx3-parallel-display";
   regulator-name = "lcd";
   lcd-supply = <&reg_lcd_3v3>;
   model = "CMO-QVGA";
   display-timings {
     qvga_timings: 320x240 {
       hactive = <320>;
       vactive = <240>;
       [...]
    };
};

ipu: ipu@53fc0000 {
   compatible = "fsl,imx35-ipu";
   reg = <0x53fc0000 0x4000>;
   clocks = <&clks 55>;
   display = <&cmo_qvga>;
};

So here fsl,imx35-ipu is binded to the mx3fb driver.
But the mx3fb driver still need to use the dma-ipu driver somehow.
That's why the dma-ipu driver is handled behind the scenes, that way
it's not exported to the device tree bindings.

Now, since the mx3fb driver is binded to the "fsl,imx35-ipu" compatible,
if I would do a "mx3fbi->reg_lcd = devm_regulator_get(dev, "lcd");",
that would then lookup for the regulator in the mx3fb node
(The last "ipu@53fc0000" here).

Instead the regulator can be found in the display node,
which has no driver associated with it.

In the case of the ipuv3, the parallel display driver is associated
with the display@di0 node, so the device matches with the device tree
node directly.

References:
-----------
[1] The ipuv3 driver is in drivers/staging/imx-drm/
[2] the dma ipu driver is in drivers/dma/ipu/

Denis.

