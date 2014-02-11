From: Zhou Zhu <zzhu3@marvell.com>
Date: Tue, 11 Feb 2014 01:03:21 +0000
Subject: Re: [PATCH v2 3/4] video: mmp: add devm_mmp_get_path_by_phandle for DT
Message-Id: <52F976D9.4050504@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389698184-28761-1-git-send-email-zzhu3@marvell.com> <1389698184-28761-4-git-send-email-zzhu3@marvell.com> <52F8C6F6.5000200@ti.com>
In-Reply-To: <52F8C6F6.5000200-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Guoqing Li <ligq-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

On 02/10/2014 08:32 PM, Tomi Valkeinen wrote:
> On 14/01/14 13:16, Zhou Zhu wrote:
>> add devm_mmp_get_path_by_phandle to replace mmp_get_path
>> for DT usage
>>
>> Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
>> ---
>>   drivers/video/mmp/core.c |   35 +++++++++++++++++++++++++++++++++++
>>   include/video/mmp_disp.h |    2 ++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/drivers/video/mmp/core.c b/drivers/video/mmp/core.c
>> index b563b92..0538458 100644
>> --- a/drivers/video/mmp/core.c
>> +++ b/drivers/video/mmp/core.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/export.h>
>> +#include <linux/of.h>
>>   #include <video/mmp_disp.h>
>>
>>   static struct mmp_overlay *path_get_overlay(struct mmp_path *path,
>> @@ -156,6 +157,40 @@ struct mmp_path *mmp_get_path(const char *name)
>>   EXPORT_SYMBOL_GPL(mmp_get_path);
>>
>>   /*
>> + * devm_mmp_get_path_by_phandle - get path by phandle
>> + * @dev: device that want to get path
>> + * @phandle: name of phandle in device node that want to get path
>> + *
>> + * this function gets path according to node pointed by phandle
>> + * return NULL if no matching path
>> + */
>> +struct mmp_path *devm_mmp_get_path_by_phandle(struct device *dev,
>> +	const char *phandle)
>> +{
>> +	struct mmp_path *path;
>> +	struct device_node *node;
>> +
>> +	if (!dev->of_node) {
>> +		dev_err(dev, "device does not have a device node entry\n");
>> +		return NULL;
>> +	}
>> +
>> +	node = of_parse_phandle(dev->of_node, phandle, 0);
>> +	if (!node) {
>> +		dev_err(dev, "failed to get %s phandle in %s node\n", phandle,
>> +			dev->of_node->name);
>> +		return NULL;
>> +	}
>> +
>> +	path = mmp_get_path(node->name);
>> +
>> +	of_node_put(node);
>> +
>> +	return path;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_mmp_get_path_by_phandle);
>
> Why is this function "devm_"? devm_ functions are supposed to
> automatically free resources when the device is removed, I don't see
> anything like that here.

Thank you for your review, I will remove "devm_" in next version.

>
>   Tomi
>
>


-- 
Thanks, -Zhou
