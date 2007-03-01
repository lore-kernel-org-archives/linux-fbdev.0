From: Ian Romanick <idr@us.ibm.com>
Subject: Re: matroxfb returning incorrect fix.smem_len?
Date: Thu, 01 Mar 2007 08:47:34 -0800
Message-ID: <45E703A6.6080200@us.ibm.com>
References: <45E5D610.5060807@us.ibm.com>
	<Pine.LNX.4.62.0703011420461.766@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMoVd-0004AW-9B for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 08:52:01 -0800
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HMoVc-00013G-PP
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 08:52:01 -0800
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l21GpnEC026777
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 1 Mar 2007 11:51:49 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l21GpnTk542628 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 1 Mar 2007 09:51:49 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l21Gpmsf000439 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 1 Mar 2007 09:51:49 -0700
In-Reply-To: <Pine.LNX.4.62.0703011420461.766@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Geert Uytterhoeven wrote:
> On Wed, 28 Feb 2007, Ian Romanick wrote:
>> While doing some work on the pci-rework branch of X.org, I noticed
>> something strange.  matroxfb correctly detects that my card has 16MiB,
>> but fix.smem_len is only 8MiB.
>>
>> I looked around the matroxfb code and some of the other driver's code,
>> and I believe that matroxfb is incorrectly setting fix.smem_len.
>> Matroxfb sets fix.smem_len to (total_memory_size -
>> memory_used_by_current_mode).  Other drivers, such as nvidiafb do not do
>> this.
> 
> Did matroxfb detect a dual-head capable card?

I did some more digging on this yesterday.  It seems that ydstorg.bytes
is always zero, so what I originally thought was the problem is not the
problem.

Looking at the logs, it looks like it is detecting my card as dual-head,
but it's not.  The weird thing is that I added a printk in
matroxfb_update_fix to show what smem_len is begin set to.  Before I
start X, it prints 16MiB twice.  As soon as X starts, it prints 8MiB and
returns that value to the X server.

I'm not quite sure what to make of that.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFF5wOlX1gOwKyEAw8RAv7bAJ9Jmxr+zWINCNCEP9s9HKgpr7/bGACcCg1j
PvYS3AtO0J7ssotSB/xgjO0=
=MXBE
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
