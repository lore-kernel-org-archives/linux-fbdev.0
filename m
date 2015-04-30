From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Thu, 30 Apr 2015 06:20:22 +0000
Subject: Re: [PATCH V3] staging: sm750: Fix lynxfb_ops_imageblit() if image->depth != 1
Message-Id: <20150430060743.GA3030@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430273686-21682-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1430273686-21682-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Apr 29, 2015 at 10:14:46AM +0800, Huacai Chen wrote:
> If image->depth != 1, lynxfb_ops_imageblit() should fallback to call
> cfb_imageblit(), not return directly. Otherwise it can't display the
> boot logo.
> 
> Cc: Teddy Wang <teddy.wang@siliconmotion.com>
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
Thanks Huacai.

Acked-by: Sudip Mukherhee <sudip@vectorindia.org>
