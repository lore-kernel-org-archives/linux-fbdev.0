From: Daniel Walker <dwalker@fifo99.com>
Date: Wed, 23 Mar 2011 13:11:52 +0000
Subject: Re: [PATCH 09/20] video: msm: Split out MDP2.2 HW specific code.
Message-Id: <1300885912.6117.16.camel@m0nster>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
	<1300485423-27281-1-git-send-email-carlv@codeaurora.org>
In-Reply-To: <1300485423-27281-1-git-send-email-carlv@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 2011-03-18 at 14:57 -0700, Carl Vanderlip wrote:
> index df9d74e..d6e75c3 100644
> --- a/arch/arm/mach-msm/Kconfig
> +++ b/arch/arm/mach-msm/Kconfig
> @@ -76,6 +76,11 @@ config HAS_MSM_DEBUG_UART_PHYS
>  config  MSM_VIC
>         bool
>  
> +config MSM_MDP22
> +       bool
> +       depends on ARCH_MSM7X00A
> +       default y
> + 

You should remove the "default y" and this should be moved to a Kconfig
under video (shouldn't be added into mach-msm).

Daniel

