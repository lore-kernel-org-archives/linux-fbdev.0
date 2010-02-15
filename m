From: "Phil Edworthy" <Phil.Edworthy@renesas.com>
Date: Mon, 15 Feb 2010 10:40:50 +0000
Subject: RE: [PATCH 00/02] sh: Panning fixes
Message-Id: <AB12B32E73474741A2C5361C433A44DE017AD437@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AB12B32E73474741A2C5361C433A44DE0178367D@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
In-Reply-To: <AB12B32E73474741A2C5361C433A44DE0178367D@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Magnus,

> On Mon, Feb 15, 2010 at 5:41 PM, Phil Edworthy
> <Phil.Edworthy@renesas.com> wrote:
> >> >> Thanks for your patches. Please make sure that the SYS panel case
> with
> >> >> deferred io is working. Migo-R is a good board to test this on.
> >> >
> >> > I thought the Migo-R doesn't have vsync connected to the SH, so maybe
> >> this
> >> > patch won't show any difference. Is that your understanding?
> >>
> >> Something like that, I think the QVGA LCD panel on Migo-R does not
> >> expose the VSYNC pin of the on-panel LCD controller so there is
> >> nothing to connect to the sh7722.
> > That's what I thought.
> 
> So there will be tearing on Migo-R regardless how smart our software is...
Yes, there is nothing we can do about that.

 
> >> It may be difficult to test your patch because of this, I'm not sure.
> >> My main concern was just to double check that you've thought about
> >> dealing with both the deferred io case and the "regular" non-deferred
> >> io case. The sh7724 KFR2R09 board is using deferred io and I think
> >> some upcoming boards may make use of that as well, so I'd prefer to
> >> keep that case working. =)
> >
> > How do you want to proceed then? I can't say that I am familiar with
> > deferred io and I don't have a board I can test it on... Is there anyone
> you
> > know who can try this?
> 
> ... but it should be possible to test on Migo-R even though the vsync
> pin is missing.
> 
> Usually people who submit patches do the testing to make sure other
> platforms won't break. I realize that it may be difficult for you if
> you don't have any platform to test on.
Ah, I misunderstood... I can test on MigoR but the output will tear
regardless. Is there anything I should look for on MigoR to see if deferred
io is working or not?

Thanks
Phil

