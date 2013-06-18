From: "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>
Date: Tue, 18 Jun 2013 08:32:29 +0000
Subject: Re: [PATCH] video: mxsfb: fix color settings for 18bit data bus and 32bpp
Message-Id: <20130618083229.GC15037@lukather>
List-Id: <linux-fbdev.vger.kernel.org>
References: <519E03B0.1080006@digi.com> <519F4435.5010703@digi.com>
 <201305241300.25461.jbe@pengutronix.de>
 <201305241533.19941.jbe@pengutronix.de>
 <20130607072103.GF14209@lukather> <51B18BA0.50506@digi.com>
 <20130607074200.GG14209@lukather> <51B1957F.40104@digi.com>
 <20130607090228.GI14209@lukather>
In-Reply-To: <20130607090228.GI14209@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Hector,

On Fri, Jun 07, 2013 at 11:02:28AM +0200, maxime.ripard@free-electrons.com wrote:
> On Fri, Jun 07, 2013 at 10:10:39AM +0200, Hector Palacios wrote:
> > For a combination of 18bit LCD data bus width and a color
> > mode of 32bpp, the driver was setting the color mapping to
> > rgb666, which is wrong, as the color in memory realy has an
> > rgb888 layout.
> > 
> > This patch also removes the setting of flag CTRL_DF24 that
> > makes the driver dimiss the upper 2 bits when handling 32/24bpp
> > colors in a diplay with 18bit data bus width. This flag made
> > true color images display wrong in such configurations.
> > 
> > Finally, the color mapping rgb666 has also been removed as nobody
> > is using it and high level applications like Qt5 cannot work
> > with it either.
> > 
> > Reference: https://lkml.org/lkml/2013/5/23/220
> > Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> > Acked-by: Juergen Beisert <jbe@pengutronix.de>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Please also note that fbdev is now maintained by Jean Christophe
> Plagniol-Villard (plagnioj@jcrosoft.com, in CC), and that he is away
> until the 10th of June, so maybe it should be safe to resend it to him
> after this date.

It seems like Jean-Christophe is back online, maybe you should resend
him the patch now, it would be great to have it for 3.11.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
