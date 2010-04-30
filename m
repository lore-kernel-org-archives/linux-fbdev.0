From: Anatolij Gustschin <agust@denx.de>
Date: Fri, 30 Apr 2010 17:00:51 +0000
Subject: Re: [PATCH 3/5] powerpc/mpc5121: shared DIU framebuffer support
Message-Id: <20100430190051.3a5ba058@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<1272584978-19063-4-git-send-email-agust@denx.de>
	<s2ted82fe3e1004291905mf562f0cbi24054bb973aa2dbb@mail.gmail.com>
	<20100430121947.1d265ca6@wker>
	<x2ned82fe3e1004300808q757826cs864ac1c7c082f81@mail.gmail.com>
In-Reply-To: <x2ned82fe3e1004300808q757826cs864ac1c7c082f81-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Timur Tabi <timur.tabi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wd-ynQEQJNshbs@public.gmane.org, dzu-ynQEQJNshbs@public.gmane.org, John Rigby <jrigby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org

On Fri, 30 Apr 2010 10:08:45 -0500
Timur Tabi <timur.tabi@gmail.com> wrote:

> On Fri, Apr 30, 2010 at 5:19 AM, Anatolij Gustschin <agust@denx.de> wrote:
> 
> >> How about just doing this?
> >>
> >> .init_early             = mpc512x_init_diu,
> >
> > I thought it should be prepared for adding other code here.
> > mpc5121_ads_init_early() is generic and could contain other
> > things as well. I would vote for current version.
> 
> Do you have any plans to add any additional code?   If not, then I say
> skip the middle-man.  If someone ever needs to do more, he can always
> put that function back.

Currently I do not have such plans. Ok will skip them.

...
> >> Do you really need to use reserve_bootmem?  Have you tried kmalloc or
> >> alloc_pages_exact()?
> >
> > Yes. No, it is too early to use them here.
> 
> There was a recent change in the kernel that allows kmalloc to work
> earlier than before.  Take a look at commit
> 85355bb272db31a3f2dd99d547eef794805e1319 ("powerpc: Fix mpic alloc
> warning").

Thanks. Sorry for my wrong answer above, now I remember the logic
behind this and will try to explain. Actually the reason I do not
use kmalloc() here is that I do not want to _copy_ bitmap data to
newly allocated frame buffer area (It will negatively affect boot
time). Instead I reserve the already configured frame buffer area
so that it won't be destroyed. The starting address of the area
to reserve and also the lenght is passed to reserve_bootmem().
This is the real reason for using reserve_bootmem() here.
I could alloc new bitmap area using allocators, but then I have
to copy the bitmap data (splash image) to newly allocated area
and have to re-configure the descriptors to display from new
bitmap buffer.

Anatolij
