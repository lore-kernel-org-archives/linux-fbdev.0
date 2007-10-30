From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] [LXFB] Use the correct MSR number for panel support
Date: Mon, 29 Oct 2007 17:02:56 -0700
Message-ID: <472674B0.9080001@zytor.com>
References: <20071026145301.14168.19412.stgit@cosmic.amd.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754496AbXJ3ADd@vger.kernel.org>
In-Reply-To: <20071026145301.14168.19412.stgit@cosmic.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, tibor.osztodi@bbraun.com, linux-info@geode.amd.com

Jordan Crouse wrote:
> From: Jordan Crouse <jordan.crouse@amd.com>
> 
> A relatively recent version of the Geode LX datasheet listed the wrong
> address for one of the MSRs that controls TFT panels, resulting in 
> breakage.  This patch corrects the MSR address.
> 
> Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
> ---
> 
>  drivers/video/geode/lxfb.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/geode/lxfb.h b/drivers/video/geode/lxfb.h
> index 6c227f9..ca13c48 100644
> --- a/drivers/video/geode/lxfb.h
> +++ b/drivers/video/geode/lxfb.h
> @@ -33,7 +33,7 @@ void lx_set_palette_reg(struct fb_info *, unsigned int, unsigned int,
>  
>  #define MSR_LX_GLD_CONFIG    0x48002001
>  #define MSR_LX_GLCP_DOTPLL   0x4c000015
> -#define MSR_LX_DF_PADSEL     0x48000011
> +#define MSR_LX_DF_PADSEL     0x48002011
>  #define MSR_LX_DC_SPARE      0x80000011
>  #define MSR_LX_DF_GLCONFIG   0x48002001
>  

Please put MSR indicies in <asm-x86/msr-index.h> and/or a separate 
include file.

	-hpa
