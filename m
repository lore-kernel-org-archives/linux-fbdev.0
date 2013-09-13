From: Zhou Zhu <zzhu3@marvell.com>
Date: Fri, 13 Sep 2013 07:41:07 +0000
Subject: Re: [PATCH V5 0/5] video: mmp: misc updates for mmp display driver
Message-Id: <5232C193.1030604@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379055589-26132-1-git-send-email-zzhu3@marvell.com>
In-Reply-To: <1379055589-26132-1-git-send-email-zzhu3@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi, Jean-Christophe, Tomi,

Would you please help to review/apply this patch set?
It has been there for more than 2 months from v3 in which version we 
made last update...

On 09/13/2013 02:59 PM, Zhou Zhu wrote:
> Resend this patch set, the V1 to V4 of which is sent by Jett Zhou.
> This patch set contains some misc updates for mmp display controller:
> 1. Rbswap enhancement
> 2. Code refine.
> 3. Pitch calculation and video layer settings.
>
> Changes:
> V5/V4:
> Just rebase.
>
> V3/V2:
> some updates according to comments.
>
> Guoqing Li (2):
>    video: mmp: rb swap setting update for mmp display
>    video: mmp: optimize some register setting code
>
> Jett.Zhou (1):
>    ARM: mmp: remove the legacy rbswap setting for ttc_dkb platform
>
> Jing Xiang (2):
>    video: mmp: calculate pitch value when fb set win
>    video: mmp: add pitch info in mmp_win structure
>
>   arch/arm/mach-mmp/ttc_dkb.c     |    4 +--
>   drivers/video/mmp/fb/mmpfb.c    |   34 ++++++++++++-------
>   drivers/video/mmp/hw/mmp_ctrl.c |   71 ++++++++++++++++++++++-----------------
>   drivers/video/mmp/hw/mmp_ctrl.h |    5 +++
>   include/video/mmp_disp.h        |    6 ++++
>   5 files changed, 75 insertions(+), 45 deletions(-)
>


-- 
Thanks, -Zhou
