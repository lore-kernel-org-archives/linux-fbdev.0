From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 13 Jun 2015 08:58:18 +0000
Subject: doubt about sm7xxfb (was: Re: [PATCH v4 0/7] staging: fsl-mc: New functionality to the MC bus driver
Message-Id: <20150613084618.GA6492@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1433887148-2310-1-git-send-email-German.Rivera@freescale.com>
 <20150613001849.GB5234@kroah.com>
In-Reply-To: <20150613001849.GB5234@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org

On Fri, Jun 12, 2015 at 05:18:49PM -0700, Greg KH wrote:
> On Tue, Jun 09, 2015 at 04:59:01PM -0500, J. German Rivera wrote:
> > This patch series includes new functionality for the Freescale fsl-mc
> > bus driver.
> 
> Why are people working on "new functionality" instead of working on
> getting this out of the staging tree?  I really hate adding new
> functions to staging drivers, as this is not the correct place for
> drivers to be in the tree.  People should be working to get them out of
> this location, and then you can add new functions to them.
Hi Greg,
Your reply above was for a different thread but my doubt started from
this. I was working on adding the Dual-Head support to sm7xxfb. So that
is also a new functionality which is not in the current driver as of now.
Then should i instead concentrate on getting that out of staging? If yes,
can you please have a look (when you are free) at it to see if anything
else needs to be done.

regards
sudip
   
