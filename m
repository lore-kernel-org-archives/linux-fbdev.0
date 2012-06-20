From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 20 Jun 2012 00:54:49 +0000
Subject: Re: [PATCH] video: exynos_dp: fix build warning due to uninitialized value
Message-Id: <000001cd4e7f$4b9a29e0$e2ce7da0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <001501cd4de5$d955a290$8c00e7b0$%han@samsung.com>
 <4FE11D60.9040109@gmx.de>
In-Reply-To: <4FE11D60.9040109@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Olof Johansson' <olof@lixom.net>, 'Jingoo Han' <jg1.han@samsung.com>


On Wed, June 20, 2012 at 9:46 AM, Florian Tobias Schandinat wrote:

> Hi Jingoo,
> 
> On 06/19/2012 06:36 AM, Jingoo Han wrote:
> > This patch fixes build warning due to uninitialized value dereference.
> > @@ -407,6 +407,8 @@ static unsigned int exynos_dp_get_lane_link_training(
> >  	case 3:
> >  		reg = exynos_dp_get_lane3_link_training(dp);
> >  		break;
> > +	default:
> > +		return -EINVAL;
> 
> Why do you consider returning -EINVAL here a good idea? As far as I can
> see the caller does not check the return value for an error condition
> and I doubt that the hardware understands what -EINVAL means. If you
> want to fix the warning, make sure that you don't hide actual errors,
> add an WARN or BUG or make sure the error code makes it to userspace.
> 

OK, I will fix it and send the v2 patch.
Thank you.

Best regards,
Jingoo Han


