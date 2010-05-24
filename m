From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Mon, 24 May 2010 07:26:03 +0000
Subject: Re: [RFC][RFT][PATCH] OMAPFB: LCDC: change update_mode to DISABLED
Message-Id: <1274685963.2265.3.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201005170320.29580.jkrzyszt@tis.icnet.pl>
	 <201005231409.44541.jkrzyszt@tis.icnet.pl>
In-Reply-To: <201005231409.44541.jkrzyszt@tis.icnet.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Sun, 2010-05-23 at 14:09 +0200, ext Janusz Krzysztofik wrote:
> Monday 17 May 2010 03:20:13 Janusz Krzysztofik wrote:
> > I was observing the following error messages on my OMAP1 based Amstrad
> > Delta board when first changing from text to graphics mode or vice versa
> > after the LCD display had been blanked:
> > 	omapfb omapfb: timeout waiting for FRAME DONE
> > with a followup error message while unblanking it back:
> > 	omapfb omapfb: resetting (status 0xffffffb2,reset count 1)
> > As a visible result, image pixels happened to be shifted by a few bits,
> > giving wrong colors.
> >
> > Examining the code, I found that this problem occures when an OMAP1
> > internal LCD controller is disabled from omap_lcdc_suspend() and then a
> > subsequent omap_lcdc_setup_plane() calls disable_controller() again. This
> > potentially error provoking behaviour is triggered by the lcdc.update_mode
> > flag being kept at OMAP_AUTO_UPDATE, regardless of the controller and panel
> > being suspended.
> >
> > This patch tries to correct the problem by replacing both
> > omap_lcdc_suspend() and omap_lcdc_resume() function bodies with single
> > calls to
> > omap_lcdc_set_update_mode() with a respective OMAP_UPDATE_DISABLE or
> > OMAP_AUTO_UPDATE argument. As a result, exactly the same lower level
> > operations are performed, with addition of changing the lcdc.update_mode
> > flag to a value better suited for the controller state. This prevents any
> > further calls to disable_controller() from omap_lcdc_setup_plane() while
> > the display is suspended.
> 
> Hi,
> 
> One more week of successfull, trouble-free testing on my side. Although there 
> were no other test reports, no objections nor change requests were raised as 
> well on this relatively simple and straightforward patch. Could we then agree 
> on it being accepted for inclusion? Tomi?

Yep, looks ok to me. Applied to DSS tree.

 Tomi


