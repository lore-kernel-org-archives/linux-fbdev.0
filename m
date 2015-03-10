From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Tue, 10 Mar 2015 08:47:47 +0000
Subject: Re: [PATCH] staging: sm750fb: Fix sparse warning
Message-Id: <CAA5enKa5x5R2Z9+Sc4UzKFu+N9rKoh_sW7hfVN8CmmqhF9LMiw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425934628-3717-1-git-send-email-lstoakes@gmail.com>
	<20150310070014.GM10964@mwanda>
In-Reply-To: <20150310070014.GM10964@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 10 March 2015 at 07:00, Dan Carpenter <dan.carpenter@oracle.com> wrote:

> No need for the volatile.

Will remove.

> Really mmio750 should be a "void __iomem *"
> it is declared as "unsigned char __iomem *" but it's not a char pointer
> that's only to make the pointer math work.  It would work just as well
> as a void and we could remove some ugly casting.

I'm thinking the change to "void __iomem *" from "unsigned char
__iomem *" ought to be a separate patch in order to keep this cleanly
focused on solving the sparse warning? Am more than happy to do this
and make the appropriate changes to the macros in ddk750_help.h.

-- 
Lorenzo Stoakes
https:/ljs.io
