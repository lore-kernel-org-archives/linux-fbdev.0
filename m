From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Fri, 28 Sep 2012 08:25:39 +0000
Subject: Re: [PATCH V3] video: exynos_dp: Add device tree support to DP driver
Message-Id: <50655F03.6000700@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348515385-22332-1-git-send-email-ajaykumar.rs@samsung.com>
 <50645848.6080102@gmail.com> <000601cd9d0d$c3296ca0$497c45e0$%han@samsung.com>
 <1511551.R6uMubmq1B@flatron>
In-Reply-To: <1511551.R6uMubmq1B@flatron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, 'Ajay Kumar' <ajaykumar.rs@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, FlorianSchandinat@gmx.de, thomas.ab@samsung.com, 'devicetree-discuss' <devicetree-discuss@lists.ozlabs.org>

On 09/28/2012 08:48 AM, Tomasz Figa wrote:
>>>> +	display-port-controller {
>>>> +		compatible = "samsung,exynos5-dp";
>>>> +		reg =<0x145B0000 0x10000>;
>>>> +		interrupts =<10 3>;
>>>> +		interrupt-parent =<&combiner>;
>>>> +		dp_phy =<&dptx_phy>;
>>>
>>> Shouldn't it be "samsung,dp_phy" ?
>>
>> Do you mean this ? It is not working.
>> +		dp_phy = "samsung,dp_phy";
> 
> I believe he meant:
> 
> -+		dp_phy =<&dptx_phy>;
> ++		samsung,dp_phy =<&dptx_phy>;
> 
> to mark that this is a Samsung-specific property.

Yes, that's what I meant. Sorry for imprecise wording.

Regards,
Sylwester
