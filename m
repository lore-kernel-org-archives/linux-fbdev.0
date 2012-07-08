From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 08 Jul 2012 22:10:17 +0000
Subject: Re: [PATCH 0/2] OMAPDSS: PM runtime fixes for 3.5-rc
Message-Id: <4FFA0549.9020802@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341405829-16964-1-git-send-email-archit@ti.com>
In-Reply-To: <1341405829-16964-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>
Cc: tomi.valkeinen@ti.com, jaswinder.singh@linaro.org, jw@terrafix.co.uk, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

Hi Archit,

On 07/04/2012 12:43 PM, Archit Taneja wrote:
> Hi Florian,
> 
> These are 2 fixes which Tomi had intended to push for the coming rcs. He is
> currently on vacation and asked me to post the patches on his behalf.
> 
> The first patch ensures that system suspend doesn't break on OMAP if DSS is
> enabled. The second patch prevents some warning backtraces when the kernel is
> not built with PM runtime.
> 
> Could you please queue these for the upcoming rc?

as you sent me those patches you should have added your Signed-off-by as
well, I added it.
Also the first patch of this series contained 2 coding style issues
related to braces that checkpatch complained about and also differed
from the coding style used in those files, I fixed those as well.
I applied both patches.


Thanks,

Florian Tobias Schandinat

> 
> Thanks,
> Archit
> 
> Tomi Valkeinen (2):
>   OMAPDSS: Use PM notifiers for system suspend
>   OMAPDSS: fix warnings if CONFIG_PM_RUNTIME=n
> 
>  drivers/video/omap2/dss/core.c  |   45 +++++++++++++++++++++++++--------------
>  drivers/video/omap2/dss/dispc.c |    2 +-
>  drivers/video/omap2/dss/dsi.c   |    2 +-
>  drivers/video/omap2/dss/dss.c   |    2 +-
>  drivers/video/omap2/dss/hdmi.c  |    2 +-
>  drivers/video/omap2/dss/rfbi.c  |    2 +-
>  drivers/video/omap2/dss/venc.c  |    2 +-
>  7 files changed, 35 insertions(+), 22 deletions(-)
> 

