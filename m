From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 18 Mar 2015 13:18:07 +0000
Subject: Re: [PATCH RESEND 1/5] staging: sm750fb: Use memset_io instead of memset
Message-Id: <20150318130607.GB32758@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426669046-29935-1-git-send-email-lstoakes@gmail.com>
 <87oanqo9zi.fsf@vitty.brq.redhat.com>
 <CAA5enKZYqmysuFqPPptgVvyBJAzX8UYBkod1t3Atvu3Q5TUEjQ@mail.gmail.com>
 <20150318112509.GP10964@mwanda>
In-Reply-To: <20150318112509.GP10964@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org

On Wed, Mar 18, 2015 at 02:25:09PM +0300, Dan Carpenter wrote:
> On Wed, Mar 18, 2015 at 11:12:20AM +0000, Lorenzo Stoakes wrote:
> > On 18 March 2015 at 10:50, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> If it's a white space thing on the same line then it's generally ok to
> fix it.  The "one thing per patch" is meant to make patches easier to
> review.  If it's a trivial thing and it doesn't make it harder to review
> then we are reasonable people.
> 
but Greg K-H has explisitely mentiond not to do so.
I did just that and fixed few whitespace things in the patch to fix the
build failure.

https://lkml.org/lkml/2015/3/10/685

regards
sudip
