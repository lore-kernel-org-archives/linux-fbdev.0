From: Andrew Morton <akpm@osdl.org>
Subject: Fw: Re: disabling VESAFB no longer locks up VT (was Re: 2.4.10-r1
 MTRR bug)
Date: Fri, 14 Jan 2005 17:04:45 -0800
Message-ID: <20050114170445.0d02ae91.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpcIQ-0001Vq-Ni
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Jan 2005 17:00:06 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CpcIN-0005yb-Ij
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Jan 2005 17:00:05 -0800
Received: from akpm.pao.digeo.com (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id j0F101l07457
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Jan 2005 17:00:01 -0800
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net


Are you folks aware of this lkml thread??

Thanks.

Begin forwarded message:

Date: Fri, 14 Jan 2005 16:50:42 -0800
From: Steve <s.egbert@sbcglobal.net>
To: Daniel Drake <dsd@gentoo.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: disabling VESAFB no longer locks up VT (was Re: 2.4.10-r1 MTRR bug)


Daniel Drake wrote:

> Hi Andrew,
>
> Andrew Morton wrote:
>
>> Steve <s.egbert@sbcglobal.net> wrote:
>>
>>> For the Athlon 2100, I get the following outputs and then the VGA 
>>> console is frozen from further output (but it doesn't prevent the 
>>> full bootup into X windows session of which I am able to resume 
>>> normal Linux/X session, but not able to regain any virtual console 
>>> session.)
>>
>>
>>
>> hm.  Not sure what could have caused that.
>
>
> This may be a problem in Gentoo's kernels, we offer an experimental 
> version of vesafb... 

Disabling the VESAFB resulted in regaining control of the VTs (virtual 
terminals).


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
