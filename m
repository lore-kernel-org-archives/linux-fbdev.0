From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 04 Jan 2018 15:40:38 +0000
Subject: Re: [PATCH 0/6] video: udlfb: (not only) Logging cleanup
Message-Id: <1594475.76bM9bkN7v@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Monday, December 11, 2017 10:39:48 PM Ladislav Michl wrote:
> This patchset is a side product of debugging on unreliable USB host
> where devices saw a lot of disconnects. It turned out that udlfb
> logging is just too noisy to be usefull as produced syslog is hard
> to read.
> 
> Hence this attempt to clean things up.
> 
> Comments and suggestions welcome and appreciated, as always.
> 
> Ladislav Michl (6):
>   video: udlfb: Do not name private data 'dev'

This patch no longer applies cleanly after following patches:

11ab5a6 video: udlfb: Delete an unnecessary return statement in two functions
74fb251 video: udlfb: Improve a size determination in dlfb_alloc_urb_list()

have been merged into fbdev-for-next.

>   video: udlfb: Remove unnecessary 'return'

I've already applied identical patch from Markus which was posted
some time earlier.

>   video: udlfb: Remove unnecessary local variable

Please make this patch #1 in the series.

>   video: udlfb: Delete error messages for failed allocations

In one place this patch removes the information about the device for
which the allocation fails and generally I would prefer to still have
the information about devices for which allocation fails (so please
consider dropping this patch and converting relevant places to use
dev_*() logging functions).

>   video: udlfb: Remove redundant gdev variable

Please make this patch #2 in the series.

>   video: udlfb: Switch from the pr_*() to the dev_*() logging functions

This patch also removes some log entries completely and I would prefer
such changes to be split into a separate pre-patch (please also give
a valid rationale for the removal in the patch description).

>  drivers/video/fbdev/udlfb.c | 617 ++++++++++++++++++++------------------------
>  include/video/udlfb.h       |   3 +-
>  2 files changed, 284 insertions(+), 336 deletions(-)

Please rebase, fix and resubmit, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

