From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 07 Apr 2017 15:27:48 +0000
Subject: Re: [PATCH] xen, fbfront: fix connecting to backend
Message-Id: <2465865.io8KzH0K34@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170323125252.11763-1-jgross@suse.com>
        <CGME20170323141121epcas4p205b564a0ceb1a7c4f01493fbb2e53491@epcas4p2.samsung.com>
        <3aab36b2-d2e3-5d51-f2c8-33cb0a885930@oracle.com>
In-Reply-To: <3aab36b2-d2e3-5d51-f2c8-33cb0a885930@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org, stable@vger.kernel.org

On Thursday, March 23, 2017 10:11:12 AM Boris Ostrovsky wrote:
> On 03/23/2017 08:52 AM, Juergen Gross wrote:
> > Connecting to the backend isn't working reliably in xen-fbfront: in
> > case XenbusStateInitWait of the backend has been missed the backend
> > transition to XenbusStateConnected will trigger the connected state
> > only without doing the actions required when the backend has
> > connected.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Patch queued for 4.11, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

