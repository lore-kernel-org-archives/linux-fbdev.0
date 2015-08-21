From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Fri, 21 Aug 2015 01:46:27 +0000
Subject: Re: [PATCH RESEND] video: fbdev: s3c-fb: Constify platform_device_id
Message-Id: <55D682F3.5090800@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436274047-3274-1-git-send-email-k.kozlowski.k@gmail.com>
 <254E99D1-79CE-4B90-B732-E5A4A1308DC4@gmail.com>
 <CAJKOXPc=k8r64_LuUGBaoOK87h07_zXUn_LoQ50KWfbk-1u69w@mail.gmail.com>
 <55D59AE2.7090201@ti.com>
In-Reply-To: <55D59AE2.7090201@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 20.08.2015 18:16, Tomi Valkeinen wrote:
> 
> 
> On 24/07/15 09:12, Krzysztof Kozlowski wrote:
>> 2015-07-08 13:34 GMT+09:00 Jingoo Han <jingoohan1@gmail.com>:
>>>
>>> On 2015. 7. 7., at PM 10:00, Krzysztof Kozlowski <k.kozlowski.k@gmail.com> wrote:
>>>>
>>>> The platform_device_id is not modified by the driver and core uses it as
>>>> const.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
>>>
>>> Acked-by: Jingoo Han <jingoohan1@gmail.com>
>>>
>>> Best regards,
>>> Jingoo Han
>>
>> Seems nobody is picking it up, so I merge it through Samsung-SoC tree.
>> If there are any objections please let me know.
> 
> I can pick this up if you didn't already do that.

Could you? It would be great.
Kukjin did not pick it up so it is still waiting for some attention. :)

Best regards,
Krzysztof

