From: Daniel Drake <dsd@laptop.org>
Date: Fri, 21 Jun 2013 17:00:37 +0000
Subject: Re: [V2 2/7] video: mmp: optimize some register setting code
Message-Id: <CAMLZHHQXDq6ZT0N85n1FWE9TkEbgkf6AKtZJZP+5db6k7NQT2A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1370879543-11152-1-git-send-email-jtzhou@marvell.com>
In-Reply-To: <1370879543-11152-1-git-send-email-jtzhou@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 10, 2013 at 9:52 AM, Jett.Zhou <jtzhou@marvell.com> wrote:
> From: Guoqing Li <ligq@marvell.com>
>
> There are dumplicate code of the smooth setting based on different
> path, optimized the routine and use readl_relaxed instead.
>
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> Signed-off-by: Jing Xiang <jxiang@marvell.com>
> Signed-off-by: Guoqing Li <ligq@marvell.com>

Reviewed-by: Daniel Drake <dsd@laptop.org>
