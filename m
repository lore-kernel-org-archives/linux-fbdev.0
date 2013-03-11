From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Mar 2013 15:29:03 +0000
Subject: Re: [PATCH linux-next] mfd: max8925: max8925_backlight_probe: Silence 'statement with no effect' war
Message-Id: <201303111529.03872.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362939145-88329-1-git-send-email-tim.gardner@canonical.com>
In-Reply-To: <1362939145-88329-1-git-send-email-tim.gardner@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tim Gardner <tim.gardner@canonical.com>
Cc: linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

On Sunday 10 March 2013, Tim Gardner wrote:
> drivers/video/backlight/max8925_bl.c: In function 'max8925_backlight_probe':
> drivers/video/backlight/max8925_bl.c:177:3: warning: statement with no effect [-Wunused-value]
> 
> gcc version 4.6.3
> 
> Convert max8925_backlight_dt_init() to an 'inline void' since it is only
> called from one place where the return code is ignored. Protect the
> guts of the function with '#ifdef CONFIG_OF'.
> 
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
> ---
>  drivers/video/backlight/max8925_bl.c |    9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

I had already sent a better patch for this earlier, see "mfd: max8925:
fix trivial build warning for non-dt". Unfortunately when I looked into
the problem again, I found more problems with the original patches,
apparently the DT bindings were never properly reviewed. It may be
better to revert the original patch for 3.9 and do it better for 3.10.

	Arnd
