From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 29 Feb 2012 01:42:35 +0000
Subject: RE: [GIT PULL] OMAP DSS fixes for 3.3-rc
Message-Id: <005a01ccf683$6964e3b0$3c2eab10$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1329988974.1820.62.camel@deskari> <4F4CFAD1.1000301@gmx.de>
 <1330445287.2123.236.camel@deskari>
In-Reply-To: <1330445287.2123.236.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, 'linux-omap mailing list' <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-owner@vger.kernel.org] On Behalf Of Tomi
> Valkeinen
> Sent: Wednesday, February 29, 2012 1:08 AM
> To: Florian Tobias Schandinat
> Cc: linux-fbdev@vger.kernel.org; linux-omap mailing list
> Subject: Re: [GIT PULL] OMAP DSS fixes for 3.3-rc
> 
> On Tue, 2012-02-28 at 16:03 +0000, Florian Tobias Schandinat wrote:
> > On 02/23/2012 09:22 AM, Tomi Valkeinen wrote:
> > > Hi Florian,
> > >
> > > Two fixes for OMAP DSS for 3.3:
> > >
> > > First one gets the HDMI output working again. Managing the clocks for
> > > OMAP4 is not very simple, and this patch circumvents the problems we
> > > have in the clock framework. It's a clean but rather hacky fix, but it
> > > shouldn't cause any side-effects. The issue will hopefully be fixed
> > > properly with DT when we'll get proper parent-child hierarchy for DSS HW
> > > submodules.
> > >
> > > The second one is a simple fix for HDMI hotplug detection, which I
> > > missed when I wrote the HDMI PHY fix
> > > (c49d005b6cc8491fad5b24f82805be2d6bcbd3dd).
> >
> > Merged. You would add
> > Cc: stable@vger.kernel.org
> > to patches if appropriate?
> 
> Thanks. Yes, I have sent a separate mail to stable list, as the patches
> needed some tuning to apply.

Tomi, sorry.
You have already sent a mail to stable@vger.kernel.org.
Good luck.

Best regards,
Jingoo Han
> 
>  Tomi

