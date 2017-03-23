From: Juergen Gross <jgross@suse.com>
Date: Thu, 23 Mar 2017 13:56:48 +0000
Subject: Re: [Xen-devel] [PATCH] xen, fbfront: fix connecting to backend
Message-Id: <82f7f206-3caf-7696-3649-97f3b8e5d33b@suse.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170323125252.11763-1-jgross@suse.com>
 <58D3DDB40200007800146C6B@suse.com>
In-Reply-To: <58D3DDB40200007800146C6B@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan Beulich <JBeulich@suse.com>
Cc: xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On 23/03/17 14:37, Jan Beulich wrote:
>>>> On 23.03.17 at 13:52, <jgross@suse.com> wrote:
>> Connecting to the backend isn't working reliably in xen-fbfront: in
>> case XenbusStateInitWait of the backend has been missed the backend
>> transition to XenbusStateConnected will trigger the connected state
>> only without doing the actions required when the backend has
>> connected.
> 
> Looks like xen-kbdfront does exactly the same - shouldn't it also be
> changed then?

I posted that patch 2 days ago. :-)


Juergen

