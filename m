From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 13 Feb 2013 01:01:55 +0000
Subject: Re: [PATCH RESEND v2 2/2] drivers/video: fsl-diu-fb: fix bugs in interrupt handling
Message-Id: <20130212170155.8b1dc883.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360308959-3096-2-git-send-email-agust@denx.de>
In-Reply-To: <1360308959-3096-2-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, 12 Feb 2013 16:54:58 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> Thanks, I queued both these with a plan to merge into 3.9-rc1.

No I didn't.  The patches have already found their way into linux-next
via some other tree.

Without any -stable tags, either.  You don't think we should fix the
"24 and 16 bpp" thing in 3.8.x and earlier?

