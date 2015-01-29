From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Thu, 29 Jan 2015 10:41:41 +0000
Subject: Re: [PATCH 2/3 v2] hyperv: hyperv_fb.c: match wait_for_completion_timeout return type
Message-Id: <20150129104141.GA32124@opentech.at>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422197222-7967-1-git-send-email-der.herr@hofr.at> <54C62D07.3040603@ti.com> <20150129093839.GB23666@opentech.at> <54CA0CBA.6030900@ti.com>
In-Reply-To: <54CA0CBA.6030900@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, devel@linuxdriverproject.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 29 Jan 2015, Tomi Valkeinen wrote:

> On 29/01/15 11:38, Nicholas Mc Guire wrote:
> > On Mon, 26 Jan 2015, Tomi Valkeinen wrote:
> > 
> >> Hi,
> >>
> >> On 25/01/15 16:47, Nicholas Mc Guire wrote:
> >>> Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> >>> ---
> >>>
> >>> v2: fixed subject line
> >>>
> >>> The return type of wait_for_completion_timeout is unsigned long not
> >>> int. This patch fixes up the declarations only.
> >>>
> >>> Patch was compile tested only for x86_64_defconfig + CONFIG_X86_VSMP=y
> >>> CONFIG_HYPERV=m, CONFIG_FB_HYPERV=m
> >>
> >> Why didn't you set the text above as the patch description (which is
> >> empty at the moment)?
> >>
> > basically because the one-line is sufficient to understand the patch
> 
> You didn't have one line, you had no description. Patch subject is not
> patch description. In the minimal case, the description should have the
> same text as the subject, but usually it's better to have a bit more
> text in the description.

ok - was not clear about this - got it.

> 
> > and the rest of the information is not relevant for the git log but only
> > for the review
> > 
> > if you think it is necessary to understand the patch I'll move it and
> > resubmit.
> 
> Well, a good description is not only about understanding the code in the
> patch. It may contain information like which platform/setup this issue
> happened on, are the any possible side effects, or whatever might be
> relevant for someone looking at the patch years later.
> 
yup - but it seemed to me that the information on the build
config and kernel version details would not really be relevant for
this cleanup patch - so if I got your right the description line should
have gone up and the config/kernel info stays below "---".

Just resent it - hope this is correct now.

thx!
hofrat

