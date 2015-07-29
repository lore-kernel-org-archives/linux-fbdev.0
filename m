From: Julien Grall <julien.grall@citrix.com>
Date: Wed, 29 Jul 2015 11:27:07 +0000
Subject: Re: [Xen-devel] [PATCH 4/8] xen: Use the correctly the Xen memory terminologies
Message-Id: <55B8B88B.2070400@citrix.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
 <1438095769-2560-5-git-send-email-julien.grall@citrix.com>
 <4EE5B48738DDED408878C97C8E050A8B1D7DDBB5@SJEXCHMB05.corp.ad.broadcom.com>
In-Reply-To: <4EE5B48738DDED408878C97C8E050A8B1D7DDBB5@SJEXCHMB05.corp.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Chris,

On 28/07/15 20:39, Chris (Christopher) Brand wrote:
>> Based on include/xen/mm.h [1], Linux is mistakenly using MFN when GFN is meant,
>> I suspect this is because the first support for Xen was for PV. This brough some
> Typo : "brought"
> Perhaps "resulted in" would be better ?
> 
>> misimplementation of helpers on ARM and make the developper confused the expected behavior.
> Typo: "developer".
> I'd also suggest "...and confused developers about the...".
> 
> [...]
> 
>> For clarity and avoid new confusion, replace any reference of mfn into gnf in any helpers used by PV drivers.
> Typo : "gfn"
> I'd suggest "...replace any reference to mfn with gfn..."
> 
> [...]

Thanks for telling me the typoes. I will fix it in the next version of
this series.

Regards,

-- 
Julien Grall
