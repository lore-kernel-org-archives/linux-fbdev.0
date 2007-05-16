From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 10/10] [HEADS UP] fbdev: Move arch-specific bits to
 their respective subdirectories
Date: Wed, 16 May 2007 14:53:17 -0700 (PDT)
Message-ID: <20070516.145317.03979683.davem@davemloft.net>
References: <464B78BC.4080900@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934305AbXEPVxU@vger.kernel.org>
In-Reply-To: <464B78BC.4080900@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: Text/Plain; charset="us-ascii"
To: adaplas@gmail.com
Cc: akpm@osdl.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: "Antonino A. Daplas" <adaplas@gmail.com>
Date: Thu, 17 May 2007 05:33:48 +0800

> Move arch-specific bits of fb_mmap() to their respective subdirectories
> 
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>
> ---
> Hi all,
> 
> Please let me know if there are mistakes with this patch.

Thank you for doing this work.

__sparc_v9__ means CONFIG_SPARC64, if that is not defined it's
CONFIG_SPARC32, so you could simplify this patch a lot.

1) Remove __sparc_v9__ ifdefs from asm-sparc64/fb.h
2) Define fb_mmap_required() to return 0 in asm-sparc64/fb.h
3) Define fb_mmap_required() to return 1 in asm-sparc/fb.h
4) Remove all the sparc ifdef stuff you added to linux/fb.h
5) There won't be a default fb_mmap_required() provided by
   linux/fb.h on platforms other than sparc ones, you'll need
   to provide one in order for the build to work non-sparc since
   this call is unconditional in fbmem.c:

+	if (fb_mmap_required())
+		return -EINVAL;

With those fixes:

Signed-off-by: David S. Miller <davem@davemloft.net>
