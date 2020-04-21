From: Joel Stanley <joel@jms.id.au>
Date: Tue, 21 Apr 2020 01:04:48 +0000
Subject: Re: [PATCH 5/5] powerpc: Remove _ALIGN_UP(), _ALIGN_DOWN() and _ALIGN()
Message-Id: <CACPK8Xf+h378ddF_YakTT++gv_Zx-raBqg54VkKPS3=qe6193Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <a5945463f86c984151962a475a3ee56a2893e85d.1587407777.git.christophe.leroy@c-s.fr>
 <bb0a6081f7b95ee64ca20f92483e5b9661cbacb2.1587407777.git.christophe.leroy@c-s.fr>
In-Reply-To: <bb0a6081f7b95ee64ca20f92483e5b9661cbacb2.1587407777.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linux-fbdev@vger.kernel.org, kvm@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org

On Mon, 20 Apr 2020 at 18:39, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>
> These three powerpc macros have been replaced by
> equivalent generic macros and are not used anymore.
>
> Remove them.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-By: Joel Stanley <joel@jms.id.au>

riscv has a copy of these too that could probably be removed:

arch/riscv/include/asm/page.h:#define _ALIGN_UP(addr, size)
(((addr)+((size)-1))&(~((size)-1)))
arch/riscv/include/asm/page.h:#define _ALIGN(addr, size)
_ALIGN_UP(addr, size)



> ---
>  arch/powerpc/include/asm/page.h | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 3ee8df0f66e0..a63fe6f3a0ff 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -249,13 +249,6 @@ static inline bool pfn_valid(unsigned long pfn)
>  #include <asm/page_32.h>
>  #endif
>
> -/* align addr on a size boundary - adjust address up/down if needed */
> -#define _ALIGN_UP(addr, size)   __ALIGN_KERNEL(addr, size)
> -#define _ALIGN_DOWN(addr, size)        ((addr)&(~((typeof(addr))(size)-1)))
> -
> -/* align addr on a size boundary - adjust address up if needed */
> -#define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
> -
>  /*
>   * Don't compare things with KERNELBASE or PAGE_OFFSET to test for
>   * "kernelness", use is_kernel_addr() - it should do what you want.
> --
> 2.25.0
>
