From: Vassilis Virvilis <vasvir@iit.demokritos.gr>
Subject: Re: Twister savagefb doesn't sync
Date: Wed, 31 May 2006 17:11:24 +0300
Message-ID: <447DA40C.8060608@iit.demokritos.gr>
References: <44698356.80806@iit.demokritos.gr> <447359B8.7020304@iit.demokritos.gr> <447381E9.4060705@gmail.com> <447803FC.8050009@iit.demokritos.gr> <44781B3A.5030406@gmail.com> <44781BFB.5020708@gmail.com> <447994A8.30600@iit.demokritos.gr> <447A3CC0.9060403@gmail.com> <447AF58E.3050803@iit.demokritos.gr> <447B60D7.8020204@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030904010308030907010309"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlSRU-0005TA-1V
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 May 2006 08:17:04 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FlSRT-0005R9-Q8
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 May 2006 08:17:03 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FlSRT-0007y8-28
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 May 2006 08:17:03 -0700
Received: from zeus.iit.demokritos.gr ([143.233.226.2])
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1FlRLs-0004yo-26
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 May 2006 07:07:13 -0700
In-Reply-To: <447B60D7.8020204@gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

This is a multi-part message in MIME format.
--------------030904010308030907010309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Antonino A. Daplas wrote:
> Vassilis Virvilis wrote:
> 

> 
> Much simpler if you just load X first with UseBIOS False then dump the regs.
> Do the same with UseBIOS True.  You mentioned that X does not work if the
> option UseBIOS is false.
> 
> Tony 
> 

That implies the kernel and the X driver are in sync yes?

Anyway I am attaching a little awk script that works a litle
better that diff for the untrained eye... along with the dumps
you asked. Maybe it makes some sense to you...


Here is the output
regdiff

$>./regdiff fb-640x480-64K@60 X-640x480-64K\@60-usebios\=false
Register:           X working (Bios)   X not working (UseBios=false)
-------------------------------------------------
SR1[0x0]:                  50                  00
SR1[0x1]:                  7d                  00
SR1[0x2]:            ffffffc1            ffffffc7
SR1[0x3]:                  28                  7d
SR1[0x7]:            ffffffc1            fffffffe
SR1[0xB]:            ffffff82                  12
SR5[0xB]:                  7e                  76
CR0[0x2]:                  51                  4f
CR0[0x3]:            ffffff9d            ffffff80
CR0[0xA]:                  1f                  00
CR0[0xB]:                  1e                  00
CR1[0x5]:            ffffffe9            ffffffdf
CR1[0x6]:            ffffffeb                  0b
CR2[0x1]:                  00            ffffffff
CR2[0x3]:                  00            ffffffff
CR2[0x4]:                  00                  20
CR2[0x5]:                  00                  20
CR2[0x6]:                  00                  20
CR2[0x7]:                  00                  20
CR2[0x8]:                  00                  20
CR2[0x9]:                  00                  20
CR2[0xA]:                  00                  20
CR2[0xB]:                  00                  20
CR2[0xC]:                  00                  20
CR3[0x9]:            ffffffbd            ffffffb8
CR3[0xA]:                  15            ffffff91
CR4[0x6]:                  00                  01
CR4[0x7]:            ffffff8a                  39
CR4[0x8]:            ffffff89                  38
CR4[0x9]:                  61            ffffffe9
CR6[0x9]:                  00            ffffff80
CR8[0x6]:                  00                  08
CR8[0x8]:                  08                  10
CR8[0x9]:                  08                  10
CR8[0xA]:                  08                  10
CR8[0xB]:                  08                  10
CR8[0xC]:                  08                  10
CR8[0xD]:                  08                  10
CR8[0xE]:                  08                  10

--------------030904010308030907010309
Content-Type: text/plain;
 name="regdiff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="regdiff"

#!/bin/awk -f

BEGIN {
	if (ARGC != 3) {
		print "Syntax: regdiff dump1 dump2\n" > "/dev/stderr";
		exit(1);
	}

	f1 = ARGV[1];
	f2 = ARGV[2];

	if ((getline l1 < f1) <= 0 || (getline l2 < f2) <= 0) {
		printf("Cannot find file %s or %s\n", f1, f2) > "/dev/stderr";
		exit(1);
	}

	while (1) {
		if  ((getline l1 < f1) <= 0 || (getline l2 < f2) <= 0)
			break;
		l1n = split(l1, l1a);
		l2n = split(l2, l2a);
		for (i = 1; i < l1n; i++) {
			if (l1a[i] != l2a[i]) {
				reg = sprintf("%s[0x%X]", substr(l1a[1], 0, length(l1a[1]) - 1), i - 2);
				printf("%s:%20s%20s\n", reg, l1a[i], l2a[i]);
			}
		}
	}

	exit(0);
}

