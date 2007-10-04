From: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: [PATCH 2/6] Xilinxfb: Replace calls to printk with dev_dbg, dev_err,
 etc.
Date: Thu, 04 Oct 2007 16:06:15 +0400
Message-ID: <4704D737.4010003@ru.mvista.com>
References: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net> <20071001155738.6114.51384.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757021AbXJDMBo@vger.kernel.org>
In-Reply-To: <20071001155738.6114.51384.stgit@trillian.cg.shawcable.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, linuxppc@ozlabs.org, adaplas@gmail.com

Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> The dev_dbg, dev_err, etc functions provide more context that plain
> vanilla printk which is useful for debugging.  Where appropriate,
> change printk calls to the appropriate dev_*() call.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---

Acked-by: Andrei Konovalov <akonovalov@ru.mvista.com>

>  drivers/video/xilinxfb.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
