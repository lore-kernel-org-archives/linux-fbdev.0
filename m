From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 10 Mar 2015 11:40:30 +0000
Subject: Re: [PATCH] staging: sm750fb: Cleanup the type of mmio750
Message-Id: <20150310114030.GP10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425981426-20680-1-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1425981426-20680-1-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 10, 2015 at 09:57:06AM +0000, Lorenzo Stoakes wrote:
> This patch assigns the more appropriate void* type to the mmio750 variable
> eliminating an unnecessary volatile qualifier in the process. Additionally it
> updates parameter types as necessary where those parameters interact with
> mmio750 and removes unnecessary casts.
> 
> As a consequence, this patch fixes the following sparse warning:-
> 
> drivers/staging/sm750fb/ddk750_help.c:12:17: warning: incorrect type in assignment (different address spaces)
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Looks good.  Thanks for doing this.

regards,
dan carpenter

