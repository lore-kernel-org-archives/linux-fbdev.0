From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 18 Nov 2010 06:05:06 +0000
Subject: Re: [PATCH] fbdev: modedb: fix CEA modes
Message-Id: <20101118060506.GE12227@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1290027979-23272-1-git-send-email-arnd@arndnet.de>
In-Reply-To: <1290027979-23272-1-git-send-email-arnd@arndnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Nov 17, 2010 at 10:06:19PM +0100, Arnd Hannemann wrote:
> Some of the modes were missing the correct sync polarities.
> This was causing a corrupt or left shifted picture on my TV.
> Additionally format #35 had a wrong refresh rate and pixel clock.
> 
> This patch fixes those issues.
> 
> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>

Looks ok to me, Guennadi?
