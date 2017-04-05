From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 05 Apr 2017 14:28:31 +0000
Subject: Re: [PATCH] xen, fbfront: fix connecting to backend
Message-Id: <5998137.VJ3GrqTG96@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170323125252.11763-1-jgross@suse.com>
        <CGME20170405081829epcas4p4cc7bf7bf888d0cc82d64a5b3307a1548@epcas4p4.samsung.com>
        <3226cec6-8f68-6d15-4427-eb8f2d1944a1@suse.com>
In-Reply-To: <3226cec6-8f68-6d15-4427-eb8f2d1944a1@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org, boris.ostrovsky@oracle.com, stable@vger.kernel.org


Hi,

On Wednesday, April 05, 2017 10:18:21 AM Juergen Gross wrote:
> On 23/03/17 13:52, Juergen Gross wrote:
> > Connecting to the backend isn't working reliably in xen-fbfront: in
> > case XenbusStateInitWait of the backend has been missed the backend
> > transition to XenbusStateConnected will trigger the connected state
> > only without doing the actions required when the backend has
> > connected.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> Bartlomiej, any comments? Can you please take this patch or should I
> carry it through the Xen tree?

Looks fine to me, I will queue it for 4.11 on Friday.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

