From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Make radeon_reinitialize_M10() absent if its reference
 is #ifdef'd out
Date: Wed, 15 Apr 2009 18:40:27 +0200
Message-ID: <1239813627.7443.18.camel@pasglop>
References: <20090414155651.27671.36394.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754426AbZDOQmi@vger.kernel.org>
In-Reply-To: <20090414155651.27671.36394.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: David Howells <dhowells@redhat.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

On Tue, 2009-04-14 at 16:56 +0100, David Howells wrote:
> Make radeon_reinitialize_M10() absent if its reference is #ifdef'd out
> (if
> CONFIG_PM=n or CONFIG_PPC_PMAC=n.  Otherwise a warning is given:
> 
>   CC      drivers/video/aty/radeon_pm.o
> drivers/video/aty/radeon_pm.c:1720: warning: 'radeon_reinitialize_M10'
> defined but not used
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Nah. You ifdef it with CONFIG_PPC_PMAC, but it can be used on x86
too (see the "BUGFIX" entries).

Cheers,
Ben.

> ---
> 
>  drivers/video/aty/radeon_pm.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/drivers/video/aty/radeon_pm.c
> b/drivers/video/aty/radeon_pm.c
> index 97a1f09..8655bbd 100644
> --- a/drivers/video/aty/radeon_pm.c
> +++ b/drivers/video/aty/radeon_pm.c
> @@ -1716,6 +1716,7 @@ static void radeon_pm_m10_reconfigure_mc(struct radeonfb_info *rinfo)
>  	OUTREG(MC_IND_INDEX, 0);
>  }
>  
> +#if defined(CONFIG_PM) && defined(CONFIG_PPC_PMAC)
>  static void radeon_reinitialize_M10(struct radeonfb_info *rinfo)
>  {
>  	u32 tmp, i;
> @@ -1940,6 +1941,7 @@ static void radeon_reinitialize_M10(struct radeonfb_info *rinfo)
>  	 */
>  	radeon_pm_m10_enable_lvds_spread_spectrum(rinfo);
>  }
> +#endif /* CONFIG_PM && CONFIG_PPC_PMAC */
>  
>  #ifdef CONFIG_PPC_OF
>  
