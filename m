From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH] DSS2 Include VRFB into omap2-3build only
Date: Mon, 21 Jun 2010 11:38:26 +0300
Message-ID: <1277109506.2526.19.camel@tubuntu.research.nokia.com>
References: <1273474110-22451-1-git-send-email-svadivu@ti.com>
	 <1A2F53DA-903A-4667-A27F-492A3499F7ED@student.utwente.nl>
	 <FCCFB4CDC6E5564B9182F639FC356087030428879D@dbde02.ent.ti.com>
	 <73F3CED4-60D5-4351-A921-335110542B6F@dominion.thruhere.net>
	 <A24693684029E5489D1D202277BE894456043018@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <A24693684029E5489D1D202277BE894456043018@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: "ext Aguirre, Sergio" <saaguirre@ti.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "tony@atomide.com" <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Fri, 2010-06-18 at 18:57 +0200, ext Aguirre, Sergio wrote:
> Senthil,
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Koen Kooi
> > Sent: Monday, May 10, 2010 3:03 AM
> > To: Guruswamy, Senthilvadivu
> > Cc: linux-omap@vger.kernel.org; linux-fbdev-devel@lists.sourceforge.net;
> > tony@atomide.com; tomi.valkeinen@nokia.com; Hiremath, Vaibhav
> > Subject: Re: [PATCH] DSS2 Include VRFB into omap2-3build only
> > 
> > 
> > Op 10 mei 2010, om 10:01 heeft Guruswamy, Senthilvadivu het volgende
> > geschreven:
> > 
> > > Building a multi-omap kernel is not impacted as long as the display is
> > not choosen in the build.  Usually display is chosen from the board file.
> 
> Solving this problem involves doing these selections in run time, NOT in build time.
> 
> One of the solutions for this is to provide all this selections as part
> of some platform driver data.
> 
> It _should_ be possible to build DSS2, VRFB AND Tiler code at the same time
> for a multi-omap build, and be executed selectively, depending on your
> silicon detection and board code execution.
> 
> If you need to deselect it to succeed, then it's broken for multi-omap
> builds. That's the core problem and it hasn't been addressed until date.

I think the v3 patch set does it correctly. It allows VRFB to be built
only if ARCH_OMAP2 || ARCH_OMAP3, but does not turn VRFB off on
ARCH_OMAP4.

 Tomi


