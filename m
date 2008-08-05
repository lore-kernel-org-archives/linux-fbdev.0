From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH] au1200fb: fixup PM support.
Date: Tue, 05 Aug 2008 18:08:39 +0200
Message-ID: <48987B07.80502@roarinelk.homelinux.net>
References: <20080805124221.GA27469@roarinelk.homelinux.net>
	<1217952137.23188.2.camel@kh-ubuntu.razamicroelectronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQP5c-0005I7-UE for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 09:08:49 -0700
Received: from fnoeppeil43.netpark.at ([217.175.205.171]
	helo=roarinelk.homelinux.net)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQP5Z-00077Q-8F
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 09:08:48 -0700
In-Reply-To: <1217952137.23188.2.camel@kh-ubuntu.razamicroelectronics.com>
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
To: Kevin Hickey <khickey@rmicorp.com>
Cc: L-M-O <linux-mips@linux-mips.org>, linux-fbdev-devel@lists.sf.net

Kevin Hickey wrote:
> On Tue, 2008-08-05 at 14:42 +0200, Manuel Lauss wrote:
>> Remove last traces of the custom Alchemy linux-2.4 PM code, implement
>> suspend/resume callbacks.
>>
>> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
>> ---
>>  drivers/video/au1200fb.c |  164 ++++++++++++----------------------------------
>>  1 files changed, 41 insertions(+), 123 deletions(-)
>>
> This looks good.  It applied to my tree and appears functional on my
> board.  One question: what about dynamic brightness?  It was part of the
> old PM interface and you seem to have removed it.  Any ideas about
> re-integrating that into the current PM model?

Hm, good point.  Let me see if I can hook the 2 PWMs into the backlight
framework somehow...   I'll repost once this works.


> Acked-by: Kevin Hickey <khickey@rmicorp.com>

MfG,
	Manuel Lauss

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
