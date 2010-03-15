From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Mon, 15 Mar 2010 11:32:59 +0000
Subject: Re: [RFC][PATCH 3/3] OMAP: DSS2: Use vdds_sdi regulator supply in
Message-Id: <1268652779.2417.51.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1268407644-31230-1-git-send-email-roger.quadros@nokia.com>
	 <1268407644-31230-2-git-send-email-roger.quadros@nokia.com>
	 <1268407644-31230-3-git-send-email-roger.quadros@nokia.com>
	 <1268407644-31230-4-git-send-email-roger.quadros@nokia.com>
	 <1268646814.2417.39.camel@tubuntu.research.nokia.com>
	 <4B9E1973.50504@nokia.com>
In-Reply-To: <4B9E1973.50504@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Quadros Roger (Nokia-D/Helsinki)" <roger.quadros@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2010-03-15 at 12:26 +0100, Quadros Roger (Nokia-D/Helsinki)
wrote:
> Hi,
> 
> Valkeinen Tomi (Nokia-D/Helsinki) wrote:
> > On Fri, 2010-03-12 at 16:27 +0100, Quadros Roger (Nokia-D/Helsinki)
> > wrote:
> >> From: Roger Quadros <roger.quadros@nokia.com>
> >>
> >> This patch enables the use of vdds_sdi regulator in SDI subsystem.
> >> We can disable the vdds_sdi voltage when not in use to save
> >> power.
> >>
> >> Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
> >> ---
> >>  drivers/video/omap2/dss/sdi.c |   23 +++++++++++++++++++++--
> >>  1 files changed, 21 insertions(+), 2 deletions(-)
> >>

<snip>

> > And why do you test for omap34xx?
> > 
> I just assumed that, so i guess that was wrong. Will check the TRM and fix it.

Well, SDI is only for omap34xx. But why do you test it inside sdi.c, and
only for the regulator? I don't think SDI will work any better on
OMAP3630 (which doesn't have the SDI block), even if you don't use the
regulators ;).

So I think it's safe to assume inside sdi.c that we are running on a
device with SDI HW block.

 Tomi


