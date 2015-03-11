From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 11 Mar 2015 09:23:27 +0000
Subject: Re: [PATCH 1/6] staging: sm750fb: Use memset_io instead of memset
Message-Id: <20150311092327.GE16501@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426037325-8392-1-git-send-email-lstoakes@gmail.com>
 <20150311085433.GU10964@mwanda>
 <CAA5enKaWynLvLUN+GCdphOOMmqX+cAj3kA3owjKbng66CK=pqg@mail.gmail.com>
In-Reply-To: <CAA5enKaWynLvLUN+GCdphOOMmqX+cAj3kA3owjKbng66CK=pqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 11, 2015 at 09:11:52AM +0000, Lorenzo Stoakes wrote:
> On 11 March 2015 at 08:54, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > When I see a patch like this, then I worry, "What if the Sparse
> > annotations are wrong?  The patch description doesn't say anything about
> > that."  After review then I think the annotations are correct so that's
> > fine.
> 
> How do you mean? I was careful to check what sparse was referring to,
> then investigate how memset should be used with pointers with a
> __iomem qualifier. I'd like to be able to improve my patch
> descriptions going forward as best I can :)
> 

Yes.  The patch is correct.  I wasn't asking you to redo it.  From later
patches it's actually clear that you know that this change is a bugfix
and a behavior change.  But we get a lot of patches where people just
randomly change things to please Sparse and it maybe silences a warning
but it's not correct.  I can think of a few recentish examples where
people used standard struct types which hold __iomem or __user pointers
but they used them in non-standard ways so the pointers were actually
normal kernel pointers.

I guess the rule here is that the patch should explain the effect of the
bugfix for the user.  Often you won't know the effect, but it's a
helpful thing to think about.

> > Btw, do you have this hardware?  Are you able to test these changes?
> 
> Unfortunately not, I am trying to keep these changes as simple code
> fixes that ought not to affect actual hardware behaviour as I can
> (though of course you can never be entirely sure that's the case!)

That's fine.  I was just wondering.  It affects how paranoid I am when I
review the code.

regards,
dan carpenter

