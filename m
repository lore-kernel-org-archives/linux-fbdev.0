From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Mon, 18 May 2020 11:19:32 +0000
Subject: Re: [PATCH v2 2/2] powerpc/configs: replace deprecated riva/nvidia with nouveau
Message-Id: <CACvgo53uWVmhwon4+Fn5=_4HPXSciqNrf1MSJjt1kA3G2wyECw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200517220524.4036334-1-emil.l.velikov@gmail.com>
 <20200517220524.4036334-2-emil.l.velikov@gmail.com>
 <87d071aedu.fsf@mpe.ellerman.id.au>
In-Reply-To: <87d071aedu.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, ML dri-devel <dri-devel@lists.freedesktop.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

Hi Michael,

On Mon, 18 May 2020 at 08:30, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Emil Velikov <emil.l.velikov@gmail.com> writes:
> > As mentioned in earlier commit, the riva and nvidia fbdev drivers have
> > seen no love over the years, are short on features and overall below par
> >
> > Users are encouraged to switch to the nouveau drm driver instead.
> >
> > v2: Split configs to separate patch, enable nouveau (Bartlomiej)
> >
> > Cc: Antonino Daplas <adaplas@gmail.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: linux-fbdev@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch> (v1)
> > ---
> > Hi all unless, there are objections I would prefer to merge this via
> > the drm tree.
>
> Have you tested that the resulting kernels work on the relevant
> hardware?
>
Sadly, no I haven't. I'm updating the defconfigs as requested by the
fbdev maintainer.

> The old drivers may be crufty but they presumably have been tested by
> people and at least somewhat work.
>
> So I'd be inclined to leave the defconfigs alone until someone can test
> that the new driver works at all.
>
Works for me.

> I gave it a quick spin on a G5 I have access to and dmesg has a bunch of
> errors in it (see below). I can't actually tell if the display is
> working because the machine is remote, and I can't go and check it at
> the moment because the office is closed.
>

From what I can see, there seems to be three bits:
 - attempted out-of-bound attempts to read the vbios
Genuine concern or noise? Likely using the bios from open firmware,
check any of the other options - see NvBios in [1]
 - cannot figure out the timer input frequency
No idea
 - the TV1 EDID is empty
Is there an actual TV connected to the device, check with another cable

Regardless of the patches, reporting [2] the above would be a nice move.

Thanks
Emil
[1] https://nouveau.freedesktop.org/wiki/KernelModuleParameters/
[2] https://gitlab.freedesktop.org/xorg/driver/xf86-video-nouveau/-/issues
