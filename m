From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 06 Jun 2011 03:01:47 +0000
Subject: Re: [Patch 1/2] Fix use-after-free by vga16fb on rmmod
Message-Id: <20110606030146.GC26101@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110524215917.4b01df45@neptune.home>
In-Reply-To: <20110524215917.4b01df45@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Bruno,

On Thu, Jun 02, 2011 at 08:18:57PM +0200, Bruno Pr??mont wrote:
> On Tue, 24 May 2011 Bruno Pr??mont <bonbons@linux-vserver.org> wrote:
> > Since fb_info is now refcounted and thus may get freed at any time it
> > gets unregistered module unloading will try to unregister framebuffer
> > as stored in platform data on probe though this pointer may
> > be stale.
> > 
> > Cleanup platform data on framebuffer release.
> > 
> > CC: stable@kernel.org
> > Signed-off-by: Bruno Pr??mont <bonbons@linux-vserver.org>
> > ---
> > This should also go into 2.6.39 stable as it didn't make it into 2.6.39
> > with the rest of fb_info refcounting work.
> > 
> > This comes from
> >   [2.6.39-rc2, framebuffer] use after free oops
> >      ...
> >        [PATCH 0/2] fbcon sanity
> > thread
> 
> Any chance of applying these two patches?
> 
> I've had no feedback from you on them and they don't show up in your tree.
> 
Patchwork has been a bit spotty lately with some patches showing up and
others not, so I've invariably missed a few. I've applied the first one
now, and will address the second one separately.
