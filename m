From: Richard Smith <rsmith@bitworks.com>
Subject: Re: Re: Usage of readb() and friends...
Date: Wed, 03 Mar 2004 18:14:37 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <404674ED.1080704@bitworks.com>
References: <Pine.LNX.4.44.0403032331140.30666-100000@phoenix.infradead.org>
Reply-To: rsmith@bitworks.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aygja-0007Vl-93
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Mar 2004 16:29:06 -0800
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AygWO-0004aP-4r
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Mar 2004 16:15:28 -0800
Received: from bitworks.com [192.168.1.22] by bitworks.com [127.0.0.1] with SMTP (MDaemon.v2.7.SP4.R) for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 03 Mar 2004 18:14:07 -0600
In-Reply-To: <Pine.LNX.4.44.0403032331140.30666-100000@phoenix.infradead.org>
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

James Simmons wrote:

>>>The driver that died was 9 Gigs. 
>>
>>Ok. But do you _have_ to have that much.  Will 4 get you going? Or if 
>>you can do multiple drives I have a few you could raid them or lvm them 
>>into a big drive.
> 
> No problem. Th reason for such a big drive before was it was a SuSE 
> distro. like most distors they throw everything including the kitchen sink 
> at you. I was use a debian system which I would strip down. I have no 
> problem doing mulitple drives. LVM is really cool :-)
> 

Ok. Then I have 3 4Gib drives you can turn into a 12Gib setup.  if you 
can work out the SCA issue.  They are SCA drives.

>>Unless you have a RAID backplane in your setup I doubt you motherboard 
>>does SCA (80-pin) devices.  Nice if so then nice motherboard.

> I don't think so then.

The 80-pin connector for SCA has both Power and scsi ID all in one which 
is why its used for RAID backplanes.  They make SCA to 50 and 68 pin 
adapters that have std pc power jacks on them.  You will still need a 
terminator though probally.

Have you looked on e-bay?  9Gib 68 pin drives are closeing for <= $20 
18Gib for < $30.  Which is less than what 3 SCA to 68 pin converters is 
going to cost.

I have $20 I'll donate for you to buy a new drive.  Got a pay-pal or 
someother internet money account?

-- 
Richard A. Smith
rsmith@bitworks.com




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
