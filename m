From: Shawn Guo <shawn.guo@linaro.org>
Date: Wed, 18 Jul 2012 17:08:41 +0000
Subject: Re: Device tree binding for DVFS table
Message-Id: <20120718170838.GA27581@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FFD77FE.8050206@nvidia.com>
In-Reply-To: <4FFD77FE.8050206@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jul 11, 2012 at 06:26:30PM +0530, Prashant Gaikwad wrote:
> Hi,
> 
> I am working on DT binding for Tegra DVFS.
> 
> For Tegra, DVFS node mainly consists of frequency and voltage pairs.
> Frequency in the pair may change for different process. E.g. for
> process 1 CPU clock frequency could be 900MHz at 1V while for
> process 2 it could be 1GHz at 1V.
> Tegra uses vendor specific ids to identify the correct frequency table.
> 
> Following is the proposed binding for voltage and frequency tables
> used in DVFS. Looking for comments/suggestions to make it generic.
> 
It seems we are trying to approach a generic binding for DVFS operating
points.  In that case, we will need a generic library helper function
to parse it.  But since we already have such a library - OPP
(drivers/base/power/opp.c) in place, I would approach the same goal
in other way around, adding device tree binding for OPP.  Please see
the patch I just sent out below and comment.

[PATCH] PM / OPP: Initialize OPP table from device tree

-- 
Regards,
Shawn

