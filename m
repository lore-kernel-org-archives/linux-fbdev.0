From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 18 Mar 2015 11:25:09 +0000
Subject: Re: [PATCH RESEND 1/5] staging: sm750fb: Use memset_io instead of memset
Message-Id: <20150318112509.GP10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426669046-29935-1-git-send-email-lstoakes@gmail.com>
 <87oanqo9zi.fsf@vitty.brq.redhat.com>
 <CAA5enKZYqmysuFqPPptgVvyBJAzX8UYBkod1t3Atvu3Q5TUEjQ@mail.gmail.com>
In-Reply-To: <CAA5enKZYqmysuFqPPptgVvyBJAzX8UYBkod1t3Atvu3Q5TUEjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

On Wed, Mar 18, 2015 at 11:12:20AM +0000, Lorenzo Stoakes wrote:
> On 18 March 2015 at 10:50, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> > ERROR is reported by scripts/checkpatch.pl (spaces are missing after
> > ','). This coding style problem was there before your patch but I don't
> > think it makes sense to preserve it.
> 
> [snip]
> 
> > WARNING: please, no spaces at the start of a line
> > #137: FILE: drivers/staging/sm750fb/sm750.c:833:
> 
> [snip]
> 
> Hi Vitaly, these style issues have vexed me and I was not sure whether
> to make changes or preserve all the obvious errors so as not to blend
> the two changes inappropriately, however it does indeed make sense to
> fix these on the lines I'm changing, will fix these!

If it's a white space thing on the same line then it's generally ok to
fix it.  The "one thing per patch" is meant to make patches easier to
review.  If it's a trivial thing and it doesn't make it harder to review
then we are reasonable people.

Could you read your patches again and find other similar white space
issues.

+       void __iomem * pbuffer,*pstart;

Should be:

+	void __iomem *pbuffer, *pstart;

regards,
dan carpenter

