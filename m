From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 11 Mar 2015 07:43:09 +0000
Subject: Re: [PATCH 4/6] staging: sm750fb: correct incompatible pointer type
Message-Id: <20150311074309.GA5689@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426007817-1884-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1426007817-1884-5-git-send-email-sudipm.mukherjee@gmail.com>
 <20150310201100.GA17629@kroah.com>
 <20150310201754.GA8122@kroah.com>
 <20150311072842.GA3550@sudip-PC>
In-Reply-To: <20150311072842.GA3550@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 11, 2015 at 12:58:42PM +0530, Sudip Mukherjee wrote:
> On Tue, Mar 10, 2015 at 09:17:54PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Mar 10, 2015 at 09:11:00PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Mar 10, 2015 at 10:46:55PM +0530, Sudip Mukherjee wrote:
> > > > we were getting build warnings about assignment of incompatible
> <snip>
> > > 
> > > That's a nice cleanup, but it's not even the correct cleanup.
> > 
> > Oops, sorry, it is the correct cleanup, I was looking at the '*'
> > placement, not the const part.
> > 
> > but the patch needs to be redone, I'll just go fix up the build warnings
> > for now...
> 
> thanks Greg for your patience and time to redo this patch. I saw you
> broke it into two - three different patches.
> But just one doubt, was your compiler showing any warning for the
> patch - "Staging: sm750fb: provide error path for
>  hw_sm750le_setBLANK()" , commit id -
>  e74ac550298ec4635cc32e99f966568a808fd370 . my compiler didnot show
>  any warning for that.
> mine is gcc 4.7.3, is it time to update?

Yes it is, that's a really old version of gcc.  Also please wrap your
email lines at 72 columns :)

> thanks again, and sorry that you had to do fix this. I should have
> made the patches in a more proper way.

Not a problem, it's part of the learning process.

greg k-h
