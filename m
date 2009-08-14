From: Roman Sergeev <sungeneral@gmail.com>
Subject: Re: [Bugme-new] [Bug 13976] New: viafb + vmalloc
Date: Fri, 14 Aug 2009 10:38:58 +0400
Message-ID: <FE2B7370-64DF-43D4-B0E3-C65EB1AD1986@gmail.com>
References: <bug-13976-10286@http.bugzilla.kernel.org/>
	<20090813123622.624240c7.akpm@linux-foundation.org>
	<4A84849A.3000807@gmx.de>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sungeneral@gmail.com>) id 1MbqRY-0000Nl-BW
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Aug 2009 06:39:16 +0000
Received: from mail-ew0-f210.google.com ([209.85.219.210])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MbqRR-0001Pp-Lu for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Aug 2009 06:39:16 +0000
Received: by ewy6 with SMTP id 6so1296835ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Aug 2009 23:39:03 -0700 (PDT)
In-Reply-To: <4A84849A.3000807@gmx.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, bugzilla-daemon@bugzilla.kernel.org, Joseph Chan <JosephChan@via.com.tw>, Scott Fang <ScottFang@viatech.com.cn>, bugme-daemon@bugzilla.kernel.org, Andrew Morton <akpm@linux-foundation.org>


On 14.08.2009, at 1:24, Florian Tobias Schandinat wrote:

>>>
>>> ps: viafb build as a module
>>>
>> a) The driver appears to be ioremapping more virtual address space
>>   than the machine can provide.
>>   Is that expected?
>
> I don't know.
> Is the video memory size detection of (I think) 256 MB correct?
> What is the graphic chip? (CLE266, CN400, CN700, KM400, CX700 or  
> VX800?)
>

01:00.0 VGA compatible controller: VIA Technologies, Inc. P4M900  
[Chrome 9 HC] (rev 01)
with shadow ram (total 2Gb, but system see 1768Mb... maybe 280Mb)

after modprobe viafb don't die, they going to new state
viafb 75212 1 - Loading 0xef642000



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
