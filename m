From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] fbdev: Add support for AVR32
Date: Mon, 07 May 2007 13:47:26 -0700 (PDT)
Message-ID: <20070507.134726.21927689.davem@davemloft.net>
References: <11785512332033-git-send-email-hskinnemoen@atmel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966801AbXEGUr2@vger.kernel.org>
In-Reply-To: <11785512332033-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: Text/Plain; charset="us-ascii"
To: hskinnemoen@atmel.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Mon,  7 May 2007 17:20:33 +0200

> Provide framebuffer page protection flags and definitions of
> fb_readl/fb_writel for AVR32.
> 
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

This isn't directed to you specifically, I'm just making a general
comment.

We're at the point where these two snippets of code in the fb layer
are a total mess of ifdefs.

It's time we made an include/asm-foo/fb.h header file and abstracted
out the necessary details there.
