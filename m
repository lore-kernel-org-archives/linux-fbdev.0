From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 16 Nov 2010 01:13:24 +0000
Subject: Re: [PATCH] fbdev: da8xx: punt duplicated FBIO_WAITFORVSYNC define
Message-Id: <20101116011324.GA28879@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289815393-32429-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1289815393-32429-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Nov 15, 2010 at 05:03:13AM -0500, Mike Frysinger wrote:
> This is already defined by linux/fb.h now, so punt the duplicate
> definition from the driver header.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Applied, thanks.
