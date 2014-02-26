From: Denis Carikli <denis@eukrea.com>
Date: Wed, 26 Feb 2014 11:40:54 +0000
Subject: Re: [PATCHv6][ 3/5] video: mx3fb: Introduce regulator support.
Message-Id: <530DD2C6.1060108@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393408800-8946-1-git-send-email-denis@eukrea.com>
 <1393408800-8946-3-git-send-email-denis@eukrea.com>
 <1393410030.488354633@f216.i.mail.ru>
In-Reply-To: <1393410030.488354633@f216.i.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 02/26/2014 11:20 AM, Alexander Shiyan wrote:

 > Why you want to use an excess "regulator-name" property?
I'll fix that.

>> +	/* In dt mode,
>> +	 * using devm_regulator_get would require that the proprety referencing
>> +	 * the regulator phandle has to be inside the mx3fb node.
>
> What???
[...]
 > Just use devm_regulator_get(dev, "lcd") for both dt/non-dt case.

About the use of devm_regulator_get instead of regulator_get:

There is a "dma ipu driver" for the mx3* at drivers/dma/ipu/ipu_idmac.c
This framebuffer driver (mx3fb) uses that "dma ipu driver".

In non-dt mode("board files"), this framebuffer driver requires some 
platform data which has resource informations about the ipu.

So to get device tree bindings support for the mx3fb driver, at first I 
exported the "dma ipu driver" as DMA bindings, to be used in the dts, 
and then made the mx3fb driver use that.

The comment[1] to that patchset was to instead have similar bindings 
that looks like the IPUv3 ones(IPUv3 is a staging drm driver), and not 
to export the "dma ipu driver" bindings to the dts.

So I made the bindings look like that:

display0: display@di0 {
   [...]
   display-timings {
     [...]
   };
};

ipu: ipu@53fc0000 {
   compatible = "fsl,imx35-ipu";
   reg = <0x53fc0000 0x4000>;
   clocks = <&clks 55>;
   display = <&display0>;
};

So that is very similar to the imx-drm binding[2].

To achieve that, I've set the .compatible property of the mx3fb driver 
to "fsl,<chip>-ipu", so it would look like the IPUv3 bindings, and then 
I handled the "dma ipu driver" registration in a way that doesn't export 
it to the dts.

The difference is that the imx-drm driver has separate drivers for 
handling each display type(parallel display, tve, lvds and HDMI) while 
the mx3fb doesn't.

using devm_regulator_get(NULL, "lcd") would result in a crash, because 
of devres_add.

using devm_regulator_get(dev, "lcd") would be better but it would 
instead mean that the regulator handle will have to be a child of the 
mx3fb's ipu node (ipu@53fc0000).

That's because devm_regulator_get will end calling of_get_regulator 
(trough _regulator_get, and regulator_dev_lookup), which will in turn 
lookup that regulator in the childs of dev->of_node.

That's why I want to pass it a NULL instead of a device struct, and I 
can't do it in devm_regulator_get because of devres_add, so I ended up 
using regulator_get directly.

References.
-----------
[1]http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/205846.html
[2]Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt

Denis.
