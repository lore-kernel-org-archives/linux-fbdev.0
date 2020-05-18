From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Mon, 18 May 2020 11:00:01 +0000
Subject: Re: [PATCH v2 2/2] powerpc/configs: replace deprecated riva/nvidia with nouveau
Message-Id: <CACvgo52Qws2VF0Bui-V3VdL5CFLsean9H=shLBi5H2S2fvjFSA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200517220524.4036334-1-emil.l.velikov@gmail.com>
 <20200517220524.4036334-2-emil.l.velikov@gmail.com>
 <9b0db95949b973c682b449906573e7b28c6113ef.camel@kernel.crashing.org>
In-Reply-To: <9b0db95949b973c682b449906573e7b28c6113ef.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Michael Ellerman <mpe@ellerman.id.au>, ML dri-devel <dri-devel@lists.freedesktop.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

Hi Benjamin,

On Mon, 18 May 2020 at 01:45, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Sun, 2020-05-17 at 23:05 +0100, Emil Velikov wrote:
> > As mentioned in earlier commit, the riva and nvidia fbdev drivers
> > have
> > seen no love over the years, are short on features and overall below
> > par
> >
> > Users are encouraged to switch to the nouveau drm driver instead.
> >
> > v2: Split configs to separate patch, enable nouveau (Bartlomiej)
>
> Back when I still had these things to play with (years ago) nouveau
> didn't work properly on these ancient machines.
>
I believe you reported issues due to different page size for the CPU/GPU.
Have you tried nouveau recently, there has been a handful of patches
on the topic since your report.

Alternatively, it would make sense you rebase, cleanup and merge your patch.

-Emil
