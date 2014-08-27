From: Henrik =?ISO-8859-1?Q?Nordstr=F6m?= <henrik@henriknordstrom.net>
Date: Wed, 27 Aug 2014 08:17:04 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <1409127424.2701.27.camel@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com> <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com> <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com> <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com> <20140825152232.GE15297@lukather>
 <20140826080432.GD17263@ulmo> <20140826135341.GM15297@lukather>
In-Reply-To: <20140826135341.GM15297@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

tis 2014-08-26 klockan 15:53 +0200 skrev Maxime Ripard:
> > it should be fixed at the root. So a much better solution would be to
> > establish a way for firmware to communicate to the kernel that a given
> > resource has been enabled by firmware and shouldn't be disabled. Such a
> > solution can be implement for all types of resources and can be reused
> > by all drivers since they don't have to worry about these details.
> 
> Mike Turquette repeatedly said that he was against such a DT property:
> https://lkml.org/lkml/2014/5/12/693

And not really what we want here. The clocks should be turned off if not
in use, i.e. when simplefb is unbound from the device and no other
driver has taken over. Maybe even in the case where there is no simplefb
driver in-kernel, but if the use case is to be generalized then this
kind of resources need to be held until explicitly released to allow
resources to be held until their driver is loaded, which may happen long
after kernel bootup.

But again, for many use cases it is a virtual hardware property, not
really hardware in it's own but still smells a lot like hardware. These
parameters is only valid until the hardware have been reconfigured.

Regards
Henrik

