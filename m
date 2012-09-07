From: Tony Lindgren <tony@atomide.com>
Date: Fri, 07 Sep 2012 16:22:58 +0000
Subject: Re: [PATCH 0/8] OMAPDSS: Misc improvements
Message-Id: <20120907162258.GT1303@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
 <1346743368.2586.1.camel@deskari>
 <20120906201330.GF1303@atomide.com>
 <1347012960.2646.5.camel@deskari>
In-Reply-To: <1347012960.2646.5.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120907 03:16]:
> On Thu, 2012-09-06 at 13:13 -0700, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [120904 00:23]:
> > > Hi Tony,
> > > 
> > > Can you check the arch/arm patches below, and suggest how you'd like to
> > > go forward with them?
> > 
> > Acked them, then as soon as we have the initial immutable header
> > move branch available, you should merge with that to avoid
> > merge conflicts in upstream.
> 
> Thanks, but you missed the first patch "[PATCH 1/8] OMAPDSS: HDMI: Move
> GPIO handling to HDMI driver".

Oops sorry, that's a nice one, acked that too. BTW, do you have any
platform code callbacks remaining for DSS?

Regards,

Tony
