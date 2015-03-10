From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 10 Mar 2015 15:09:13 +0000
Subject: Re: [PATCH v2] staging: sm750fb: Cleanup the type of mmio750
Message-Id: <20150310150913.GA32763@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425994068-8535-1-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1425994068-8535-1-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 10, 2015 at 01:27:48PM +0000, Lorenzo Stoakes wrote:
> This patch assigns the more appropriate void* type to the mmio750 variable
> eliminating an unnecessary volatile qualifier in the process. Additionally it
> updates parameter types as necessary where those parameters interact with
> mmio750, removes unnecessary casts and updates the type of the
> lynx_share->pvReg field which is passed to the ddk750_set_mmio method.
> 
> As a consequence, this patch fixes the following sparse warning:-
> 
> drivers/staging/sm750fb/ddk750_help.c:12:17: warning: incorrect type in assignment (different address spaces)
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> 
> ---
>  drivers/staging/sm750fb/ddk750_chip.h |  4 +++-
>  drivers/staging/sm750fb/ddk750_help.c |  4 ++--
>  drivers/staging/sm750fb/ddk750_help.h | 10 +++++-----
>  drivers/staging/sm750fb/sm750.h       |  2 +-
>  4 files changed, 11 insertions(+), 9 deletions(-)

This doesn't apply either anymore, for the same reason :(
