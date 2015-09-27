From: Mike Rapoport <mike.rapoport@gmail.com>
Date: Sun, 27 Sep 2015 04:42:25 +0000
Subject: Re: [PATCH v2 1/3] staging: sm7xxfb: move sm712fb out of staging
Message-Id: <20150927044225.GA6466@zed.strato>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437192539-14150-1-git-send-email-sudipm.mukherjee@gmail.com>
 <55E5A7BC.8060003@ti.com>
 <20150901135514.GB15833@sudip-pc>
 <55E6E45B.5030500@ti.com>
 <20150902124811.GA25301@sudip-pc>
 <5603E567.5000001@ti.com>
 <20150925134206.GA4799@sudip-pc>
In-Reply-To: <20150925134206.GA4799@sudip-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Hi Sudip,

On Fri, Sep 25, 2015 at 07:12:06PM +0530, Sudip Mukherjee wrote:
> On Thu, Sep 24, 2015 at 02:58:31PM +0300, Tomi Valkeinen wrote:
> > 
> > On 02/09/15 15:48, Sudip Mukherjee wrote:
> > 
> <snip>
> > 
> > Is there a public datasheet for the HW?
> I could not find one in Silicon Motion website. I will try to find else
> I can talk to them and keep it in my github. And can send you also if
> you want.

I'd appreciate sm750 datasheet, if you have one.

> > 
> > The driver as it is now is quite horrible. Huge tables of raw data,
> > written directly to the registers. Lots of magic numbers all around.
> > Even with a datasheet, presuming it's public and it contains all those
> > values, the driver is rather unmaintainable.
> > 
> > All those need to be sorted out for the DRM driver anyway, so maybe it's
> > better to clean up the fb driver first.
> Ok. I never looked at them to see how they can be made better. I will
> see.
> 
> regards
> sudip

--
Sincerely yours,
Mike.
