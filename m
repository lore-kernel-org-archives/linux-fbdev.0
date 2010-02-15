From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 15 Feb 2010 12:05:19 +0000
Subject: RE: [PATCH 00/02] sh: Panning fixes
Message-Id: <Pine.LNX.4.64.1002151304160.6277@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AB12B32E73474741A2C5361C433A44DE0178367D@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
In-Reply-To: <AB12B32E73474741A2C5361C433A44DE0178367D@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Phil

On Mon, 15 Feb 2010, Phil Edworthy wrote:

> Hi Magnus,
> 
> > >> Usually people who submit patches do the testing to make sure other
> > >> platforms won't break. I realize that it may be difficult for you if
> > >> you don't have any platform to test on.
> > > Ah, I misunderstood... I can test on MigoR but the output will tear
> > > regardless. Is there anything I should look for on MigoR to see if
> > deferred
> > > io is working or not?
> > 
> > Nothing special, just make sure that the console comes up as usual and
> > that fsync is still working.
> 
> Done, all appears to work as it did before the patch.

Have you also tested panning on Migo-R? I presume, its behaviour shouldn't 
change?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
