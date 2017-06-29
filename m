From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 29 Jun 2017 12:57:39 +0000
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH 1/2] staging: sm750fb: avoid conflicting vesafb
Message-Id: <20170629125739.GA31064@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1497904378-4808-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20170625124334.GA6942@sudip-laptop>
 <20170625125451.GB2728@kroah.com>
 <20170625135429.GA8651@sudip-laptop>
 <20170625142723.GA11105@kroah.com>
 <20170625150739.GA9422@sudip-laptop>
 <31608A86C142F84E93092EC1B170B676743012DD@TWMBS01.tw.smi.ad>
In-Reply-To: <31608A86C142F84E93092EC1B170B676743012DD@TWMBS01.tw.smi.ad>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Teddy Wang =?utf-8?B?546L5Yqb5by6?= <teddy.wang@siliconmotion.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>


A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Jun 28, 2017 at 06:18:57AM +0000, Teddy Wang 王力强 wrote:
> Hi Greg,
> 
> 	Is the reason Sudip gave you for the question of "why" sufficient ?
> This patch is very important for the driver running in the X86 platform.  Without this patch, many SM750 graphic chip customers complain  the Ubuntu OS can't run well. When they install the OS, the screen will be full of garbage in xorg.
> Ubuntu 16.04.2 LTS and above will enable sm750 staging driver by default.  We need this patch. Thanks.

This patch is long-gone from my queue, it needs to be resent with the
added information for me to be able to accept it.

thanks,

greg k-h
