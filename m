From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 04 Aug 2011 08:08:43 +0000
Subject: Re: [PATCH] OMAP: DSS2: Don't allow moving managers away from
Message-Id: <1312445323.2143.8.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1312402251-31588-1-git-send-email-daniel.morsing@gmail.com>
In-Reply-To: <1312402251-31588-1-git-send-email-daniel.morsing@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Morsing <daniel.morsing@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wed, 2011-08-03 at 22:10 +0200, Daniel Morsing wrote:
> If a manager is moved while attached to an enabled display, the DSS
> system will be left in an inconsistent state. This will eventually cause
> a kernel oops when the enabled display is disabled.
> 
> Fix this by not allowing the user to move a manager away from an enabled
> display.

Thanks, applying.

 Tomi


