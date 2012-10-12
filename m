From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Fri, 12 Oct 2012 22:14:39 +0000
Subject: Re: [PATCH V5 1/2] video: exynos_dp: Add device tree support to DP driver
Message-Id: <5078964F.4000902@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1350074859-23226-1-git-send-email-ajaykumar.rs@samsung.com>
 <50788F25.2040003@gmail.com> <1909932.BXc5ALaqMM@flatron>
In-Reply-To: <1909932.BXc5ALaqMM@flatron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, thomas.ab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ajay Kumar <ajaykumar.rs-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

On 10/12/2012 11:54 PM, Tomasz Figa wrote:
>>> +	if (of_get_property(dp_node, "interlaced", NULL))
>>> +		dp_video_config->interlaced = 1;
>>
>> of_property_read_bool() could also be used here.
> 
> Wouldn't it make the property mandatory?

No, it wouldn't. of_property_read_bool() uses of_find_property() 
internally. It just returns true if property is found or false 
otherwise. Anyway, it appears of_get_property(..., NULL) pattern
is commonly used for boolean properties.

> I would just use of_find_property here, instead of of_get_property.
> 
> Best regards,
> Tomasz Figa

