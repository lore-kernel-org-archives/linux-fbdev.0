From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 15 Nov 2012 08:58:35 +0000
Subject: Re: [PATCH] backlight: Add of_find_backlight_by_node() function
Message-Id: <001201cdc30f$65a17be0$30e473a0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352469878-4532-1-git-send-email-thierry.reding@avionic-design.de>
 <004201cdc2d0$c1920210$44b60630$%han@samsung.com>
 <20121115065140.GA21208@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20121115065140.GA21208@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Thierry Reding' <thierry.reding@avionic-design.de>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, 'Richard Purdie' <rpurdie@rpsys.net>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org

On Thursday, November 15, 2012 3:52 PM Thierry Reding wrote
> On Thu, Nov 15, 2012 at 10:30:11AM +0900, Jingoo Han wrote:
> > On Friday, November 09, 2012 11:05 PM Thierry Reding wrote
> > >
> > > This function finds the struct backlight_device for a given device tree
> > > node. A dummy function is provided so that it safely compiles out if OF
> > > support is disabled.
> > >
> > > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> >
> > CC'ed Andrew Morton
> 
> Yes, the backlight subsystem isn't very well maintained, so I should
> have added Andrew in the first place. Thanks.
> 
> >
> > Hi Thierry Reding,
> >
> > The patch itself looks good.
> > Could you explain when this API is used?
> > Thank you.
> 
> I use this for the upcoming Tegra DRM driver in order to hook up the
> backlight with the DRM driver via DT to allow switching off the
> backlight when the corresponding DRM output is switched of using DPMS.
> Basically what you have is something like this in the device tree:
> 
> 	display {
> 		...
> 
> 		backlight = <&backlight>;
> 
> 		...
> 	}
> 
> Then you call something along these lines:
> 
> 	np = of_parse_phandle(display, "backlight", 0);
> 	if (np) {
> 		backlight = of_find_backlight_by_node(np);
> 		of_node_put(np);
> 	}
> 
> And then use the standard backlight API on the returned pointer.

OK, I see how this API can be called.
AS you mentioned, it will allow Tegra DRM driver to use
the backlight driver.

Acked-by: Jingoo Han <jg1.han@samsung.com>


Best regards,
Jingoo Han

> 
> Thierry

