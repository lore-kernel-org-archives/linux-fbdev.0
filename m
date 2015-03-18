From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 18 Mar 2015 13:41:41 +0000
Subject: Re: [PATCH RESEND 1/5] staging: sm750fb: Use memset_io instead of memset
Message-Id: <20150318132941.GA1922@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426669046-29935-1-git-send-email-lstoakes@gmail.com>
 <87oanqo9zi.fsf@vitty.brq.redhat.com>
 <CAA5enKZYqmysuFqPPptgVvyBJAzX8UYBkod1t3Atvu3Q5TUEjQ@mail.gmail.com>
 <20150318112509.GP10964@mwanda>
 <20150318130607.GB32758@sudip-PC>
 <20150318132339.GR10964@mwanda>
In-Reply-To: <20150318132339.GR10964@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>

On Wed, Mar 18, 2015 at 04:23:39PM +0300, Dan Carpenter wrote:
> > https://lkml.org/lkml/2015/3/10/685
> > 
> 
> You were making random white space changes and not on the same line.  It
> was hard to review because you had to count how many u32 arguments there
> were (a million) and really look at it to see what the compile warning
> was.  There was no compile warning in the end.  Very annoying.
ok, now understood. Thanks.
like you said once - combining different changes in a single patch is
an art. :)

regards
sudip
> 
> regards,
> dan carpenter
> 
