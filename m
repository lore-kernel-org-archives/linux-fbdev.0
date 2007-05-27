From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 7/9] [TRY 2] fbdev: Move arch-specific bits to their
 respective subdirectories
Date: Sun, 27 May 2007 15:44:54 -0700 (PDT)
Message-ID: <20070527.154454.51856593.davem@davemloft.net>
References: <4659530E.40102@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759756AbXE0Wo5@vger.kernel.org>
In-Reply-To: <4659530E.40102@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: Text/Plain; charset="us-ascii"
To: adaplas@gmail.com
Cc: akpm@osdl.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: "Antonino A. Daplas" <adaplas@gmail.com>
Date: Sun, 27 May 2007 17:44:46 +0800

> Move arch-specific bits of fb_mmap() to their respective subdirectories
> 
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>

The sparc and sparc64 bits look good.

Acked-by: David S. Miller <davem@davemloft.net>
