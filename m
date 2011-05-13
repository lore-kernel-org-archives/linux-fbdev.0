From: Anatolij Gustschin <agust@denx.de>
Date: Fri, 13 May 2011 16:07:28 +0000
Subject: Re: [PATCH] video: mb862xxfb: Require either FB_MB862XX_PCI_GDC or
Message-Id: <20110513180728.02b62792@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1305204137.4065.394.camel@localhost>
In-Reply-To: <1305204137.4065.394.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 12 May 2011 13:42:17 +0100
Ben Hutchings <ben@decadent.org.uk> wrote:

> The driver can be built as either a PCI or platform (OF) driver.  It
> might make sense to built it as both (though that is not currently
> possible) but it certainly doesn't make sense to build it as neither!
> Add dependencies and add a choice group to ensure that exactly one of
> FB_MB862XX_PCI_GDC and FB_MB862XX_LIME is selected.
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Acked-by: Anatolij Gustschin <agust@denx.de>

