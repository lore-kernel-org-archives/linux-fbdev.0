From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v4] fbdev: add new TMIO
	framebuffer	driver
Date: Wed, 8 Oct 2008 18:05:09 +0000 (UTC)
Message-ID: <gcisol$ico$1@ger.gmane.org>
References: <1223463303-32700-1-git-send-email-dbaryshkov@gmail.com>
	<20081008171546.GA4766@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <glfd-linux-fbdev-devel@m.gmane.org>)
	id 1KndPd-00085S-Sx for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Oct 2008 18:05:29 +0000
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1KndPY-0001VT-K6
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Oct 2008 18:05:29 +0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KndPS-0007vw-L9 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Oct 2008 18:05:18 +0000
Received: from ppp89-110-9-104.pppoe.avangarddsl.ru ([89.110.9.104])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00 for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 08 Oct 2008 18:05:18 +0000
Received: from dbaryshkov by ppp89-110-9-104.pppoe.avangarddsl.ru with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 08 Oct 2008 18:05:18 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Samuel Ortiz wrote:

> On Wed, Oct 08, 2008 at 02:55:03PM +0400, Dmitry Baryshkov wrote:
>> Add driver for TMIO framebuffer cells as found e.g. in Toshiba TC6393XB
>> chips.
>> 
>> Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com> Cc: Ian Molton
>> <spyro@f2s.com>
>> Cc: Samuel Ortiz <sameo@openedhand.com>
> Acked-by: Samuel Ortiz <sameo@openedhand.com>

Thanks. And as Kristoffer acked one of previous revisions of this driver,
I hope he will also ack this one. Now the question is: via which tree should
this driver be merged? Is there any specific FB tree? Or should I send pull
request directly to Linus when the window will open :) ?

-- 
With best wishes
Dmitry



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
