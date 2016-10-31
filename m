From: David Miller <davem@davemloft.net>
Date: Mon, 31 Oct 2016 17:08:31 +0000
Subject: Re: [PATCH 00/12] xen: add common function for reading optional value
Message-Id: <20161031.130831.2006896157400677867.davem@davemloft.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1477932510-28594-1-git-send-email-jgross@suse.com>
In-Reply-To: <1477932510-28594-1-git-send-email-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jgross@suse.com
Cc: linux-fbdev@vger.kernel.org, wei.liu2@citrix.com, linux-pci@vger.kernel.org, netdev@vger.kernel.org, tomi.valkeinen@ti.com, dmitry.torokhov@gmail.com, tpmdd@selhorst.net, linux-kernel@vger.kernel.org, jarkko.sakkinen@linux.intel.com, xen-devel@lists.xen.org, jgunthorpe@obsidianresearch.com, tpmdd-devel@lists.sourceforge.net, david.vrabel@citrix.com, linux-input@vger.kernel.org, bhelgaas@google.com, boris.ostrovsky@oracle.com, peterhuewe@gmx.de, paul.durrant@citrix.com, roger.pau@citrix.com

From: Juergen Gross <jgross@suse.com>
Date: Mon, 31 Oct 2016 17:48:18 +0100

> There are multiple instances of code reading an optional unsigned
> parameter from Xenstore via xenbus_scanf(). Instead of repeating the
> same code over and over add a service function doing the job and
> replace the call of xenbus_scanf() with the call of the new function
> where appropriate.

As this seems to be a series that will go through some tree other
than mine, I assume the networking bits will be taken care of that
way.
