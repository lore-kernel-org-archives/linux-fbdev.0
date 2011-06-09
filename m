From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 09 Jun 2011 06:04:57 +0000
Subject: Re: [PATCH] [resend] video: s3c-fb: fix misleading kfree in remove function
Message-Id: <20110609060455.GB26006@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307593591-4507-1-git-send-email-jg1.han@samsung.com>
In-Reply-To: <1307593591-4507-1-git-send-email-jg1.han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Jun 09, 2011 at 01:26:31PM +0900, Jingoo Han wrote:
> This patch fixes misleading kfree in remove function.

On Thu, Jun 09, 2011 at 01:26:38PM +0900, Jingoo Han wrote:
> This patch fixes mishandling in virtual resolution checking.
> Previously, virtual resolution is changed to virtual_x and virtual_y
> which mean the size for buffer allocation, when s3c_fb_check_var is
> called by fb_check_var. However, it is meaningless, since virtual_x
> and virtual_y are fixed and user cannot change virtual resolution.
> Therefore, virtual resolution should be more than resolution
> such as xres and yres.

On Thu, Jun 09, 2011 at 01:26:45PM +0900, Jingoo Han wrote:
> This patch moves enabling channel for window, because there should
> be enabling channel before enabling window. If the sequence is
> reversed, it makes the problem in displaying images to lcd panel.

All applied, thanks.
