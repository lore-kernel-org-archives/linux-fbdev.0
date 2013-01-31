From: Russell King <rmk@arm.linux.org.uk>
Date: Thu, 31 Jan 2013 13:07:23 +0000
Subject: Re: BUG: circular locking dependency detected
Message-Id: <20130131130723.GB32558@flint.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAKMK7uHEggaGfLTq4c3MfY7csQSFpb=kRwdbJUQMN9Cz9K=V4A@mail.gmail.com> <20130130221946.GA14801@flint.arm.linux.org.uk> <CA+55aFyRHK3dmwQf_mdfB18dmoaRZqBG9FvHRqTs7cqBjgUs+g@mail.gmail.com> <CAPM=9tz6YBh2o3T8Ogt4K=wxSrC3Jc4PCJMzfpbyY=B132fA5g@mail.gmail.com> <20130131001339.GC14801@flint.arm.linux.org.uk> <CA+55aFxfeXWAiXV18qGgOk9+2HHiD7LUuyk55brHFXd+_c6eZQ@mail.gmail.com> <20130131054002.GA3697@kroah.com> <CAKMK7uGUrvh2dXza_b288kVdztiLjSCNpH304oBQgg_ZonEnzw@mail.gmail.com> <20130131092146.GB3361@kroah.com> <CAPM=9tzZLPZ0EqEvEuZbimomSQv+xMnLpTq28z7=bKBF1w26TQ@mail.gmail.com>
In-Reply-To: <CAPM=9tzZLPZ0EqEvEuZbimomSQv+xMnLpTq28z7=bKBF1w26TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>

On Thu, Jan 31, 2013 at 10:51:27PM +1100, Dave Airlie wrote:
> I'll ship them via my tree at this point I think, since I now need to
> queue a revert of the revert on top.
> 
> I have a few vgacon/fbcon fixes that I need to go in this cycle.

Great, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
