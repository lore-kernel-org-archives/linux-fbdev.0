From: H Hartley Sweeten <hartleys@visionengravers.com>
Date: Wed, 18 Apr 2012 20:35:41 +0000
Subject: RE: [PATCH] drivers/video/ep93xx-fb.c: clean up error-handling code
Message-Id: <ADE657CA350FB648AAC2C43247A983F00206987A438B@AUSP01VMBX24.collaborationhost.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334777828-3557-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1334777828-3557-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@lip6.fr>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wednesday, April 18, 2012 12:37 PM, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
>
> There were two problems in this code: failure of the setup function should
> free locally allocated resources like other nearby failures, and the test
> if (&info->cmap) can never be false.  To generally clean things up, this
> patch reorders the error handling code at the failed label and adds labels
> so that the conditionals are not necessary.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>

Thanks!

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

