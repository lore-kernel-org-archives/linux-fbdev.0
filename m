From: "Scott D. Davilla" <davilla@4pi.com>
Subject: Re: deprecating fix->mmio_start and smem_start
Date: Tue, 22 Apr 2008 12:03:58 -0400
Message-ID: <p0623091ac433bc15bc29@[192.168.2.55]>
References: <1208827046.9640.73.camel@pasglop>
	<Pine.LNX.4.64.0804220951380.14102@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JoKym-0000fG-JT for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 09:04:24 -0700
Received: from mx.4pi.com ([24.172.19.59])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JoKye-0003pb-2k
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 09:04:19 -0700
Received: from [192.168.2.55] (unknown [24.172.19.62])
	by mx.4pi.com (Postfix) with ESMTP id 866063A6AA57
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 22 Apr 2008 12:04:07 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0804220951380.14102@anakin>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

>On Tue, 22 Apr 2008, Benjamin Herrenschmidt wrote:
>>  We currently have a problem with those two members of struct
>>  fb_fix_screeninfo. The struct contains an "unsigned long" which means
>>  that:
>>
>>  - 64 bits kernels with 32 bits userspace can't pass a complete address
>>  - 32 bits machines with 64 bits resource_size_t can't pass a complete
>>  address
>>  - The structure isn't even properly padded to be 32/64 bits neutral in
>>  the first place.
>>
>  > We could define new versions of the struct with new get/set ioctls,
>>  or we could try to just deprecate those fields. What do you guys think ?
>
>As userspace doesn't really need those fields[1], we can easily 
>deprecate them.
>

kexec uses FBIOGET_FSCREENINFO and FBIOGET_VSCREENINFO. So if these 
ioctls changes, it will possibly break kexec under vesafb and efifb.

Scott


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
