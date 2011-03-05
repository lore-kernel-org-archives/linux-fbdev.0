From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Sat, 05 Mar 2011 22:30:59 +0000
Subject: Re: [PATCH v2 1/3] ARM: PXA: PXAFB: Fix double-free issue
Message-Id: <201103060030.59584.anarsoul@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110217110321.GF24627@n2100.arm.linux.org.uk>
	<1298214147-11578-1-git-send-email-anarsoul@gmail.com>
In-Reply-To: <1298214147-11578-1-git-send-email-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Please discard this series.

PXA270/3xx overlay memory management is still broken - it was not good 
decision to allocate memory on open/close - after some time OS just does not 
have 115kb of contiguous memory, so it fails to allocate overlay fb memory 
after ~1h of uptime.

I'll rework it and resend soon.

Regards
Vasily
