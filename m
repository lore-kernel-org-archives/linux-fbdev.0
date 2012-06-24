From: Emil Goode <emilgoode@gmail.com>
Date: Sun, 24 Jun 2012 09:42:27 +0000
Subject: Re: [PATCH] grvga: Fix error handling issues
Message-Id: <1340530947.4696.3.camel@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340381479-6371-1-git-send-email-emilgoode@gmail.com>
	 <20120623223319.GG5333@mwanda>
In-Reply-To: <20120623223319.GG5333@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

This code is for the sparc architecture and the iounmap doesn't check
for NULL directly as in the x86 version. I think it is safer not to pass
NULL to the sparc version.

Thanks,

Emil
On Sun, 2012-06-24 at 01:33 +0300, Dan Carpenter wrote:
> On Fri, Jun 22, 2012 at 06:11:19PM +0200, Emil Goode wrote:
> > This patch fixes two problems with the error handling in the
> > grvga_probe function.
> > 
> > - If the call to grvga_parse_custom on line 370 fails we use
> >   the wrong label so that release_mem_region will be called
> >   without a call to request_mem_region being made.
> > 
> > - If the call to ioremap on line 436 fails we should not try
> >   to call iounmap. I added an if statement to check whether or
> >   not a call to iounmap should be made.
> > 
> 
> Doesn't iounmap() have a check for NULL?  On x86 it does.
> 
> 	if ((void __force *)addr <= high_memory)
> 		return;
> 
> regards,
> dan carpenter
> 
> 


