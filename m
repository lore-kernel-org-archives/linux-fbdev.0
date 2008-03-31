From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/7] lxfb: add power management
	functionality
Date: Mon, 31 Mar 2008 09:40:03 +0200
Message-ID: <20080331074002.GB5106@ucw.cz>
References: <20080327201050.34a8ffdd@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JgEcx-0001xI-6Y for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Mar 2008 00:40:23 -0700
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=spitz.ucw.cz)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JgEct-0003Mi-9V
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Mar 2008 00:40:23 -0700
Content-Disposition: inline
In-Reply-To: <20080327201050.34a8ffdd@ephemeral>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andres Salomon <dilinger@queued.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org, info-linux@geode.amd.com, jordan.crouse@amd.com, Andrew Morton <akpm@linux-foundation.org>

Hi!

> +static int lxfb_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +	struct fb_info *info = pci_get_drvdata(pdev);
> +
> +	if (pdev->dev.power.power_state.event == state.event)
> +		return 0;

This should never trigger. See Doc*/feature-removal-sch*.


> +	/* there's no point in setting PCI states; we emulate PCI, so
> +	 * we don't end up getting power savings anyways */
> +
> +	pdev->dev.power.power_state = state;


And there's no point doing this.

> +	pdev->dev.power.power_state = PMSG_ON;

Or this.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
