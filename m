From: Richard Smith <rsmith@bitworks.com>
Subject: Re: Re: Usage of readb() and friends...
Date: Wed, 03 Mar 2004 17:22:54 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <404668CE.1020504@bitworks.com>
References: <Pine.LNX.4.44.0403032254230.30666-100000@phoenix.infradead.org>
Reply-To: rsmith@bitworks.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ayfux-0004M5-S2
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Mar 2004 15:36:47 -0800
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Ayfhm-0003Sb-VL
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Mar 2004 15:23:11 -0800
Received: from bitworks.com [192.168.1.22] by bitworks.com [127.0.0.1] with SMTP (MDaemon.v2.7.SP4.R) for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 03 Mar 2004 17:22:30 -0600
In-Reply-To: <Pine.LNX.4.44.0403032254230.30666-100000@phoenix.infradead.org>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

James Simmons wrote:

>>
>>1) How big of a drive to you have to have?  I've got some 4 gigers I can 
>>donate.
> 
> The driver that died was 9 Gigs. 

Ok. But do you _have_ to have that much.  Will 4 get you going? Or if 
you can do multiple drives I have a few you could raid them or lvm them 
into a big drive.

>>2) Do you have any way to use SCA drives?
> 
> Its a older (4 years old) machine with built in Ultra Wide 2 scsi support. 
> Its 68 pin. I believe my mother board supports 80 pin as well. I have to 
> look.

Unless you have a RAID backplane in your setup I doubt you motherboard 
does SCA (80-pin) devices.  Nice if so then nice motherboard.

-- 
Richard A. Smith
rsmith@bitworks.com




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
