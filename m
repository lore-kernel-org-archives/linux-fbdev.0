From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 29 Jan 2015 09:47:04 +0000
Subject: Re: [PATCH 2/3 v2] hyperv: hyperv_fb.c: match wait_for_completion_timeout return type
Message-Id: <20150129094704.GT6456@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422197222-7967-1-git-send-email-der.herr@hofr.at>
 <54C62D07.3040603@ti.com>
 <20150129093839.GB23666@opentech.at>
In-Reply-To: <20150129093839.GB23666@opentech.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, devel@linuxdriverproject.org, Haiyang Zhang <haiyangz@microsoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 29, 2015 at 10:38:39AM +0100, Nicholas Mc Guire wrote:
> On Mon, 26 Jan 2015, Tomi Valkeinen wrote:
> 
> > Hi,
> > 
> > On 25/01/15 16:47, Nicholas Mc Guire wrote:
> > > Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> > > ---
> > > 
> > > v2: fixed subject line
> > > 
> > > The return type of wait_for_completion_timeout is unsigned long not
> > > int. This patch fixes up the declarations only.
> > >

This line is relevant for the patch description.
 
> > > Patch was compile tested only for x86_64_defconfig + CONFIG_X86_VSMP=y
> > > CONFIG_HYPERV=m, CONFIG_FB_HYPERV=m

This line is not relevant.

regards,
dan carpenter


