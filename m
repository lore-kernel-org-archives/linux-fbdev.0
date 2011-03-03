From: Chris Wright <chrisw@sous-sol.org>
Date: Thu, 03 Mar 2011 23:53:05 +0000
Subject: Re: [Drbd-dev] [PATCH 2/2 v2] netlink: kill eff_cap from struct
Message-Id: <20110303235305.GY4988@sequoia.sous-sol.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4D6F6180.5030903@trash.net>
 <20110303173230.GP4988@sequoia.sous-sol.org>
 <20110303.105655.189705829.davem@davemloft.net>
 <20110303201522.GT4988@sequoia.sous-sol.org>
 <20110303223746.GI25069@barkeeper1-xen.linbit>
In-Reply-To: <20110303223746.GI25069@barkeeper1-xen.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Wright <chrisw@sous-sol.org>, David Miller <davem@davemloft.net>, linux-fbdev@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, dm-devel@redhat.com

* Lars Ellenberg (lars.ellenberg@linbit.com) wrote:
> Last time I checked, current() for connector based netlink message
> consumers was the work queue that is used for connector.
> 
> So unless that changed, or my understanding is wrong, current_cap()
> inside cn_queue_wrapper(), respectively the d->callback()
> will not be the userland sender process' capabilities, but the work
> queue capabilities.

Yes, you're right.

> If so, then this change introduces the possibility for normal users to
> send privileged commands to connector based subsystems, even if they
> may not be able to bind() to suitable sockets to receive any replies.
> 
> Am I missing something?

No, thanks for review.  This puts back the async issue.
