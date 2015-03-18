From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 18 Mar 2015 13:23:39 +0000
Subject: Re: [PATCH RESEND 1/5] staging: sm750fb: Use memset_io instead of memset
Message-Id: <20150318132339.GR10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426669046-29935-1-git-send-email-lstoakes@gmail.com>
 <87oanqo9zi.fsf@vitty.brq.redhat.com>
 <CAA5enKZYqmysuFqPPptgVvyBJAzX8UYBkod1t3Atvu3Q5TUEjQ@mail.gmail.com>
 <20150318112509.GP10964@mwanda>
 <20150318130607.GB32758@sudip-PC>
In-Reply-To: <20150318130607.GB32758@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>

On Wed, Mar 18, 2015 at 06:36:07PM +0530, Sudip Mukherjee wrote:
> On Wed, Mar 18, 2015 at 02:25:09PM +0300, Dan Carpenter wrote:
> > On Wed, Mar 18, 2015 at 11:12:20AM +0000, Lorenzo Stoakes wrote:
> > > On 18 March 2015 at 10:50, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> > If it's a white space thing on the same line then it's generally ok to
> > fix it.  The "one thing per patch" is meant to make patches easier to
> > review.  If it's a trivial thing and it doesn't make it harder to review
> > then we are reasonable people.
> > 
> but Greg K-H has explisitely mentiond not to do so.
> I did just that and fixed few whitespace things in the patch to fix the
> build failure.
> 
> https://lkml.org/lkml/2015/3/10/685
> 

You were making random white space changes and not on the same line.  It
was hard to review because you had to count how many u32 arguments there
were (a million) and really look at it to see what the compile warning
was.  There was no compile warning in the end.  Very annoying.

regards,
dan carpenter

