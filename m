From: Joe Jin <joe.jin@oracle.com>
Date: Fri, 07 Jan 2011 06:43:20 +0000
Subject: Re: [Xen-devel] Re: [patch] xenfb: fix xenfb suspend/resume race
Message-Id: <4D26B608.2060500@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101230125616.GA31537@joejin-pc.cn.oracle.com>		<20101230164051.GC24313@dumpdata.com>		<1294139733.3831.141.camel@zakaz.uk.xensource.com>		<4D256BC7.1080501@oracle.com>	<1294300924.13733.42.camel@localhost.localdomain> <4D2579F1.50900@oracle.com>
In-Reply-To: <4D2579F1.50900@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Jin <joe.jin@oracle.com>
Cc: Ian Campbell <Ian.Campbell@eu.citrix.com>, "jeremy@goop.org" <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "gurudas.pai@oracle.com" <gurudas.pai@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "guru.anbalagane@oracle.com" <guru.anbalagane@oracle.com>, "greg.marsden@oracle.com" <greg.marsden@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On 01/06/11 16:14, Joe Jin wrote:
> 
>>
>> No, it papers over the issue, the code should never have been allowed to
>> get this far if the connection to the backend is not yet fully resumed
>> (i.e. when irq = -1).
>>
>> The call to xenfb_send_event should have been gated further up the call
>> chain, AFAICT by the check of info->update_wanted in xenfb_refresh. This
>> suggests that the correct fix is to set info->update_wanted = 0 in
>> xenfb_resume.
>>
>> I said all this in my previous mail and you ignored it. Did you try this
>> approach?
> 

Disable xenfb refresh flag before suspend will fix this issue, sent new patch
to you by another mail, please review it.

Thanks,
Joe
