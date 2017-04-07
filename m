From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 07 Apr 2017 14:54:19 +0000
Subject: Re: [PATCH] xen, fbfront: add support for specifying size via xenstore
Message-Id: <3954539.NnHpWin5TI@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170323125304.11891-1-jgross@suse.com>
 <CGME20170323141354epcas3p4ea5b46cc3e2cb1987b673772992d35dd@epcas3p4.samsung.com>
 <ac309068-4d89-4684-0890-4671c2396d61@oracle.com>
In-Reply-To: <ac309068-4d89-4684-0890-4671c2396d61@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org


Hi,

On Thursday, March 23, 2017 10:13:44 AM Boris Ostrovsky wrote:
> On 03/23/2017 08:53 AM, Juergen Gross wrote:
> > Today xen-fbfront supports specifying the display size via module
> > parameters only. Add support for specifying the size via Xenstore in
> > order to enable doing this easily via the domain's Xen configuration.
> >
> > Add an error message in case the configured display size conflicts
> > with video memory size.
> >
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Patch queued for 4.12, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

