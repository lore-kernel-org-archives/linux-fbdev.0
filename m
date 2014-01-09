From: Zhou Zhu <zzhu3@marvell.com>
Date: Thu, 09 Jan 2014 12:09:09 +0000
Subject: Re: [PATCH] video: mmp: add device tree support
Message-Id: <52CE9165.7050002@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389244394-10779-1-git-send-email-zzhu3@marvell.com> <20140109073158.GM6750@pengutronix.de> <000301cf0d0e$91f29090$b5d7b1b0$%han@samsung.com>
In-Reply-To: <000301cf0d0e$91f29090$b5d7b1b0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Sascha Hauer' <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Tomi Valkeinen' <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, 'Jean-Christophe Plagniol-Villard' <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, 'Haojian Zhuang' <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Guoqing Li <ligq-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Sascha/Jingoo,
Thank you for your review!

On 01/09/2014 03:43 PM, Jingoo Han wrote:
> On Thursday, January 09, 2014 4:32 PM, Sascha Hauer wrote:
>> On Thu, Jan 09, 2014 at 01:13:14PM +0800, Zhou Zhu wrote:
>>> add device tree support for mmp fb/controller
>>> the description at Documentation/devicetree/bindings/fb/mmp-disp.txt
>>>
>>> Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
>>> ---
>>>   Documentation/devicetree/bindings/fb/mmp-disp.txt |   71 ++++++++++++
>>>   drivers/video/mmp/fb/mmpfb.c                      |   71 ++++++++----
>>>   drivers/video/mmp/hw/mmp_ctrl.c                   |  120 ++++++++++++++++-----
>>>   3 files changed, 217 insertions(+), 45 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/fb/mmp-disp.txt
>>>

[...]

>> +fb: fb {
>> +	compatible = "marvell,mmp-fb";
>
> This compatible should have the specific SoC name in it, not just
> 'mmp'. Otherwise you can't properly distinguish between this version and
> future versions of the mmp core.
>
We are using a same display IP for all mmp serial SoCs, and there would 
be inside register to get version. So I am planning put same compatible 
here for all SoCs using this IP.
Would it be ok if I update compatible to "marvell,mmpdcx-fb"? "mmpdcx" 
is the IP name.

 >
 >> +	marvell,fb-name = "mmp_fb";
 >> +	marvell,path-name = "mmp_pnpath";
 >
 > You're not going to use this string to reference to another node, do
 > you? We have phandles for this.
 >
I will update it in v2.

 >> +	marvell,overlay-id = <0>;
 >> +	marvell,dmafetch-id = <1>;
 >> +	marvell,default-pixfmt = <0x108>;
 >> +};
 >> +
 >> +disp: disp@d420b000 {
 >> +	compatible = "marvell,mmp-disp";
 >> +	reg = <0xd420b000 0x1fc>;
 >> +	interrupts = <0 41 0x4>;
 >> +	marvell,disp-name = "mmp_disp";
 >> +	marvell,path-num = <1>;
 >> +	marvell,clk-name = "LCDCIHCLK";
 >
 > Don't pass clk names like this. We have a documented clock binding, use
 > it.
 >
The patches to add dt support in common clk in our platforms are not 
upstreamed yet. As there's only one clock in this device, could I remove 
clock name related codes and direct use: devm_clk_get(dev, NULL)?

>
>>
>>> +#ifdef CONFIG_OF
>>> +	struct device_node *np;
>>> +#else
>>>   	struct mmp_buffer_driver_mach_info *mi;
>>> +#endif
>>>   	struct fb_info *info = 0;
>>>   	struct mmpfb_info *fbi = 0;
>>> -	int ret, modes_num;
>>> -
>>> -	mi = pdev->dev.platform_data;
>>> -	if (mi = NULL) {
>>> -		dev_err(&pdev->dev, "no platform data defined\n");
>>> -		return -EINVAL;
>>> -	}
>>> +	int ret = -EINVAL, modes_num;
>>> +	int overlay_id, dmafetch_id;
>>> +	const char *path_name;
>>>
>>>   	/* initialize fb */
>>>   	info = framebuffer_alloc(sizeof(struct mmpfb_info), &pdev->dev);
>>>   	if (info = NULL)
>>>   		return -ENOMEM;
>>>   	fbi = info->par;
>>> -	if (!fbi) {
>>> -		ret = -EINVAL;
>>> +	if (!fbi)
>>> +		goto failed;
>>> +
>>> +#ifdef CONFIG_OF
>>
>> Just because your kernel build does have CONFIG_OF enabled doesn't mean
>> it's actually started with a devicetree. You need to make a runtime
>> decision, not compile time.
>
> Yes, right.
> As Sascha Hauer said, you need to make a runtime decision,
> instead of compile time. Please keep the same binary for
> both cases (CONFIG_OF is 'enabled' and 'disabled').
>
> For example,
>
> 	if (pdev->dev.of_node) {
> 		// DT code
> 	} else {
> 		// Non-DT code
> 	}
>
Thank you for your suggestion. I will update the code to dynamic in v2.

-- 
Thanks, -Zhou
