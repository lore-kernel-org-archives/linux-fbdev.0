From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Jun 2011 08:02:16 +0000
Subject: Re: [PATCH] hecubafb: add module_put on error path in hecubafb_probe()
Message-Id: <20110624080215.GB24184@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308327913-23220-1-git-send-email-shved@ispras.ru> <1308327913-23220-3-git-send-email-shved@ispras.ru>
In-Reply-To: <1308327913-23220-3-git-send-email-shved@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Shved <shved@ispras.ru>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@ispras.ru

On Fri, Jun 17, 2011 at 08:25:12PM +0400, Pavel Shved wrote:
> In hecubafb_probe(), after a successful try_module_get, vzalloc may
> fail and make the hecubafb_probe return, but the module is not put on
> this error path.
> 
> This patch adds an exit point that calls module_put in such situation.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Pavel Shved <shved@ispras.ru>

Applied, thanks.
