From: "Phil Edworthy" <Phil.Edworthy@renesas.com>
Date: Mon, 15 Feb 2010 11:58:44 +0000
Subject: RE: [PATCH 00/02] sh: Panning fixes
Message-Id: <AB12B32E73474741A2C5361C433A44DE017AD528@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AB12B32E73474741A2C5361C433A44DE0178367D@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
In-Reply-To: <AB12B32E73474741A2C5361C433A44DE0178367D@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Magnus,

> >> Usually people who submit patches do the testing to make sure other
> >> platforms won't break. I realize that it may be difficult for you if
> >> you don't have any platform to test on.
> > Ah, I misunderstood... I can test on MigoR but the output will tear
> > regardless. Is there anything I should look for on MigoR to see if
> deferred
> > io is working or not?
> 
> Nothing special, just make sure that the console comes up as usual and
> that fsync is still working.

Done, all appears to work as it did before the patch.

I just need to address Paul's comments now.

Thanks
Phil

