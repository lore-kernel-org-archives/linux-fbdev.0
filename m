From: Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Wed, 23 Jun 2010 15:43:05 +0000
Subject: Re: [PATCH] vt/console: try harder to print output when panicing
Message-Id: <20100623084305.033df51e@virtuousgeek.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1277262779-19338-1-git-send-email-airlied@gmail.com>
In-Reply-To: <1277262779-19338-1-git-send-email-airlied@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.sf.net, linux-kernel@vger.kernel.org

On Wed, 23 Jun 2010 13:12:59 +1000
Dave Airlie <airlied@gmail.com> wrote:

> From: Jesse Barnes <jbarnes@virtuousgeek.org>
> 
> Jesse's initial patch commit said:
> 
> "At panic time (i.e. when oops_in_progress is set) we should try a bit
> harder to update the screen and make sure output gets to the VT, since
> some drivers are capable of flipping back to it.
> 
> So make sure we try to unblank and update the display if called from a
> panic context."
> 
> I've enhanced this to add a flag to the vc that console layer can set
> to indicate they want this behaviour to occur. This also adds support
> to fbcon for that flag and adds an fb flag for drivers to indicate
> they want to use the support. It enables this for KMS drivers.
> 
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---

Yeah this looks a little nicer, thanks.

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

-- 
Jesse Barnes, Intel Open Source Technology Center
