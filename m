From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 08 May 2015 09:55:54 +0000
Subject: Re: [PATCH V3 RESEND] staging: sm750: Fix lynxfb_ops_imageblit() if image->depth != 1
Message-Id: <20150508094354.GA9253@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1431075868-15746-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1431075868-15746-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, May 08, 2015 at 05:04:28PM +0800, Huacai Chen wrote:
> If image->depth != 1, lynxfb_ops_imageblit() should fallback to call
> cfb_imageblit(), not return directly. Otherwise it can't display the
> boot logo.

why resending? 

regards
sudip
