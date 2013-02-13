From: Anatolij Gustschin <agust@denx.de>
Date: Wed, 13 Feb 2013 20:13:15 +0000
Subject: Re: [PATCH RESEND v2 2/2] drivers/video: fsl-diu-fb: fix bugs in interrupt handling
Message-Id: <20130213211315.75b78816@crub>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360308959-3096-2-git-send-email-agust@denx.de>
In-Reply-To: <1360308959-3096-2-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, 13 Feb 2013 11:55:24 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 13 Feb 2013 10:21:52 +0100
> Anatolij Gustschin <agust@denx.de> wrote:
> 
> > On Tue, 12 Feb 2013 17:01:55 -0800
> > Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > > On Tue, 12 Feb 2013 16:54:58 -0800
> > > Andrew Morton <akpm@linux-foundation.org> wrote:
> > > 
> > > > Thanks, I queued both these with a plan to merge into 3.9-rc1.
> > > 
> > > No I didn't.  The patches have already found their way into linux-next
> > > via some other tree.
> > 
> > Yes, via MPC5XXX tree. Since I didn't receive response from fbdev
> > maintainer I applied both patches in my powerpc MPC5XXX next branch
> > so that these can be exposed in linux-next at least. MPC5121 uses the
> > fsl-diu-fb driver, so these patches could go via MPC5XXX tree, but I
> > can't push them via my tree without an ACK from fbdev maintainer.
> 
> The patches look OK to me - I suggest you go ahead and merge them up
> for 3.9-rc1.

Okay, will do.

> > > Without any -stable tags, either.  You don't think we should fix the
> > > "24 and 16 bpp" thing in 3.8.x and earlier?
> > 
> > I didn't add any -stable tags since my hope was that the patches
> > will go into v3.8 via fbdev tree. It would be good to fix the bpp
> > issue in 3.8.x. But the issue is not critical for earlier maintained
> > stable versions I think.
> 
> Please remember to add the cc:stable to the changelogs if you want
> these in 3.8.x and earlier.

Okay, thanks!

Anatolij
