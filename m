From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 11 Jul 2011 05:36:42 +0000
Subject: Re: [PATCH 0/5 v4] LCDC MERAM runtime PM support
Message-Id: <20110711053642.GH24169@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1309766728-32419-1-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1309766728-32419-1-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Jul 04, 2011 at 05:05:28PM +0900, Damian Hobson-Garcia wrote:
> This patch series is a provides PM runtime support for the LCDC MERAM.
> 
> The runtime_pm_get/put calls are made at the same time as the LCDC calls, so
> that the LCDC MERAM is enabled with the first LCDC device and disabled 
> with the last LCDC device.
> 
> The first 4 patches will apply to rmobile-latest or common/fbdev-meram as-is,
> but the final patch needs to have the "PM / Domains: Support for generic I/O PM
> domains" patch series. 
> 
> Only the first 2 patches of the series have been updated from v3 sent on
> 2011/06/22
> 
> Changes from V3
> 
> * Remove the MERAM callbacks used to runtime_get/runtime_put the device from
>   the LCDC driver.  Instead, just call the functions on the MERAM device
>   directly
> 
> Damian Hobson-Garcia (5):
>   fbdev: sh_mobile_meram: Enable runtime PM
>   fbdev: sh_mobile_meram: Enable/disable MERAM along with LCDC - v4
>   fbdev: sh_mobile_meram: Move private data from .h to .c 
>   fbdev: sh_mobile_meram: Backup/restore device registers on
>     shutdown/resume - v3
>   fbdev: sh_mobile_meram: Assign meram to the SH7372_A4LC power domain
> 
I've applied 1-4, and will roll in the last one once the power domain
stuff hits mainline.
