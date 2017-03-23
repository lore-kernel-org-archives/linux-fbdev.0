From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Date: Thu, 23 Mar 2017 14:11:12 +0000
Subject: Re: [PATCH] xen, fbfront: fix connecting to backend
Message-Id: <3aab36b2-d2e3-5d51-f2c8-33cb0a885930@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170323125252.11763-1-jgross@suse.com>
In-Reply-To: <20170323125252.11763-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org
Cc: b.zolnierkie@samsung.com, stable@vger.kernel.org

On 03/23/2017 08:52 AM, Juergen Gross wrote:
> Connecting to the backend isn't working reliably in xen-fbfront: in
> case XenbusStateInitWait of the backend has been missed the backend
> transition to XenbusStateConnected will trigger the connected state
> only without doing the actions required when the backend has
> connected.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


