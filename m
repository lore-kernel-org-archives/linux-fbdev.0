From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Linux-fbdev-devel] [PATCH 6/9] viafb: VIA Frame Buffer Device
 Driver
Date: Wed, 7 May 2008 16:21:18 +0100
Message-ID: <20080507162118.45ba52bb@core>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F67759@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761054AbYEGPbL@vger.kernel.org>
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F67759@exchtp03.taipei.via.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Cc: JosephChan@via.com.tw, akpm@linux-foundation.org, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

> +void delays(int count);
> +void i2cWriteSdaScl(u8 sda, u8 scl);
> +void i2cWriteScl(u8 scl);
> +void i2cReadSdaScl(u8 *pSda, u8 *pScl);

Style is good, code looks clean

One big thing that needs fixing here is the function names. If the driver
gets linked into the kernel then the symbols become global - and names
like enableGPIO are asking for clashes. The viafb code is fine as it uses
viafb_ as the function names. Possibly the helper functions should doo
something similar.

We also have a generic i2c layer that might be usable but that is
something that could be addressed in the future and isn't really an
important detail.

>
