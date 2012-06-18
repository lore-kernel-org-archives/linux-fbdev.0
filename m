From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Jun 2012 02:14:53 +0000
Subject: Re: [PATCH 4/6] pwm_backlight: Add deferred probe support
Message-Id: <20120618021453.GD17850@verge.net.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1339773427-29508-5-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1339773427-29508-5-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Jun 15, 2012 at 05:17:05PM +0200, Laurent Pinchart wrote:
> If the PWM instance is not available yet at probe time, request a
> deferred probe.
> 
> A better way to fix might be to create a PWM subsystem (possible
> integrated into the GPIO subsystem) to support generic PWM objects, and
> make sure the subsystem gets initialized first.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: linux-fbdev@vger.kernel.org

Tested-by: Simon Horman <horms@verge.net.au>

