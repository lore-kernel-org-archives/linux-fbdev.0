From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 10 Mar 2015 08:59:15 +0000
Subject: Re: [PATCH] staging: sm750fb: Fix sparse warning
Message-Id: <20150310085915.GB16501@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425934628-3717-1-git-send-email-lstoakes@gmail.com>
 <20150310070014.GM10964@mwanda>
 <CAA5enKa5x5R2Z9+Sc4UzKFu+N9rKoh_sW7hfVN8CmmqhF9LMiw@mail.gmail.com>
In-Reply-To: <CAA5enKa5x5R2Z9+Sc4UzKFu+N9rKoh_sW7hfVN8CmmqhF9LMiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 10, 2015 at 08:47:47AM +0000, Lorenzo Stoakes wrote:
> On 10 March 2015 at 07:00, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > No need for the volatile.
> 
> Will remove.
> 
> > Really mmio750 should be a "void __iomem *"
> > it is declared as "unsigned char __iomem *" but it's not a char pointer
> > that's only to make the pointer math work.  It would work just as well
> > as a void and we could remove some ugly casting.
> 
> I'm thinking the change to "void __iomem *" from "unsigned char
> __iomem *" ought to be a separate patch in order to keep this cleanly
> focused on solving the sparse warning? Am more than happy to do this
> and make the appropriate changes to the macros in ddk750_help.h.
> 

The patch is:

[patch] cleanup the type of mmio750

silencing a Sparse warning is just a side benifit of using correct
data types.  The "one thing per patch" rule also means that you should
fix a whole problem instead of half a thing per patch.

regards,
dan carpenter

