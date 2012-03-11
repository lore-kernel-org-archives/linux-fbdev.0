From: richard -rw- weinberger <richard.weinberger@gmail.com>
Date: Sun, 11 Mar 2012 13:22:57 +0000
Subject: Re: [PATCH] Video : Amba: Use in_interrupt() in clcdfb_sleep().
Message-Id: <CAFLxGvygW=DeSQbRq8Wbcdy5E3e4vYcN666_9oWgnuwzT1WKqw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331471665-22226-1-git-send-email-santoshprasadnayak@gmail.com>
In-Reply-To: <1331471665-22226-1-git-send-email-santoshprasadnayak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: santosh nayak <santoshprasadnayak@gmail.com>
Cc: linux@arm.linux.org.uk, FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sun, Mar 11, 2012 at 2:14 PM, santosh nayak
<santoshprasadnayak@gmail.com> wrote:
> From: Santosh Nayak <santoshprasadnayak@gmail.com>
>
> Instead of "in_atomic()", we can use in_interrupt() to check whether
> its an interrupt context.

What is the benefit?

Your change turns clcdfb_sleep() into a ticking bomb.
If clcdfb_sleep() is called from an atomic section (e.g. under a
spinlock) it will call msleep()
and the whole thing explodes...

-- 
Thanks,
//richard
