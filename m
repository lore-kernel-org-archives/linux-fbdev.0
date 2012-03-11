From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sun, 11 Mar 2012 13:27:46 +0000
Subject: Re: [PATCH] Video : Amba: Use in_interrupt() in clcdfb_sleep().
Message-Id: <20120311132746.GA13336@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331471665-22226-1-git-send-email-santoshprasadnayak@gmail.com>
In-Reply-To: <1331471665-22226-1-git-send-email-santoshprasadnayak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: santosh nayak <santoshprasadnayak@gmail.com>
Cc: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sun, Mar 11, 2012 at 06:44:25PM +0530, santosh nayak wrote:
> From: Santosh Nayak <santoshprasadnayak@gmail.com>
> 
> Instead of "in_atomic()", we can use in_interrupt() to check whether
> its an interrupt context.

What are you trying to fix?

Your description is an example of a bad commit comment.  It merely
describes the change, which anyone can see by looking at the diff.
What it totally and utterly fails to do is to describe _why_ the
change is necessary or what the problem is.

So, until it does, this patch gets a definite NAK.
