From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 15 Jan 2019 15:02:31 +0000
Subject: Re: [PATCH v2] Staging: fbtft: Switch to the gpio descriptor interface
Message-Id: <20190115150231.GA3418@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190115044704.GA20989@nishad>
In-Reply-To: <20190115044704.GA20989@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nishad Kamdar <nishadkamdar@gmail.com>
Cc: devel@driverdev.osuosl.org, Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>, linux-fbdev@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Felix Siegel <felix.siegel@stud.uni-hannover.de>, YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org, Mamta Shukla <mamtashukla555@gmail.com>, Matthias Wolf <der_wolf_@web.de>, Renato Soma <renatoys08@gmail.com>, dri-devel@lists.freedesktop.org, Tim Cofala <cofala@stud.uni-hannover.de>, Radek =?iso-8859-1?Q?Dost=E1l?= <radek.dostal@streamunlimited.com>, Lee Jones <lee.jones@linaro.org>

On Tue, Jan 15, 2019 at 10:17:09AM +0530, Nishad Kamdar wrote:
> This switches the fbtft driver to use GPIO descriptors
> rather than numerical gpios:
> 
> Utilize the GPIO library's intrinsic handling of OF GPIOs
> and polarity. If the line is flagged active low, gpiolib
> will deal with this.
> 
> Remove gpios from platform device structure. Neither assign
> statically numbers to gpios in platform device nor allow
> gpios to be parsed as module parameters.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> Changes in v2:
>  - Merge all patches in a single patch. This is because the
>    first patch changes par->gpio from an int to a pointer
>    so all the checks have to be updated in the same patch.
>    Otherwie it breaks 'git bisect'.

The "v2" information goes below the --- line please.

Also, I got 2 copies of this, both different, so I have no idea which to
apply.  Please fix up and resend a v3.

thanks,

greg k-h
