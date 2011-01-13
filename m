From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Jan 2011 04:09:53 +0000
Subject: Re: [PATCH] fbdev: Implement simple blanking in pseudocolor modes for vt8500lcdfb
Message-Id: <20110113040953.GB12013@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110112221443.GA574@alchark-u3s>
In-Reply-To: <20110112221443.GA574@alchark-u3s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Charkov <alchark@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, vt8500-wm8505-linux-kernel@googlegroups.com

On Thu, Jan 13, 2011 at 01:14:44AM +0300, Alexey Charkov wrote:
> Implement simple blanking in pseudocolor modes for vt8500lcdfb
> 
> This follows the style of some other in-tree drivers by just setting
> the hardware palette colors to all black. True Color modes are not
> affected, but this at least allows to run xf86-video-fbdev without
> errors due to blanking being unimplemented.
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> 
Applied, thanks.
