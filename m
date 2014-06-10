From: Denis Carikli <denis@eukrea.com>
Date: Tue, 10 Jun 2014 13:29:33 +0000
Subject: Re: [PATCH v7][ 3/5] video: mx3fb: Introduce regulator support.
Message-Id: <5397083D.4090400@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394788369-5096-1-git-send-email-denis@eukrea.com>
 <1394788369-5096-3-git-send-email-denis@eukrea.com>
 <20140317062026.GZ17250@pengutronix.de>
In-Reply-To: <20140317062026.GZ17250@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 03/17/2014 07:20 AM, Sascha Hauer wrote:
> On Fri, Mar 14, 2014 at 10:12:47AM +0100, Denis Carikli wrote:
>>
>> +		of_property_read_string(display_np, "regulator-name",
>> +					&regulator_name);
>> +
>
> [...]
>
>> +	/* In dt mode,
>> +	 * using devm_regulator_get would require that the proprety referencing
>> +	 * the regulator phandle has to be inside the mx3fb node.
>> +	 */
>> +	if (np) {
>> +		if (regulator_name)
>> +			mx3fbi->reg_lcd = regulator_get(NULL, regulator_name);
>> +
>> +		if (IS_ERR(mx3fbi->reg_lcd))
>> +			return PTR_ERR(mx3fbi->reg_lcd);
>> +	} else {
>> +		/* Permit that driver without a regulator in non-dt mode */
>> +		mx3fbi->reg_lcd = regulator_get(dev, "lcd");
>> +	}
>
> This patch adds regulator support for the display of a i.MX3 IPU. The
> problem Denis has to solve here is that he needs to get the regulator,
> but the display devicenode doesn't have a struct device associated with
> it, so he cannot provide one to regulator_get(). One way out here could
> be a of_regulator_get(struct device_node *). Mark, would this be ok with
> you?

Here, the display devicenode has no struct device associated with it 
like mentioned above.
Because of that, retriving the regulator from the devicetree, for 
instance like regulator_dev_lookup() does, would require a different 
approach.

As I understand it, what happen in regulator_dev_lookup when 
regulator_get(NULL, regulator_name) is used is the following:

Since the struct device is NULL, it skips the struct device based 
lookup, but also the devicetree lookup (it uses dev->of_node for that)
At the end it falls back on a match on the regulator name to find it.

would keeping regulator_get(NULL, regulator_name); in the driver instead 
be better for now?

Denis.
