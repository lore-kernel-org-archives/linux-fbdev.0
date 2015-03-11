From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 11 Mar 2015 14:58:57 +0000
Subject: Re: [PATCH v2 6/6] staging: sm750fb: Remove spinlock helper function
Message-Id: <20150311145841.GA30040@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426070749-32024-1-git-send-email-lstoakes@gmail.com>
 <1426070749-32024-3-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1426070749-32024-3-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Wed, Mar 11, 2015 at 10:45:49AM +0000, Lorenzo Stoakes wrote:
> This patch removes the unnecessary spinlock helper function and instead
> calls spin_lock and spin_unlock directly.
> 
> This does *not* resolve sparse warnings about context imbalances but these are
> spurious.

tested the whole series on hardware, looks ok.

now it depends on Greg if he wants to accept patches with such big
commit logs, and another problem he will face is to get some patches from
this thread and some from the old thread.
(while testing i faced this problem to maintain the sequence of
 patches)

regards
sudip
