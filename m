From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 30 Jan 2013 08:38:09 +0000
Subject: Re: [RFC 0/4] Use the Common Display Framework in tegra-drm
Message-Id: <20130130083809.GU1906@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359514939-15653-1-git-send-email-acourbot@nvidia.com>
 <20130130074020.GA17547@avionic-0098.mockup.avionic-design.de>
 <5108D865.3070301@nvidia.com>
In-Reply-To: <5108D865.3070301@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot@nvidia.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stephen Warren <swarren@wwwdotorg.org>, Mark Zhang <markz@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "gnurou@gmail.com" <gnurou@gmail.com>

On Wed, Jan 30, 2013 at 05:23:01PM +0900, Alex Courbot wrote:
> On 01/30/2013 04:40 PM, Thierry Reding wrote:
> >Thanks *a lot* for taking care of this Alexandre! From a quick look at
> >the patches they seem generally fine. I'll go over them in a bit more
> >detail though.
> 
> Glad you like it better than my previous attempts at controlling
> Tegra's panels and backlights. ;)
> 
> >>1) The CDF has a get_modes() hook, but this is already implemented by
> >>tegra_connector_get_modes(). Ideally everything should be moved to the CDF hook,
> >>but Tegra's implementation uses DRM functions to retrieve the EDID and CDF
> >>should, AFAIK, remain DRM-agnostic.
> >
> >Maybe a good option would be to just not implement get_modes() if the
> >same information can be retrieved via EDID. That is, the DRM driver
> >could just go and fetch EDID when the nvidia,ddc-i2c-bus is available
> >(or parse the nvidia,edid blob) and only rely on CDF otherwise.
> 
> Since EDID information is per-panel I'd intuitively say it should be
> provided by the panel driver.

Hm. If you know from the devicetree that you have a CLAA101WA01A then
you won't need EDID data at all. If instead you have EDID data you don't
have to put the information that this is a CLAA101WA01A into devicetree.

I think the next thing that will happen is that you want to use the EDID
data to 1) pick display timings 2) pick the right power sequence that
fits the panel found in EDID. You can't archieve 2) by hardcoding the
panel in the devicetree.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
