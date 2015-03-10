From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 10 Mar 2015 12:48:33 +0000
Subject: Re: [PATCH] staging: sm750fb: Cleanup the type of mmio750
Message-Id: <20150310123633.GA2782@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425981426-20680-1-git-send-email-lstoakes@gmail.com>
 <20150310114030.GP10964@mwanda>
In-Reply-To: <20150310114030.GP10964@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 10, 2015 at 02:40:30PM +0300, Dan Carpenter wrote:
> On Tue, Mar 10, 2015 at 09:57:06AM +0000, Lorenzo Stoakes wrote:
> > This patch assigns the more appropriate void* type to the mmio750 variable
> > eliminating an unnecessary volatile qualifier in the process. Additionally it
> > updates parameter types as necessary where those parameters interact with
> > mmio750 and removes unnecessary casts.
> > 
> > As a consequence, this patch fixes the following sparse warning:-
> > 
> > drivers/staging/sm750fb/ddk750_help.c:12:17: warning: incorrect type in assignment (different address spaces)
> > 
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> 
> Looks good.  Thanks for doing this.

but it is introducing two new build warnings:

drivers/staging/sm750fb/sm750_hw.c: In function ‘hw_sm750_map’:
drivers/staging/sm750fb/sm750_hw.c:67:2: warning: passing argument 1 of ‘ddk750_set_mmio’ discards ‘volatile’ qualifier from pointer target type [enabled by default]
In file included from drivers/staging/sm750fb/ddk750_mode.h:4:0,
                    from drivers/staging/sm750fb/ddk750.h:15,
                    from drivers/staging/sm750fb/sm750_hw.c:24:

and

drivers/staging/sm750fb/ddk750_chip.h:77:6: note: expected ‘void *’ but argument is of type ‘volatile unsigned char *’

care to make another patch to solve these two new warnings, and send this patch and the new one in a series and while sending mark the version number in the subject.

regards
sudip
> 
> regards,
> dan carpenter
> 
