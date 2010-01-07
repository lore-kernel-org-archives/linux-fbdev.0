From: Dave Airlie <airlied@redhat.com>
Date: Thu, 07 Jan 2010 23:15:16 +0000
Subject: Re: [PATCH] x86: allow fbdev primary video code on 64-bit.
Message-Id: <1262906116.25818.19.camel@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1262847894-27498-1-git-send-email-airlied@gmail.com>
	 <4B4668F7.1000304@zytor.com>
In-Reply-To: <4B4668F7.1000304@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Airlie <airlied@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2010-01-07 at 15:06 -0800, H. Peter Anvin wrote:
> On 01/06/2010 11:04 PM, Dave Airlie wrote:
> > From: Dave Airlie <airlied@redhat.com>
> > 
> > For some reason the 64-bit tree was doing this differently and
> > I can't see why it would need to.
> > 
> > This correct behaviour when you have two GPUs plugged in and
> > 32-bit put the console in one place and 64-bit in another.
> > 
> > Signed-off-by: Dave Airlie <airlied@redhat.com>
> 
> Looks good... I presume this is for .34, though?

I don't mind, I'll be putting it into Fedora kernel anyways
since its a real bug when the console turns up different on
the same machine with 32 vs 64-bit kernels.

I can't see it having any side effects, not many ppl
run two fbs on x86 anyways yet.

Dave.


