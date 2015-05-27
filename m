From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 27 May 2015 06:41:21 +0000
Subject: Re: [PATCH] staging: sm750fb: remove duplicate from fb_videomode
Message-Id: <20150527062921.GB22910@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150526152239.GA21887@x230-arch.club.entropia.de>
In-Reply-To: <20150526152239.GA21887@x230-arch.club.entropia.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, May 26, 2015 at 05:22:39PM +0200, Michel von Czettritz wrote:
> As suggested by Sudip this patch removes the redundant 1360x768@60
> option from the fb_videomode struct array.
this can be in the comments but should not be there in the commit message.

regards
sudip

> The removed option and the option one it differ in a typo and a flag.

