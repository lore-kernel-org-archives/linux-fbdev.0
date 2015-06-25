From: Borislav Petkov <bp@suse.de>
Date: Thu, 25 Jun 2015 20:48:08 +0000
Subject: Re: [PATCH v5 0/3] atyfb: address MTRR corner case
Message-Id: <20150625204808.GD4898@pd.tnic>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435196060-27350-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1435196060-27350-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: akpm@linux-foundation.org, mingo@elte.hu, syrjala@sci.fi, ville.syrjala@linux.intel.com, luto@amacapital.net, tomi.valkeinen@ti.com, mst@redhat.com, benh@kernel.crashing.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-pci@vger.kernel.org, airlied@redhat.com, "Luis R. Rodriguez" <mcgrof@suse.com>

On Wed, Jun 24, 2015 at 06:34:17PM -0700, Luis R. Rodriguez wrote:
> Luis R. Rodriguez (3):
>   video: fbdev: atyfb: clarify ioremap() base and length used
>   video: fbdev: atyfb: replace MTRR UC hole with strong UC
>   video: fbdev: atyfb: use arch_phys_wc_add() and ioremap_wc()
> 
>  drivers/video/fbdev/aty/atyfb.h      |  5 +--
>  drivers/video/fbdev/aty/atyfb_base.c | 74 +++++++++++-------------------------
>  2 files changed, 24 insertions(+), 55 deletions(-)

Took those too along with

"[PATCH] video: fbdev: atyfb: move framebuffer length fudging to helper"

which was missing here.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
