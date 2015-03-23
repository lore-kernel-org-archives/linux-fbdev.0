From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 23 Mar 2015 13:55:25 +0000
Subject: Re: [PATCH RESEND 2 1/5] staging: sm750fb: Use memset_io instead of memset
Message-Id: <20150323135516.GB27897@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426864935-29350-1-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1426864935-29350-1-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Fri, Mar 20, 2015 at 03:22:11PM +0000, Lorenzo Stoakes wrote:
> This patch takes into account that cursor->vstart, crtc->vScreen and
> share->pvMem are pointers to memory-mapped I/O and thus we should use memset_io
> to make this explicit. In addition, some architectures require special treatment
> of memory-mapped I/O so the previous code could actually break without this
> change.
sorry for the confusion.
tested the whole series on hardware.

Tested-by: Sudip Mukherjee <sudip@vectorindia.org>

sudip

