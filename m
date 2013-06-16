From: Kukjin Kim <kgene.kim@samsung.com>
Date: Sun, 16 Jun 2013 20:52:48 +0000
Subject: Re: [RFC PATCH 5/5] ARM: Samsung: Remove MIPI PHY setup code
Message-Id: <51BE25A0.6050202@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371231951-1969-1-git-send-email-s.nawrocki@samsung.com>
 <1371231951-1969-6-git-send-email-s.nawrocki@samsung.com>
In-Reply-To: <1371231951-1969-6-git-send-email-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 06/15/13 02:45, Sylwester Nawrocki wrote:
> Generic PHY drivers are used to handle the MIPI CSIS and MIPI DSIM
> DPHYs so we can remove now unused code at arch/arm/plat-samsung.

If so, sounds good :)

> In case there is any board file for S5PV210 platforms using MIPI
> CSIS/DSIM (not any upstream currently) it should use the generic
> PHY API to bind the PHYs to respective PHY consumer drivers.

To be honest, I didn't test this on boards but if the working is fine, 
please go ahead without RFC.

Thanks,
- Kukjin
