From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 18 May 2020 12:46:54 +0000
Subject: Re: [PATCH v2 2/2] powerpc/configs: replace deprecated riva/nvidia with nouveau
Message-Id: <9ea9bd468fbce85b666991cde4196b88c7929e1d.camel@kernel.crashing.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200517220524.4036334-1-emil.l.velikov@gmail.com>
 <20200517220524.4036334-2-emil.l.velikov@gmail.com>
 <87d071aedu.fsf@mpe.ellerman.id.au>
 <CACvgo53uWVmhwon4+Fn5=_4HPXSciqNrf1MSJjt1kA3G2wyECw@mail.gmail.com>
In-Reply-To: <CACvgo53uWVmhwon4+Fn5=_4HPXSciqNrf1MSJjt1kA3G2wyECw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Emil Velikov <emil.l.velikov@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, ML dri-devel <dri-devel@lists.freedesktop.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Mon, 2020-05-18 at 12:19 +0100, Emil Velikov wrote:
> 
>  - attempted out-of-bound attempts to read the vbios

So on these things, the actual ROM doesn't contain what you want, but
the device-tree has a property "NVDA,BMP" that contains some kind of
mini-BIOS (around 2.4KB) which should contain the necessary tables the
driver is looking for.

I think nouveau has code to find these in nvkm/subdev/bios/shadowof.c,
so at least that should have been working, but maybe some
debugging/instrumentation would be useful there.

> Genuine concern or noise? Likely using the bios from open firmware,
> check any of the other options - see NvBios in [1]
>  - cannot figure out the timer input frequency
> No idea
>  - the TV1 EDID is empty
> Is there an actual TV connected to the device, check with another cable

Probaby not.

> Regardless of the patches, reporting [2] the above would be a nice move.
> 
> Thanks
> Emil
> [1] https://nouveau.freedesktop.org/wiki/KernelModuleParameters/
> [2] https://gitlab.freedesktop.org/xorg/driver/xf86-video-nouveau/-/issues
