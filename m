From: Alex Courbot <acourbot@nvidia.com>
Date: Wed, 03 Oct 2012 08:24:15 +0000
Subject: Re: [PATCH v6 0/4] Runtime Interpreted Power Sequences
Message-Id: <506BF62F.6040308@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347443867-18868-1-git-send-email-acourbot@nvidia.com>
 <4473898.CeAQBgUhKL@percival>
 <20120913071928.GA20959@opensource.wolfsonmicro.com>
 <1378218.yLeQheNFT0@percival>
 <20120913072943.GB20959@opensource.wolfsonmicro.com>
 <5051FAC5.40501@wwwdotorg.org>
In-Reply-To: <5051FAC5.40501-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Leela Krishna Amudala <l.krishna-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>

On 09/14/2012 12:24 AM, Stephen Warren wrote:
> On 09/13/2012 01:29 AM, Mark Brown wrote:
>> On Thu, Sep 13, 2012 at 04:26:34PM +0900, Alex Courbot wrote:
>>> On Thursday 13 September 2012 15:19:30 Mark Brown wrote:
>>>>> On Thursday 13 September 2012 14:25:53 Mark Brown wrote:
>>>>>> It would be sensible to make sure that the framework is done in such a
>>>>>> way that drivers can use it - there will be drivers (perhaps not display
>>>>>> ones) that have a known power sequence and which could benefit from the
>>>>>> ability to use library code to implement it based on the user simply
>>>>>> supplying named resources.
>>
>>>>> Not sure I understand what you mean, but things should be working this way
>>>>> already - regulators and PWMs are acquired by name using the standard
>>>>> regulator_get() and pwm_get() functions. GPIOs do not, AFAIK, have a way
>>>>> to be referenced by name so their number is used instead.
>>
>>>> Right, but the sequencing for enabling them is currently open coded in
>>>> each driver.
>>
>>> Mmm then I'm afraid I don't see what you wanted to say initially - could you
>>> elaborate?
>>
>> The driver knows the power sequence.  Having to type the same sequence
>> into the DT or platform data for each board using the device wouuld be
>> retarded so we need the drivers to be able to give the sequence to the
>> library if they're going to be able to reuse it (which is a lot of what
>> Tomi is talking about).
>
> I believe that's trivial to implement. The relevant function is:
>
> struct power_seq_set *devm_power_seq_set_build(struct device *dev,
> 		   struct platform_power_seq_set *pseq);
>
> It's up to the driver whether pseq comes from platform data or is
> hard-coded into the driver (or not provided at all, for the DT case).
> So, the only change needed to convert a "hard-coded" driver to this API
> is to convert the current custom data structure (or code) that describes
> the sequence into a struct platform_power_seq_set.

If we go this way (which looks good IMO!), then maybe we should abandon 
that "platform" denomination and merge platform_power_seq* structures 
with the currently private power_seq*, and also replace the "building" 
step with a resources acquisition one. Calling these structures 
"platform" implies they are for platform data while they can be used to 
perform more flexible things as Mark mentioned. Also making the resolved 
resource visible would allow drivers to "patch" generic sequences with 
the proper GPIO numbers at runtime. We would also avoid a few memory 
copies and both design and usage would be simplified, at the cost of 
having more things exposed. How does that sound?

Alex.

