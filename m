From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: Re: [PATCH 0/8] fbcon: Console Rotation
Date: Tue, 08 Nov 2005 10:08:18 +0100
Message-ID: <43706B02.8060501@t-online.de>
References: <436F33A2.6070107@gmail.com>	<20051107162301.0f7d5bc6.akpm@osdl.org>	<436FF58A.4090506@gmail.com>	<20051107171153.28c4a594.akpm@osdl.org>	<4370397C.2040304@gmail.com>	<20051107221607.76a6c521.akpm@osdl.org>	<b00ca3bd0511072226l75a42b43ta8831992a6dff343@mail.gmail.com> <20051107223229.184b89b3.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZPNs-0000TV-V9
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 08 Nov 2005 01:03:16 -0800
Received: from mailout03.sul.t-online.com ([194.25.134.81])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EZPNs-0000MB-Lp
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 08 Nov 2005 01:03:17 -0800
In-Reply-To: <20051107223229.184b89b3.akpm@osdl.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Antonino Daplas <adaplas@gmail.com>


>>>>Unfortunately though, this patch substantially changed fbcon.c, so
>>>> any other patch affecting that file may have to wait or risk
>>>> conflicts in the future.
>>>>        
>>>>
>>>Yes, that's a problem.  We _could_ just slam this in this week and grit our
>>>teeth.  How would you evaluate the risk of regressions to existing setups?
>>>      
>>>
>>Low, if rotation is disabled. Most of the rotation code will be
>>compiled as no-ops.
>>    
>>
>
>Ho hum, OK.  Fingers crossed...
>
>  
>
If those patches would introduce bugs not related to rotated screens we 
would
find those bugs quickly as every single user tests those routines at 
least during
the boot process.

Screen rotation is a usefull feature. Not for everybody, but there are 
lots of people
who would appreciate it. I vote for including them now, asap. This would 
give the
maintainers of the hardware drivers a real argument to fix x-panning, or 
at least to
disable it in *check_var()  in case it is broken or not supported by the 
hardware.

cu,
 knut




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
