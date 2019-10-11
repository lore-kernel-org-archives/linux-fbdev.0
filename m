From: Yizhuo Zhai <yzhai003@ucr.edu>
Date: Fri, 11 Oct 2019 00:37:56 +0000
Subject: Re: [PATCH] staging: sm750fb: Potential uninitialized field in "pll"
Message-Id: <CABvMjLQ+_rRJT_yeKE9AKJaxhSU5LbcZdenbOr8CdPoD+4Oprw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191010043809.27594-1-yzhai003@ucr.edu>
 <20191010091834.GG20470@kadam>
In-Reply-To: <20191010091834.GG20470@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Sorry about that, let me resend it .

On Thu, Oct 10, 2019 at 2:53 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Oct 09, 2019 at 09:38:08PM -0700, Yizhuo wrote:
> > Inside function set_chip_clock(), struct pll is supposed to be
> > initialized in sm750_calc_pll_value(), if condition
> > "diff < mini_diff" in sm750_calc_pll_value() cannot be fulfilled,
> > then some field of pll will not be initialized but used in
> > function sm750_format_pll_reg(), which is potentially unsafe.
> >
> > Signed-off-by: Yizhuo <yzhai003@ucr.edu>
>
> The patch is correct, but it doesn't apply to linux-next any more.  Can
> you re-write it on top of the most recent staging-next and resend?
>
> regards,
> dan carpenter
>


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
