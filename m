From: <JosephChan@via.com.tw>
Subject: Re: [PATCH 0/13 v2] viafb: VIA Frame Buffer
	Device Driver
Date: Mon, 11 Aug 2008 19:57:34 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB8078F49B8@exchtp03.taipei.via.com.tw>
References: <20080811091747.045A66D605@f09.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KSW1s-0005yc-Nm for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Aug 2008 04:57:40 -0700
Received: from mailtp.via.com.tw ([61.66.243.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KSW1r-0004RA-Co
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Aug 2008 04:57:40 -0700
Content-class: urn:content-classes:message
In-Reply-To: <20080811091747.045A66D605@f09.poczta.interia.pl>
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
To: krzysztof.h1@poczta.fm
Cc: geert@linux-m68k.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks. After re-checking again, I met the malformed issue.
I think that's my careless, I will re-submit the patch again later.

BRs,
Joseph

-----Original Message-----
From: krzysztof.h1@poczta.fm [mailto:krzysztof.h1@poczta.fm] 
Sent: Monday, August 11, 2008 5:18 PM
To: Joseph Chan; krzysztof.h1@poczta.fm
Cc: linux-fbdev-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org; akpm@linux-foundation.org; geert@linux-m68k.org
Subject: RE: [Linux-fbdev-devel] [PATCH 0/13 v2] viafb: VIA Frame Buffer Device Driver

> Hi Krzysztof,
> 
> Thanks to remind, but after I checked the patches in linux-fbdev-devel 
> mailing list.
> It seems there is no missing lines as you mentioned. 
> 

There are 3 lines missing at the end of each file. I assume they are empty one so no content is missing but the command:

patch -p1 < viafb3.patch

ends with:
patch: **** malformed patch at line 259: diff -Nurp a/drivers/video/via/accel.h b/drivers/video/via/accel.h

If one adds three lines "+" at the line 259, the patch command ends with:

patching file drivers/video/via/accel.h
patch: **** malformed patch at line 446:

Adding three lines "+" at the mentioned file solves the problem.

Kind regards,
Krzysztof

----------------------------------------------------------------------
Taniej na zagraniczne komorki!
Sprawdz >>> http://link.interia.pl/f1ece


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
