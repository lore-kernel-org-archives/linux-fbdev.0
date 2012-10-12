From: Tomasz Figa <tomasz.figa@gmail.com>
Date: Fri, 12 Oct 2012 22:22:21 +0000
Subject: Re: [PATCH V5 1/2] video: exynos_dp: Add device tree support to DP driver
Message-Id: <1836310.KzLg5kfvv2@flatron>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1350074859-23226-1-git-send-email-ajaykumar.rs@samsung.com> <1909932.BXc5ALaqMM@flatron> <5078964F.4000902@gmail.com>
In-Reply-To: <5078964F.4000902@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc: Ajay Kumar <ajaykumar.rs@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, jg1.han@samsung.com, devicetree-discuss@lists.ozlabs.org, FlorianSchandinat@gmx.de, thomas.ab@samsung.com

On Saturday 13 of October 2012 00:14:39 Sylwester Nawrocki wrote:
> On 10/12/2012 11:54 PM, Tomasz Figa wrote:
> >>> +	if (of_get_property(dp_node, "interlaced", NULL))
> >>> +		dp_video_config->interlaced = 1;
> >> 
> >> of_property_read_bool() could also be used here.
> > 
> > Wouldn't it make the property mandatory?
> 
> No, it wouldn't. of_property_read_bool() uses of_find_property()
> internally. It just returns true if property is found or false
> otherwise.

Right, sorry. I thought that all of_property_read_* return error in case 
of missing property.

> Anyway, it appears of_get_property(..., NULL) pattern
> is commonly used for boolean properties.

I guess all three of them should be fine in this case, but since there is 
a dedicated function for bool, it might be the best solution here indeed.

Best regards,
Tomasz Figa

