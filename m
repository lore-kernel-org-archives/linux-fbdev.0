From: Zhou Zhu <zzhu3@marvell.com>
Date: Tue, 11 Feb 2014 03:27:51 +0000
Subject: Re: [PATCH v2 4/4] video: mmp: add device tree support
Message-Id: <52F998B7.7060203@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389698184-28761-1-git-send-email-zzhu3@marvell.com> <1389698184-28761-5-git-send-email-zzhu3@marvell.com> <52F8C96F.7050107@ti.com>
In-Reply-To: <52F8C96F.7050107-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Guoqing Li <ligq-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

On 02/10/2014 08:43 PM, Tomi Valkeinen wrote:
> On 14/01/14 13:16, Zhou Zhu wrote:
>> add device tree support for mmp fb/controller
>> the description of DT config is at
>> Documentation/devicetree/bindings/fb/mmp-disp.txt
>>
>> Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
>> ---
>>   Documentation/devicetree/bindings/fb/mmp-disp.txt |   60 ++++++++
>>   drivers/video/mmp/fb/mmpfb.c                      |   73 ++++++----
>>   drivers/video/mmp/hw/mmp_ctrl.c                   |  160 ++++++++++++++++-----
>>   3 files changed, 235 insertions(+), 58 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/fb/mmp-disp.txt
>>
>> diff --git a/Documentation/devicetree/bindings/fb/mmp-disp.txt b/Documentation/devicetree/bindings/fb/mmp-disp.txt
>> new file mode 100644
>> index 0000000..80702f5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fb/mmp-disp.txt
>> @@ -0,0 +1,60 @@
>> +* Marvell MMP Display (MMP_DISP)
>> +
>> +To config mmp display, 3 parts are required to be set in dts:
>> +1. mmp fb
>> +Required properties:
>> +- compatible: Should be "marvell,<soc>-fb".
>> +- marvell,path: Should be the path this fb connecting to.
>> +- marvell,overlay-id: Should be the id of overlay this fb is on.
>> +- marvell,dmafetch-id: Should be the dma fetch id this fb using.
>> +- marvell,default-pixfmt: Should be the default pixel format when this fb is
>> +turned on.
>> +
>> +2. mmp controller
>> +Required properties:
>> +- compatible: Should be "marvell,<soc>-disp".
>> +- reg: Should be address and length of the register set for this controller.
>> +- interrupts: Should be interrupt of this controller.
>> +
>> +Required sub-node:
>> +- path:
>> +Required properties in this sub-node:
>> +-- marvell,overlay_num: Should be number of overlay this path has.
>
> If that one tells how many overlays there are, maybe "num_overlays"
> would be better.
I will update it in next version.
>
>> +-- marvell,output-type: Should be output-type settings
>> +-- marvell,path-config: Should be path-config settings
>> +-- marvell,link-config: Should be link-config settings
>> +-- marvell,rbswap: Should be rbswap settings
>
> If these terms (output-type, path-config, ...) are straight from the HW
> manual, then fine. But if they are not clear, or are driver specific,
> the values these can have should be documented here.
Yes, it's straight from HW manual.
>
>> +
>> +3. panel
>> +Required properties:
>> +- marvell,path: Should be path that this panel connected to.
>> +- other properties each panel has.
>> +
>> +Examples:
>> +
>> +fb: mmp-fb {
>> +	compatible = "marvell,pxa988-fb";
>> +	marvell,path = <&path1>;
>> +	marvell,overlay-id = <0>;
>> +	marvell,dmafetch-id = <1>;
>> +	marvell,default-pixfmt = <0x108>;
>> +};
>> +
>> +disp: mmp-disp@d420b000 {
>> +	compatible = "marvell,pxa988-disp";
>> +	reg = <0xd420b000 0x1fc>;
>> +	interrupts = <0 41 0x4>;
>> +	path1: mmp-pnpath {
>> +		marvell,overlay-num = <2>;
>> +		marvell,output-type = <0>;
>> +		marvell,path-config = <0x20000000>;
>> +		marvell,link-config = <0x60000001>;
>> +		marvell,rbswap = <0>;
>> +	};
>> +};
>> +
>> +panel: <panel-name> {
>
> How is the panel linked to all this? The nodes above do not refer to the
> panel.
We are making panel refer to path, so when panel dev probe, it could 
register to related path.
The reason we not link from path to panel is our customer sometimes 
asked us to use same image pack (include dts) for different panel types 
in product. We could only add all these panels in dts and detect panel 
dynamically when boot. So moving panel out and making path not link to 
panel but panel link to path would be more straight forward.
>
>> +	...
>> +	marvell,path = <&path1>;
>> +	...
>> +};
>
> It's a bit difficult to say much about this, as I have no knowledge
> about mmp.
>
> But I don't quite understand what the pxa988-fb is. Is that some kind of
> virtual device, only used to set up fbdev side? And pxa988-disp is the
> actual hardware device?
>
> If so, I don't really think pxa988-fb should exist in the DT data at
> all, as it's not a hardware device.
Yes, fb is a virtual device for fbdev side.
In our platforms we may use more than one fb for different paths/output 
panel or multi overlays on same path for composition. So we need to 
configure fb settings like which path/overlay/dmafetch it connected to 
for one or more fbdev.
Besides, some more configures like yres_virtual size or fixed fb mem 
reserved rather than allocated which depends on platforms are also 
needed although these features are not upstreamed yet.
So we put fb as a dt node here for these configures.
>
> Why isn't there just one node for pxa988-disp, which would contain all
> the above information?
We have moved out fb/panel from path due to several reasons:
1. To simplify the node. If moved these nodes in, it might be:
disp {
	...
	path1 {
		...
		panel-xxx {
		}
		panel-yyy {
		}
		...
		fb0 {
		}
		fb1 {
		}
	}
	path2 {
		...
		panel-zzz {
		}
		fb3 {
		}
	}
}
Also due to child node type might be different, we could even not 
directly check child of node. The code would be complex.
2. the path of node would be too long and not so common.
e.g. the panel node in dts would be /soc/axi/disp/path1/panel-xxx, and 
in sysfs, node would be /sys/devices/platform/soc/axi/path1/panel-xxx. 
It would be complex and not compatible for platforms when our 
bootloader/user app doing some operations to these nodes.
If we moved them out, we could move fb/panel out of soc directory so the 
node would be /panel-xxx or /fb1 and simpler and compatible.
>
>   Tomi
>
>


-- 
Thanks, -Zhou
