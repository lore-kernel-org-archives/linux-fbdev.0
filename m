From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 15 Mar 2013 18:13:51 +0000
Subject: Re: [PATCH v2 8/8] drivers: misc: use module_platform_driver_probe()
Message-Id: <20130315181351.GA16747@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363280978-24051-1-git-send-email-fabio.porcedda@gmail.com>
 <1363280978-24051-9-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1363280978-24051-9-git-send-email-fabio.porcedda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Mar 14, 2013 at 06:09:38PM +0100, Fabio Porcedda wrote:
> This patch converts the drivers to use the
> module_platform_driver_probe() macro which makes the code smaller and
> a bit simpler.

Someone else beat you to this fix for these files, sorry.

greg k-h
