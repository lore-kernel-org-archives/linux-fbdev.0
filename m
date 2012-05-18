From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 18 May 2012 01:39:19 +0000
Subject: Re: [PULL for v3.4] SH Mobile LCDC fix
Message-Id: <4FB5A847.6050907@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <26224047.6PR9YZjWoc@avalon>
In-Reply-To: <26224047.6PR9YZjWoc@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Laurent,

On 05/17/2012 10:23 PM, Laurent Pinchart wrote:
> Hi Florian,
> 
> Is it still possible for the following patch to go to v3.4 ? I've only 
> realized now that MERAM support was broken in some use cases (one of them 
> being fbcon) due to a v3.4-rc regression - thanks to Guennadi Liakhovetski for 
> reporting this.

Umm, I don't like last minute stuff, but this is important enough. BUT...

> 
> If this is too late for v3.4 please let me know and I'll CC stable on the 
> patch and resend a pull request for v3.5.
> 
> The following changes since commit 5e7b911f9a3e582635801675b7fe935b16cd4af5:
> 
>   drivers/video: fsl-diu-fb: don't initialize the THRESHOLDS registers 
> (2012-05-13 13:08:56 +0000)

...how am I supposed to merge this? It's based on top of all the stuff
that I plan to ask Linus to pull during the merge window and AFAIK there
is no way to merge only upper parts of branches. I could cherry-pick it
but that wouldn't look like a merge or a patch I applied.
As this is only a single patch and not much time left, I'd suggest you
send it directly to Linus (as a patch) with my Ack added to it. Oh and
make sure to mention that this fixes a regression.


Thanks,

Florian Tobias Schandinat

> 
> are available in the git repository at:
>   git://linuxtv.org/pinchartl/fbdev.git fixes
> 
> Laurent Pinchart (1):
>       fbdev: sh_mobile_lcdc: Don't confuse line size with pitch
> 
>  drivers/video/sh_mobile_lcdcfb.c |    5 +++--
>  drivers/video/sh_mobile_lcdcfb.h |    1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 

