From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 25 Jun 2017 12:43:34 +0000
Subject: Re: [PATCH 1/2] staging: sm750fb: avoid conflicting vesafb
Message-Id: <20170625124334.GA6942@sudip-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1497904378-4808-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1497904378-4808-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, Teddy Wang <teddy.wang@siliconmotion.com>

On Mon, Jun 19, 2017 at 09:32:57PM +0100, Sudip Mukherjee wrote:
> From: Teddy Wang <teddy.wang@siliconmotion.com>
> 
> If vesafb is enabled in the config then /dev/fb0 is created by vesa
> and this sm750 driver gets fb1, fb2. But we need to be fb0 and fb1 to
> effectively work with xorg.
> So if it has been alloted fb1, then try to remove the other fb0.
> 
> Signed-off-by: Teddy Wang <teddy.wang@siliconmotion.com>
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---

Hi Greg,
You applied the second patch but not this one. Did I miss any review
comments from you about this one?

--
Regards
Sudip
