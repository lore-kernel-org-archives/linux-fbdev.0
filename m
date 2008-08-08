From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 0/13 v2] viafb: VIA Frame Buffer
 Device Driver
Date: Fri, 8 Aug 2008 18:27:04 +0200
Message-ID: <20080808182704.28bd9fb3.krzysztof.h1@poczta.fm>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8078B698C@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KRUil-0004Yj-GW for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 09:21:44 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KRUii-0003iS-Vm
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 09:21:42 -0700
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8078B698C@exchtp03.taipei.via.com.tw>
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
To: JosephChan@via.com.tw
Cc: geert@linux-m68k.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Fri, 8 Aug 2008 18:09:21 +0800
<JosephChan@via.com.tw> wrote:

> Hi all,
> 
> Here comes the 13 updated patchs for VIA Frame Buffer Device Driver.
> This driver could be used on VIA UniChrome (Pro) and Chrome9 family chips.
> All the patches are based on linux kernel 2.6.27-rc2 and they're modified by adopting community's feedback.
> I would like to thank all who provided their suggestions for VIAFB by mail.
> Any question, please contact me. Thanks.
> 

Please resend the 3rd patch as it is damaged (missing 3 lines of each file).

I am for merging these patches as they are sent now. It allows sending 
fixes to them as incremental patches.

This set builds at least for my configuration (Pentium3 SMP). 
Unfortunately, I do not have hardware to test. I though about
buying one of these sexy VIA ITX boards but it is outside my
budget now. Anyway, I have too many computers according
to my spouse.

Kind regards,
Krzysztof


----------------------------------------------------------------------
Tylko dla detektywow! Konkurs na Smaker.pl
Kliknij >>> http://link.interia.pl/f1eb1


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
