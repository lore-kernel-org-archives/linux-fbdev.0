From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] s3c-fb: added patch series for s5pv210 and some
	features.
Date: Wed, 12 May 2010 05:07:13 +0100
Message-ID: <20100512040713.GP2589@trinity.fluff.org>
References: <m2g90b950fc1005070059k99d138efr4bfa7de44c58fdd0@mail.gmail.com> <20100510172254.1f28f07c.akpm@linux-foundation.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100510172254.1f28f07c.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: InKi Dae <daeinki@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, Ben Dooks <ben-linux@fluff.org>

On Mon, May 10, 2010 at 05:22:54PM -0400, Andrew Morton wrote:
> On Fri, 7 May 2010 16:59:56 +0900 InKi Dae <daeinki@gmail.com> wrote:
> 
> > this includes three patch series and divides previous patch
> > into smaller part.
> > 
> > so Andrew, please remove my previous patch,
> > s3c-fb-add-s5pv210-support-and-some-features.patch from mm tree.
> > 
> > patch contents are as following.
> > 
> > 1. s3c_fb_1_3.patch
> >   - as patch for supporting s5pv210, CH_ENABLE bit of SHAD
> >     register should be enabled to enable window layer on s5pv210.
> > 
> > 2. s3c_fb_2_3.patch
> >    - s5pv210 has five window layers (window0 ~ 4), among them,
> >      window0 ~ 2 could be used for local path with fimc(capture device)
> >      and fimd writeback feature so this patch makes default window
> >      layer for UI to be set at machine code.
> > 
> > 3. s3c_fb_3_3.patch
> >    - it has been working fine at 16bpp but in case of pixel format
> >      more then 24bpp it would occur distortedness situation
> >      on that mode. so this patch set the word swap control bit of
> >      WINCONx to 1 as default value. but it should be set to 0
> >      in case that each ENLOCAL bit of WINCON0 ~ 2 registers
> >      is enabled. this issue would be solved with local path feature soon.
> 
> I prefer not to receive patches this way, sorry.  I will need to detach
> the attachments, copy-n-paste the changelogs and signoffs and then
> invent meaningful English-language titles for each patch.

Please include me on these patches as I am working on adding S3C2443/2416
support to the driver and removing the need for arch-based header files
for this.

I may ask Andrew if we can merge the updates via my samsung tree as it is
possible that we need to touch arch code and driver code at the same time.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
