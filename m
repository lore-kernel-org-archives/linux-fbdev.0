From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 03 Jul 2017 08:30:32 +0000
Subject: Re: [PATCH v2] staging: sm750fb: fixed a assignment typo
Message-Id: <20170703083031.GA26406@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170703081315.GA1115@lynnl.wit>
In-Reply-To: <20170703081315.GA1115@lynnl.wit>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lynn Lei <lynnl.wit@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 03, 2017 at 04:13:15PM +0800, Lynn Lei wrote:
> fixed a typo issue in get_mxclk_freq().
> 
> the original code using PLL_CTRL_M_SHIFT for shifting to set N flag.
> which is not right, it should be PLL_CTRL_N_SHIFT.
> 
> both PLL_CTRL_M_SHIFT and PLL_CTRL_N_SHIFT
>   defined in drivers/staging/sm750fb/ddk750_reg.h
> 
> Signed-off-by: Lynn Lei <lynnl.wit@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Always put what changed from the previous version here below the ---
line, like the Documentation states to do.

v3 please?

thanks,

greg k-h
