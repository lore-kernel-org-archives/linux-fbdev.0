From: Greg KH <gregkh@linuxfoundation.org>
Date: Fri, 20 Mar 2015 13:03:29 +0000
Subject: Re: [PATCH RESEND v2 4/5] staging: sm750fb: Fix __iomem pointer types
Message-Id: <20150320130329.GA23287@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426705493-26615-1-git-send-email-lstoakes@gmail.com>
 <1426705493-26615-2-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1426705493-26615-2-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 18, 2015 at 07:04:53PM +0000, Lorenzo Stoakes wrote:
> This patch annotates pointers as referring to I/O mapped memory where they ought
> to be, removes now unnecessary ugly casts, eliminates an incorrect deref on I/O
> mapped memory by using iowrite16 instead, and updates the pointer arithmetic
> accordingly to take into account that the pointers are now byte-sized. This
> fixes the following sparse warnings:-
> 
> drivers/staging/sm750fb/sm750_cursor.c:113:19: warning: cast removes address space of expression
> drivers/staging/sm750fb/sm750_cursor.c:204:19: warning: cast removes address space of expression
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
> v2: Whitespace fixups
> 
>  drivers/staging/sm750fb/sm750_cursor.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

I only see 2 patches in this "series", yet you refer to 5?  Please
resend the whole series, I dropped your previous ones from my queue.

thanks,

greg k-h
