From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 19 Nov 2010 07:57:44 +0000
Subject: Re: [PATCH v2] fbdev: modedb: fix CEA modes
Message-Id: <20101119075743.GB28165@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1290073542-943-1-git-send-email-arnd@arndnet.de>
In-Reply-To: <1290073542-943-1-git-send-email-arnd@arndnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Nov 18, 2010 at 03:14:44PM +0100, Guennadi Liakhovetski wrote:
> On Thu, 18 Nov 2010, Arnd Hannemann wrote:
> 
> > Some of the modes were missing the correct sync polarities.
> > This was causing a corrupt or left shifted picture on my TV.
> > Additionally format #35 had a wrong refresh rate and pixel clock.
> > 
> > This patch fixes those issues.
> > 
> > Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
> 
> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
Applied, thanks.
