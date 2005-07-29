From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Re: mttr failures on 2.6.12-mm1
Date: Sat, 30 Jul 2005 06:20:38 +0800
Message-ID: <42EAABB6.20606@gmail.com>
References: <1119401665.11299.1.camel@dyn9047017102.beaverton.ibm.com>	<20050728220153.269b4081.akpm@osdl.org>	<42EA3243.10305@gmail.com> <20050729112601.34f300a3.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DydDe-0006EW-QY
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 15:20:42 -0700
Received: from wproxy.gmail.com ([64.233.184.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DydDd-00079T-42
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 15:20:42 -0700
Received: by wproxy.gmail.com with SMTP id i20so660050wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Jul 2005 15:20:35 -0700 (PDT)
In-Reply-To: <20050729112601.34f300a3.akpm@osdl.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, pbadari@us.ibm.com, ak@muc.de

Andrew Morton wrote:
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>>     vesafb: Fix mtrr bugs
> 
> Thanks, Tony.
> 
>>      1. Fix algorithm for finding the best power of 2 size with mtrr_add().
>>      2. Add option to choose the mtrr type by extending the mtrr boot option:
>>
>>         mtrr:n where n
>>
>>          0 = no mtrr (equivalent to using the nomtrr option)
>>          1 = uncachable
>>          2 = write back
>>          3 = write combining (default)
>>          4 = write through
>>
> 
> Is an update to Documentation/kernel-parameters.txt or
> Documentation/fb/vesafb.txt needed?
> 

Yes. I'll submit a patch ASAP.

Tony


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
