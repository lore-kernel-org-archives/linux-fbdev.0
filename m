From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Date: Tue, 25 May 2010 17:31:56 +0000
Subject: Re: [RFC][RFT][PATCH] OMAPFB: LCDC: change update_mode to DISABLED when going suspend
Message-Id: <201005251931.58157.jkrzyszt@tis.icnet.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201005170320.29580.jkrzyszt@tis.icnet.pl> <201005231409.44541.jkrzyszt@tis.icnet.pl> <1274685963.2265.3.camel@tubuntu.research.nokia.com>
In-Reply-To: <1274685963.2265.3.camel@tubuntu.research.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Monday 24 May 2010 09:26:03 Tomi Valkeinen napisa=C5=82(a):
> Hi,
>
> On Sun, 2010-05-23 at 14:09 +0200, ext Janusz Krzysztofik wrote:
> > Monday 17 May 2010 03:20:13 Janusz Krzysztofik wrote:
> > > I was observing the following error messages on my OMAP1 based Amstrad
> > > Delta board when first changing from text to graphics mode or vice
> > > versa after the LCD display had been blanked:
> > > 	omapfb omapfb: timeout waiting for FRAME DONE
> > > with a followup error message while unblanking it back:
> > > 	omapfb omapfb: resetting (status 0xffffffb2,reset count 1)
> > > As a visible result, image pixels happened to be shifted by a few bit=
s,
> > > giving wrong colors.
> > >
> > > Examining the code, I found that this problem occures when an OMAP1
> > > internal LCD controller is disabled from omap_lcdc_suspend() and then=
 a
> > > subsequent omap_lcdc_setup_plane() calls disable_controller() again.
> > > This potentially error provoking behaviour is triggered by the
> > > lcdc.update_mode flag being kept at OMAP_AUTO_UPDATE, regardless of t=
he
> > > controller and panel being suspended.
> > >
> > > This patch tries to correct the problem by replacing both
> > > omap_lcdc_suspend() and omap_lcdc_resume() function bodies with single
> > > calls to
> > > omap_lcdc_set_update_mode() with a respective OMAP_UPDATE_DISABLE or
> > > OMAP_AUTO_UPDATE argument. As a result, exactly the same lower level
> > > operations are performed, with addition of changing the
> > > lcdc.update_mode flag to a value better suited for the controller
> > > state. This prevents any further calls to disable_controller() from
> > > omap_lcdc_setup_plane() while the display is suspended.
> >
> > Hi,
> >
> > One more week of successfull, trouble-free testing on my side. Although
> > there were no other test reports, no objections nor change requests were
> > raised as well on this relatively simple and straightforward patch. Cou=
ld
> > we then agree on it being accepted for inclusion? Tomi?
>
> Yep, looks ok to me. Applied to DSS tree.

Tomi,
Thanks, you were so fast that I missed asking you if it could still be push=
ed=20
as a fix in the upcoming 2.6.35-rc cycle.

Thanks,
Janusz
