From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: [ PATCH-LINK ] fb accel capabilities - take
 2
Date: Fri, 28 May 2004 03:11:59 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40B691DF.4060509@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTVvO-0002Aq-Mb
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 May 2004 18:12:42 -0700
Received: from [213.229.38.18] (helo=home.winischhofer.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BTVvN-00055g-RC
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 May 2004 18:12:42 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net


David Eger wrote:
 > If the patch looks good to you (James, Geert, BenH), I'd like to
 > forward it on to Linus followed by the individual driver updates
 > (that'll take a little longer -- I need to revise how drivers do
 > things like remember noaccel, etc. and update them).

You are aware of the fact that some of the fb drivers have maintainers. 
aren't you?

How about properly documenting what you actually do and let the driver 
maintainer handle the implementation?

General question (not to you only): How about considering the 2.6 series 
as "stable" as everybody else does and keep it to fixing bugs instead of 
change the driver API the Xth time?

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
