From: Nishad Kamdar <nishadkamdar@gmail.com>
Date: Wed, 16 Jan 2019 17:26:50 +0000
Subject: Re: [PATCH v2] Staging: fbtft: Switch to the gpio descriptor interface
Message-Id: <20190116171447.GA27175@nishad>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190115044704.GA20989@nishad>
 <20190115150231.GA3418@kroah.com>
In-Reply-To: <20190115150231.GA3418@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>, linux-fbdev@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>, Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Felix Siegel <felix.siegel@stud.uni-hannover.de>, Matthias Wolf <der_wolf_@web.de>, linux-kernel@vger.kernel.org, Mamta Shukla <mamtashukla555@gmail.com>, Radek =?utf-8?Q?Dost=C3=A1l?= <radek.dostal@streamunlimited.com>, Renato Soma <renatoys08@gmail.com>, dri-devel@lists.freedesktop.org, Tim Cofala <cofala@stud.uni-hannover.de>, Lee Jones <lee.jones@linaro.org>

On Tue, Jan 15, 2019 at 04:02:31PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 15, 2019 at 10:17:09AM +0530, Nishad Kamdar wrote:
> > This switches the fbtft driver to use GPIO descriptors
> > rather than numerical gpios:
> > 
> > Utilize the GPIO library's intrinsic handling of OF GPIOs
> > and polarity. If the line is flagged active low, gpiolib
> > will deal with this.
> > 
> > Remove gpios from platform device structure. Neither assign
> > statically numbers to gpios in platform device nor allow
> > gpios to be parsed as module parameters.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > Changes in v2:
> >  - Merge all patches in a single patch. This is because the
> >    first patch changes par->gpio from an int to a pointer
> >    so all the checks have to be updated in the same patch.
> >    Otherwie it breaks 'git bisect'.
> 
> The "v2" information goes below the --- line please.
> 
> Also, I got 2 copies of this, both different, so I have no idea which to
> apply.  Please fix up and resend a v3.
> 
Sorry for the confusion. I'll fix and resend.

> thanks,
> 
> greg k-h

Thanks for the review.

Regards,
Nishad
