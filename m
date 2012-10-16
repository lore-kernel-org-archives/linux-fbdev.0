From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Tue, 16 Oct 2012 11:07:01 +0000
Subject: Re: [PATCH V5 1/2] video: exynos_dp: Add device tree support to DP driver
Message-Id: <507D3FD5.6060309@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1350074859-23226-1-git-send-email-ajaykumar.rs@samsung.com>
 <50788F25.2040003@gmail.com> <009d01cdaaad$0fa33230$2ee99690$%han@samsung.com>
 <507C7C9E.1030503@gmail.com> <005a01cdab42$5a8ca390$0fa5eab0$%han@samsung.com>
In-Reply-To: <005a01cdab42$5a8ca390$0fa5eab0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Sylwester Nawrocki' <sylvester.nawrocki@gmail.com>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, 'Ajay Kumar' <ajaykumar.rs@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, 'Tomasz Figa' <t.figa@samsung.com>, 'Thomas Abraham' <thomas.ab@samsung.com>

On 10/16/2012 04:02 AM, Jingoo Han wrote:
> On Tuesday, October 16, 2012 6:14 AM Sylwester Nawrocki wrote
>> On 10/15/2012 10:14 AM, Jingoo Han wrote:
>>> On Saturday, October 13, 2012 6:44 AM Sylwester Nawrocki wrote
>>>>
>>>> On 10/12/2012 10:47 PM, Ajay Kumar wrote:
>>>>> This patch enables device tree based discovery support for DP driver.
>>>>> The driver is modified to handle platform data in both the cases:
>>>>> with DT and non-DT.
>>>>>
>>>>> Signed-off-by: Ajay Kumar<ajaykumar.rs@samsung.com>
>>>>> Acked-by: Jingoo Han<jg1.han@samsung.com>
>>>>> ---
>>>>>    drivers/video/exynos/exynos_dp_core.c |  161 ++++++++++++++++++++++++++++++---
>>>>>    drivers/video/exynos/exynos_dp_core.h |    2 +
>>>>>    2 files changed, 149 insertions(+), 14 deletions(-)
>> ...
>>>>> @@ -953,8 +1062,13 @@ static int __devexit exynos_dp_remove(struct platform_device *pdev)
>>>>>    	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
>>>>>    	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
>>>>
>>>> This doesn't belong to your patch, but the above 2 lines could be written as:
>>>>
>>>>    	struct exynos_dp_device *dp = dev_get_drvdata(&pdev->dev);
>>>>
>>>> Same in functions exynos_dp_suspend() and exynos_dp_resume().
>>>
>>> No, above 2 lines cannot be reduced to 1 line, as you mentioned.
>>> This is because it makes build error.
>>
>> Sorry, my bad. It looks fine in case of exynos_dp_remove().
>>
>> But at exynos_dp_suspend/resume() there is something like:
>>
>>
>> static int exynos_dp_suspend(struct device *dev)
>> {
>> 	struct platform_device *pdev = to_platform_device(dev);
>> 	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
>> 	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
>>
>>
>> You need only pdata and dp there. I think that simpler form would
>> do as well:
>>
>> 	struct exynos_dp_device *dp = dev_get_drvdata(dev);
>> 	struct exynos_dp_platdata *pdata = dev->platform_data;
> 
> OK, I see.
> I will accept your suggestion, because it is helpful to reduce
> lines. Then, I will send v8 patch, soon.

OK. I thought about it more as a candidate for a separate. But you seem
to have already sent new version, it's probably fine this way too.

--
Regards,
Sylwester