--------------030904010308030907010309
Content-Type: text/plain;
 name="X-640x480-64K@60"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="X-640x480-64K@60"

TwisterP

SR0x  03 01 0f 00 0e 05 06 07 06 00 0a 00 0c 00 0e 0f
SR1x  00 00 ffffffc5 fffffffc 00 00 0c fffffffe 40 02 02 12 00 fffffff8 0a 00
SR2x  20 21 22 23 24 25 26 04 0c 00 2a 02 18 00 2e 2f
SR3x  10 17 41 63 00 00 00 00 00 00 3a 3b 3c 00 3e 00
SR4x  40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f
SR5x  00 00 21 fffffff7 1f 1f 1f 7f 08 60 18 7e 77 fffffff7 02 04
SR6x  ffffffa3 7f ffffff80 06 ffffff83 fffffff4 ffffff80 00 24 ffffffff ffffffff 24 02 ffffff98 ffffffa3 32
CR0x  5f 4f 50 ffffff82 52 ffffff9e 0b 3e 00 40 00 00 00 00 ffffffff 00
CR1x  ffffffe9 0b ffffffdf ffffffa0 60 ffffffe7 03 ffffffab ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
CR2x  ffffffff ffffffff 6c ffffffff 20 20 20 20 20 20 20 20 20 ffffff8d 01 02
CR3x  ffffffe1 0c 00 08 00 00 ffffffbf ffffffdb 5b ffffffb8 10 58 32 00 00 00
CR4x  01 20 00 00 00 01 00 ffffffff fffffff8 3e 00 ffffffff 7f 7c 40 40
CR5x  ffffffd1 00 00 08 00 00 00 00 13 ffffffe0 00 00 00 00 00 00
CR6x  00 00 00 00 00 04 ffffff89 40 ffffffff ffffff80 00 03 00 ffffffff 00 ffffffee
CR7x  10 ffffffc0 07 1f 1f 1f 00 1f 01 04 1f 1f 17 17 17 17
CR8x  00 00 00 00 70 13 00 00 10 10 10 10 10 10 10 10
CR9x  ffffff80 ffffff9f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
CRax  1a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
CRbx  fffffff7 0c 00 00 00 00 00


--------------030904010308030907010309
Content-Type: text/plain;
 name="X-640x480-64K@60-usebios=false"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="X-640x480-64K@60-usebios=false"

TwisterP

SR0x  03 01 0f 00 0e 05 06 07 06 00 0a 00 0c 00 0e 0f
SR1x  00 00 ffffffc7 7d 00 ffffff83 0c fffffffe 00 02 02 12 00 fffffff8 0a 00
SR2x  20 21 22 23 24 25 26 04 0c 00 2a 02 18 00 2e 2f
SR3x  10 17 41 63 00 00 00 00 00 00 3a 3b 3c 00 3e 00
SR4x  40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f
SR5x  00 00 21 fffffff7 1f 1f 1f 7f 08 60 18 76 77 fffffff7 02 04
SR6x  ffffffa3 7f ffffff80 06 ffffff83 fffffff4 ffffff80 00 24 ffffffff ffffffff 24 02 ffffff98 ffffffa3 32
CR0x  5f 4f 4f ffffff80 52 1e 0b 3e 00 40 00 00 00 00 00 00
CR1x  ffffffea 2c ffffffdf ffffffa0 00 ffffffdf 0b ffffffeb ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
CR2x  ffffffff ffffffff 00 ffffffff 20 20 20 20 20 20 20 20 20 ffffff8d 01 02
CR3x  ffffffe1 0c 40 08 10 00 ffffffbf ffffffdb 5b ffffffb8 ffffff91 59 2f 00 00 00
CR4x  01 03 00 00 00 00 01 39 38 ffffffe9 00 ffffffff 7f 7c 40 40
CR5x  ffffffd1 00 00 00 00 00 00 00 13 ffffffe0 00 00 00 00 40 00
CR6x  00 00 00 00 00 00 ffffff89 41 ffffffff ffffff80 00 03 00 ffffffff 00 ffffffee
CR7x  10 ffffffc0 07 1f 1f 1f 00 1f 01 04 1f 1f 17 17 17 17
CR8x  00 00 00 00 70 10 08 00 10 10 10 10 10 10 10 10
CR9x  ffffff80 ffffffa0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
CRax  1a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
CRbx  fffffff7 0c 00 00 00 00 00


--------------030904010308030907010309--


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
