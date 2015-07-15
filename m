From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2015 01:30:51 +0000
Subject: Re: [PATCH v4 01/19] staging: sm750fb: use tabs for indentation
Message-Id: <20150715013051.GA15700@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F-+fT0iRmFd+H_X-1gBmvCsgehxXeyr7A8Zk9TtfD0aBA@mail.gmail.com>
 <1435600536-13135-1-git-send-email-juston.h.li@gmail.com>
In-Reply-To: <1435600536-13135-1-git-send-email-juston.h.li@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Juston Li <juston.h.li@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com

On Mon, Jun 29, 2015 at 10:55:18AM -0700, Juston Li wrote:
> Replace spaces with tabs for indentation to fix the checkpatch.pl error
> ERROR: code indent should use tabs where possible
> WARNING: please, no spaces at the start of a line

Due to other patches that came in before yours, that are now in my tree,
this patch doesn't apply.  Can you please rebase it against my
staging-testing branch of staging.git and resend?

thanks,

greg k-h
