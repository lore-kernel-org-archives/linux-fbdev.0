From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Mon, 18 May 2020 13:19:57 +0000
Subject: Re: [PATCH v2 2/2] powerpc/configs: replace deprecated riva/nvidia with nouveau
Message-Id: <CACvgo53=Vv7R-8BP32iQXwgvfxjJ8W5XCBmMq-tdUG-wUN6_4A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200517220524.4036334-1-emil.l.velikov@gmail.com>
 <20200517220524.4036334-2-emil.l.velikov@gmail.com>
 <87d071aedu.fsf@mpe.ellerman.id.au>
 <CGME20200518112226eucas1p1aa59db1e75cf0f91454b8714c828444c@eucas1p1.samsung.com>
 <CACvgo53uWVmhwon4+Fn5=_4HPXSciqNrf1MSJjt1kA3G2wyECw@mail.gmail.com>
 <3bd8fb59-2a91-64d7-bef9-d5f717c49bfb@samsung.com>
In-Reply-To: <3bd8fb59-2a91-64d7-bef9-d5f717c49bfb@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, ML dri-devel <dri-devel@lists.freedesktop.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Mon, 18 May 2020 at 13:48, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
>
> On 5/18/20 1:19 PM, Emil Velikov wrote:
> > Hi Michael,
> >
> > On Mon, 18 May 2020 at 08:30, Michael Ellerman <mpe@ellerman.id.au> wrote:
> >>
> >> Emil Velikov <emil.l.velikov@gmail.com> writes:
> >>> As mentioned in earlier commit, the riva and nvidia fbdev drivers have
> >>> seen no love over the years, are short on features and overall below par
> >>>
> >>> Users are encouraged to switch to the nouveau drm driver instead.
> >>>
> >>> v2: Split configs to separate patch, enable nouveau (Bartlomiej)
> >>>
> >>> Cc: Antonino Daplas <adaplas@gmail.com>
> >>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >>> Cc: linux-fbdev@vger.kernel.org
> >>> Cc: dri-devel@lists.freedesktop.org
> >>> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >>> Cc: Paul Mackerras <paulus@samba.org>
> >>> Cc: linuxppc-dev@lists.ozlabs.org
> >>> Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> >>> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch> (v1)
> >>> ---
> >>> Hi all unless, there are objections I would prefer to merge this via
> >>> the drm tree.
> >>
> >> Have you tested that the resulting kernels work on the relevant
> >> hardware?
> >>
> > Sadly, no I haven't. I'm updating the defconfigs as requested by the
> > fbdev maintainer.
>
> I've just noticed that v1 (patch #1/1) & v2 (patch #1/2) lack
> Cc: to powerpc Maintainers so they cannot see the context of
> changes in this patch.
>
Haven't see any instances of fbdev/drm patches being Cc to arch/ developers.
As such I made sure the commit message illustrates 1/2 as clearly as possible.

> Also you've proposed v1 yourself and it has already contained
> modifications to defconfigs (removal of setting the config
> options for the old drivers) in addition to marking the old
> drivers as BROKEN.
>
> It now turns out that v1 has also never been tested. :(
>
> Please don't submit untested patches without marking them
> as such.
>
Does x86 box with nv34 GPU count as testing? I suspect not :-(
It was been using nouveau ever since I bought it 15+ years ago.

Will be more careful in the future.

-Emil
