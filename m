From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev: Add support for AVR32
Date: Tue, 08 May 2007 06:55:52 +0800
Message-ID: <1178578552.4674.33.camel@daplas>
References: <11785512332033-git-send-email-hskinnemoen@atmel.com>
	 <20070507.134726.21927689.davem@davemloft.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755172AbXEGW4G@vger.kernel.org>
In-Reply-To: <20070507.134726.21927689.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: hskinnemoen@atmel.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Mon, 2007-05-07 at 13:47 -0700, David Miller wrote:
> From: Haavard Skinnemoen <hskinnemoen@atmel.com>
> Date: Mon,  7 May 2007 17:20:33 +0200
> 

> We're at the point where these two snippets of code in the fb layer
> are a total mess of ifdefs.
> 
> It's time we made an include/asm-foo/fb.h header file and abstracted
> out the necessary details there.
> 

I agree. I'll start working on this.

Tony
