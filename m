From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Thu, 29 Jan 2015 09:38:39 +0000
Subject: Re: [PATCH 2/3 v2] hyperv: hyperv_fb.c: match wait_for_completion_timeout return type
Message-Id: <20150129093839.GB23666@opentech.at>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422197222-7967-1-git-send-email-der.herr@hofr.at> <54C62D07.3040603@ti.com>
In-Reply-To: <54C62D07.3040603@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, devel@linuxdriverproject.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 26 Jan 2015, Tomi Valkeinen wrote:

> Hi,
> 
> On 25/01/15 16:47, Nicholas Mc Guire wrote:
> > Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> > ---
> > 
> > v2: fixed subject line
> > 
> > The return type of wait_for_completion_timeout is unsigned long not
> > int. This patch fixes up the declarations only.
> > 
> > Patch was compile tested only for x86_64_defconfig + CONFIG_X86_VSMP=y
> > CONFIG_HYPERV=m, CONFIG_FB_HYPERV=m
> 
> Why didn't you set the text above as the patch description (which is
> empty at the moment)?
> 
basically because the one-line is sufficient to understand the patch
and the rest of the information is not relevant for the git log but only
for the review

if you think it is necessary to understand the patch I'll move it and
resubmit.

thanks for your review !

hofrat
