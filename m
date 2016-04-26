From: Tony Lindgren <tony@atomide.com>
Date: Tue, 26 Apr 2016 16:42:41 +0000
Subject: Re: [PATCH] omapfb: Fix regulator API abuse in dss.c and hdmi4.c
Message-Id: <20160426164241.GY5995@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459355376-28507-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1459355376-28507-1-git-send-email-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [160426 09:38]:
> On 26/04/16 19:22, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [160331 10:31]:
> >> Tero, Tony, with a quick look, for example omap5-board-common.dtsi
> >> defines ldo4_reg having range from 1.5 to 1.8. That should be changed to
> >> 1.8 only, right? ldo1_reg has a range too, I'm not familiar with that
> >> LDO's use, but it's for camera so my guess is that it should be 1.8 too.
> >>
> >> I can have a more thorough look tomorrow, and do a test run on omap5
> >> uevm (with Mark's patch).
> > 
> > Any news on this fix?
> 
> I sent the DT changes to you some time ago:
> 
> http://www.spinics.net/lists/linux-omap/msg127893.html
> http://www.spinics.net/lists/linux-omap/msg127894.html

OK thanks yeah I have those tagged as fixes.

> We can get rid of the dss code after those are in.

OK so I'll apply the fixes and forget about this thread :)

Thanks,

Tony
