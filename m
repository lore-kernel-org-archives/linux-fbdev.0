From: Joe Jin <joe.jin@oracle.com>
Date: Thu, 06 Jan 2011 08:14:41 +0000
Subject: Re: [patch] xenfb: fix xenfb suspend/resume race
Message-Id: <4D2579F1.50900@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101230125616.GA31537@joejin-pc.cn.oracle.com>	 <20101230164051.GC24313@dumpdata.com>	 <1294139733.3831.141.camel@zakaz.uk.xensource.com>	 <4D256BC7.1080501@oracle.com> <1294300924.13733.42.camel@localhost.localdomain>
In-Reply-To: <1294300924.13733.42.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Campbell <Ian.Campbell@eu.citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "jeremy@goop.org" <jeremy@goop.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gurudas.pai@oracle.com" <gurudas.pai@oracle.com>, "greg.marsden@oracle.com" <greg.marsden@oracle.com>, "guru.anbalagane@oracle.com" <guru.anbalagane@oracle.com>


> 
> No, it papers over the issue, the code should never have been allowed to
> get this far if the connection to the backend is not yet fully resumed
> (i.e. when irq = -1).
> 
> The call to xenfb_send_event should have been gated further up the call
> chain, AFAICT by the check of info->update_wanted in xenfb_refresh. This
> suggests that the correct fix is to set info->update_wanted = 0 in
> xenfb_resume.
> 
> I said all this in my previous mail and you ignored it. Did you try this
> approach?

Will try this then update you.

Thanks,
Joe
