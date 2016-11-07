From: David Vrabel <david.vrabel@citrix.com>
Date: Mon, 07 Nov 2016 11:08:09 +0000
Subject: Re: [PATCH 00/12] xen: add common function for reading optional value
Message-Id: <8d314b86-4a28-5628-2a79-842a2fafc4c1@citrix.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1477932510-28594-1-git-send-email-jgross@suse.com>
In-Reply-To: <1477932510-28594-1-git-send-email-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org
Cc: boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, roger.pau@citrix.com, peterhuewe@gmx.de, tpmdd@selhorst.net, jarkko.sakkinen@linux.intel.com, jgunthorpe@obsidianresearch.com, tpmdd-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, wei.liu2@citrix.com, paul.durrant@citrix.com, netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org

On 31/10/16 16:48, Juergen Gross wrote:
> There are multiple instances of code reading an optional unsigned
> parameter from Xenstore via xenbus_scanf(). Instead of repeating the
> same code over and over add a service function doing the job and
> replace the call of xenbus_scanf() with the call of the new function
> where appropriate.

Acked-by: David Vrabel <david.vrabel@citrix.com>

Please queue for the next release.

David
