From: Shawn Guo <shawn.guo@freescale.com>
Date: Fri, 18 Feb 2011 08:57:04 +0000
Subject: Re: [PATCH 1/2] video: Add i.MX23/28 framebuffer driver
Message-Id: <20110218085703.GC18085@S2100-06.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297850199-1688-1-git-send-email-s.hauer@pengutronix.de>
	<1297850199-1688-2-git-send-email-s.hauer@pengutronix.de>
	<20110218052418.GA18053@S2100-06.ap.freescale.net>
	<20110218083055.GE24426@pengutronix.de>
In-Reply-To: <20110218083055.GE24426@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Feb 18, 2011 at 09:30:55AM +0100, Sascha Hauer wrote:
> On Fri, Feb 18, 2011 at 01:24:20PM +0800, Shawn Guo wrote:
> > Sorry, I did not catch up with v1 of the patch set.
> > 
> > I have a overall comment on the driver.  There is many occurrences
> > of mx23, mx28 etc. throughout the file.  IMHO, this is not a good
> > idea.  It may be better to use the IP version to handle the
> > differences.  In this way, if we have another SoC coming later
> > using the same LCDIF revision as i.MX28.  The driver could
> > immediately fit in without code change, ideally.
> > 
> > The only problem with version register is that the offset of LCDIF
> > version register is different on i.MX28 from i.MX23.
> 
> Can opener inside can. I love it ;)
> 
Well, that's the situation we have to deal with.

> > You still need
> > cpu_is_mx23 to read the correct version.
> > 
> > BTW, I would try to use cpu_is_mx23 than cpu_is_mx28, as the 'else'
> > of cpu_is_mx23 could _possibly_ cover later SoC as well as i.MX28.
> 
> There is only one cpu_is_mx28 in the driver without else. I can switch
> MXSFB_MX23 and MXSFB_MX28 to MXSFB_V3 and MXSFB_V4 if you like it
> better.
> 
Yes, I like it better.  With it, if we have a new SoC using LCDIF v4,
the driver needs no change. 

-- 
Regards,
Shawn

