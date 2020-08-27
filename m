From: Michael Ellerman <patch-notifications@ellerman.id.au>
Date: Thu, 27 Aug 2020 07:46:53 +0000
Subject: Re: [PATCH] video: fbdev: controlfb: Fix build for COMPILE_TEST=y && PPC_PMAC=n
Message-Id: <159851436069.52163.17558243673000868151.b4-ty@ellerman.id.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200821104910.3363818-1-mpe@ellerman.id.au>
In-Reply-To: <20200821104910.3363818-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, sam@ravnborg.org

On Fri, 21 Aug 2020 20:49:10 +1000, Michael Ellerman wrote:
> The build is currently broken, if COMPILE_TEST=y and PPC_PMAC=n:
> 
>   linux/drivers/video/fbdev/controlfb.c: In function ‘control_set_hardware’:
>   linux/drivers/video/fbdev/controlfb.c:276:2: error: implicit declaration of function ‘btext_update_display’
>     276 |  btext_update_display(p->frame_buffer_phys + CTRLFB_OFF,
>         |  ^~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to powerpc/fixes.

[1/1] video: fbdev: controlfb: Fix build for COMPILE_TEST=y && PPC_PMAC=n
      https://git.kernel.org/powerpc/c/4d618b9f3fcab84e9ec28c180de46fb2c929d096

cheers
