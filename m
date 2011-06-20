From: "Premi, Sanjeev" <premi@ti.com>
Date: Mon, 20 Jun 2011 12:36:35 +0000
Subject: RE: [PATCH 1/2] config: omap2+: force fb and dss support as	built-in
Message-Id: <B85A65D85D7EB246BE421B3FB0FBB593024D625A86@dbde02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308566761-2850-1-git-send-email-tushar.behera@linaro.org>
	<1308566761-2850-2-git-send-email-tushar.behera@linaro.org>
	<B85A65D85D7EB246BE421B3FB0FBB593024D625A5C@dbde02.ent.ti.com>
	<20110620122032.GJ2082@n2100.arm.linux.org.uk>
In-Reply-To: <20110620122032.GJ2082@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> Sent: Monday, June 20, 2011 5:51 PM
> To: Premi, Sanjeev
> Cc: Tushar Behera; linux-kernel@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; 
> linux-fbdev@vger.kernel.org; linux-omap@vger.kernel.org; 
> tony@atomide.com; lethal@linux-sh.org; 
> linaro-dev@lists.linaro.org; patches@linaro.org; Nilofer, Samreen
> Subject: Re: [PATCH 1/2] config: omap2+: force fb and dss 
> support as built-in
> 
> On Mon, Jun 20, 2011 at 05:37:07PM +0530, Premi, Sanjeev wrote:
> > [sp] Instead of changing the omap2plus_defconfig, shouldn't the
> >      board specific file be fixed instead?
> 
> The board specific configuration files in the mainline kernel are
> deprecated and are gradually being removed.
> 
[sp] I didn't mean board specific config file, but:
     linux-linaro-2.6.39/arch/arm/mach-omap2/board-rx51-video.c

~sanjeev