From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 05 Apr 2017 14:29:09 +0000
Subject: Re: [PATCH] xen, fbfront: add support for specifying size via xenstore
Message-Id: <3015428.zVWZOC9VrQ@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170323125304.11891-1-jgross@suse.com>
 <CGME20170405081849epcas3p4544b078d2ccb24492f9d9d516d4501d1@epcas3p4.samsung.com>
 <30c4d7f4-044e-9eff-bda9-fa9f5486e66f@suse.com>
In-Reply-To: <30c4d7f4-044e-9eff-bda9-fa9f5486e66f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org, boris.ostrovsky@oracle.com

On Wednesday, April 05, 2017 10:18:43 AM Juergen Gross wrote:
> On 23/03/17 13:53, Juergen Gross wrote:
> > Today xen-fbfront supports specifying the display size via module
> > parameters only. Add support for specifying the size via Xenstore in
> > order to enable doing this easily via the domain's Xen configuration.
> > 
> > Add an error message in case the configured display size conflicts
> > with video memory size.
> > 
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> Bartlomiej, any comments? Can you please take this patch or should I
> carry it through the Xen tree?

Looks fine to me, I will queue it for 4.12 on Friday.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

