From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Mon, 30 Jul 2012 08:49:15 +0000
Subject: Re: [PATCH 1/3] Move FIMD register headers to include/video/
Message-Id: <50164A8B.3070907@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343637905-17764-1-git-send-email-l.krishna@samsung.com>
 <1343637905-17764-2-git-send-email-l.krishna@samsung.com>
In-Reply-To: <1343637905-17764-2-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, ben-linux@fluff.org, inki.dae@samsung.com, kgene.kim@samsung.com, joshi@samsung.com, jg1.han@samsung.com

Hi,

On 07/30/2012 10:45 AM, Leela Krishna Amudala wrote:
> Moved the contents of regs-fb-v4.h and regs-fb.h from arch side
> to include/video/samsung_fimd.h
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  arch/arm/plat-samsung/include/plat/regs-fb-v4.h |  159 -------
>  arch/arm/plat-samsung/include/plat/regs-fb.h    |  403 -----------------
>  include/video/samsung_fimd.h                    |  533 +++++++++++++++++++++++
>  3 files changed, 533 insertions(+), 562 deletions(-)
>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb-v4.h
>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb.h
>  create mode 100644 include/video/samsung_fimd.h

Thanks for taking care if this. However you might need to split this 
patch in two, so there is no build and git bisection breakage. In the
first patch a new header file would be added, then the patch updating
users of the FIMD headers would be applied, and finally the regs-fb*.h 
files would be removed.

Also it helps to use -M option to git format-patch when creating patches
that mainly move files.

--

Regards,
Sylwester
