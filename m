From: Evgeniy Polyakov <zbr@ioremap.net>
Date: Tue, 08 Mar 2011 18:32:46 +0000
Subject: Re: [Drbd-dev] [PATCH 2/2 v2] netlink: kill eff_cap from struct
Message-Id: <20110308183246.GA17412@ioremap.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4D6F6180.5030903@trash.net>
 <20110303173230.GP4988@sequoia.sous-sol.org>
 <20110303.105655.189705829.davem@davemloft.net>
 <20110303201522.GT4988@sequoia.sous-sol.org>
 <20110303223746.GI25069@barkeeper1-xen.linbit>
 <20110304012956.GA13573@ioremap.net>
 <4D764247.9080509@trash.net>
In-Reply-To: <4D764247.9080509@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Patrick McHardy <kaber@trash.net>
Cc: Chris Wright <chrisw@sous-sol.org>, David Miller <davem@davemloft.net>, linux-fbdev@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, dm-devel@redhat.com, drbd-dev@lists.linbit.com

Hi Patrick.

On Tue, Mar 08, 2011 at 03:50:47PM +0100, Patrick McHardy (kaber@trash.net) wrote:
> > Yup, connector is very async at that place, but I wonder why the hell I
> > ever made that decision. I believe we can replace it with pure sync call
> > of the registered connector callback, since netlink is synchronous and
> > no one has any problem with it.
> 
> Are you going to do this or do you want me to take care of it?

I will return back at the end of the week and will take care of this
problem. I will not mind if you complete it first though :)

-- 
	Evgeniy Polyakov
