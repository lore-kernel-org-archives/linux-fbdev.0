From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 20 Jun 2012 08:31:18 +0000
Subject: Re: [PULL for v3.6] SH Mobile LCDC fixes and planes support
Message-Id: <1370110.yCkUojHsRN@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <3246665.HJN7RE5zfe@avalon>
In-Reply-To: <3246665.HJN7RE5zfe@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian,

On Wednesday 20 June 2012 01:01:31 Florian Tobias Schandinat wrote:
> On 06/16/2012 02:07 PM, Laurent Pinchart wrote:
> > Hi Florian,
> > 
> > Could you please pull the following LCDC patches ?
> 
> looks good, except...
> 
> > The following changes since commit 
b67989515defba7412acff01162e5bb1f0f5923a:
> >   video: s3c-fb: fix possible division by zero in s3c_fb_calc_pixclk
> > 
> > (2012-06-13 17:34:16 +0000)
> > 
> > are available in the git repository at:
> >   git://linuxtv.org/pinchartl/fbdev.git planes
> > 
> > Guennadi Liakhovetski (1):
> >       fbdev: sh_mipi_dsi: fix a section mismatch
> > 
> > Laurent Pinchart (4):
> >       fbdev: sh_mobile_lcdc: Don't confuse line size with pitch
> 
> ...for this patch it would have been better if you based your work on a
> more recent tree of Linus that already contains it instead of asking me
> to pull it again [I now forwarded my fbdev-next to -rc3]. It's not a big
> issue as git handles such situations but pushing patches around that are
> essentially nops should be avoided I think. Well, if you decide to fix
> it I'd be happy, otherwise I'll pull this in a few days nonetheless.

Sorry about that. I've rebased the branch on top of the latest fbdev-next and 
pushed it to git://linuxtv.org/pinchartl/fbdev.git planes, that no-op patches 
isn't present anymore.

-- 
Regards,

Laurent Pinchart

