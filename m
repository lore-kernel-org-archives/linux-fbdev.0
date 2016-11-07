From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 07 Nov 2016 16:20:08 +0000
Subject: Re: [PATCH 00/12] xen: add common function for reading optional value
Message-Id: <20161107162008.a2x2lgn3syvv7m23@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1477932510-28594-1-git-send-email-jgross@suse.com>
	<8d314b86-4a28-5628-2a79-842a2fafc4c1@citrix.com>
In-Reply-To: <8d314b86-4a28-5628-2a79-842a2fafc4c1-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Vrabel <david.vrabel-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>
Cc: Juergen Gross <jgross-IBi9RG/b67k@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wei.liu2-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xen-devel-GuqFBffKawuEi8DpZVb4nw@public.gmane.org, tpmdd-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, paul.durrant-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, roger.pau-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org

On Mon, Nov 07, 2016 at 11:08:09AM +0000, David Vrabel wrote:
> On 31/10/16 16:48, Juergen Gross wrote:
> > There are multiple instances of code reading an optional unsigned
> > parameter from Xenstore via xenbus_scanf(). Instead of repeating the
> > same code over and over add a service function doing the job and
> > replace the call of xenbus_scanf() with the call of the new function
> > where appropriate.
> 
> Acked-by: David Vrabel <david.vrabel@citrix.com>
> 
> Please queue for the next release.

If you want this change to tpmdd, please resend it to tpmdd mailing
list and CC it to linux-security-module. Thanks.

> David

/Jarkko
