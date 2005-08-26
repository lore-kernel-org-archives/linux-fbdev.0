From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: BUG: fb_imageblit called before fb_check_var
 and fb_set_par function
Date: Sat, 27 Aug 2005 01:00:50 +0800
Message-ID: <430F4AC2.70403@gmail.com>
References: <430DB8E6.8000204@t-online.de> <430DD026.2070303@gmail.com> <430DEAD0.8070403@t-online.de> <430E094A.9030603@gmail.com> <430ED17E.6000504@t-online.de> <430F20D2.4060601@gmail.com> <430F43A7.5000103@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8hZp-0007ad-C9
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Aug 2005 10:01:13 -0700
Received: from wproxy.gmail.com ([64.233.184.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E8hZk-0002UI-T8
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Aug 2005 10:01:13 -0700
Received: by wproxy.gmail.com with SMTP id i36so272223wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 26 Aug 2005 10:01:01 -0700 (PDT)
In-Reply-To: <430F43A7.5000103@t-online.de>
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
Cc: Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org, Knut Petersen <Knut_Petersen@t-online.de>

Knut Petersen wrote:
> Hi Antonino,
> 
>> ...and the driver happily draws to the screen. No bug.
>> I believe, from here on, everything will work as expected.
>>
>> So it seems that when kdm loads the first time, it failed to set the
>> mode to KD_GRAPHICS which triggered the bug. Maybe it's a bug in
>> kdm then?
> 
> Well, it might be a kdm bug, but that bug is widely spread then. SuSE 
> 9.2 and Debian Sarge
> are affected at least. I would call it a kernel design flaw / bug if we 
> allow this kind of
> situation to happen.

Well, that's why X runs as root, and the kernel will practically do anything
for root.
 
>  But why does this happen only if kdm is started early?

I don't know. The kdm I in suse 9.0 seems not to exhibit this behavior.

> This question
> must be answered. Even if the answer is that kdm does something wrong, 
> it would be
> a good idea to call e.g. *fb_set_par() unconditionally for every console 
> switch ...

This has been discussed before.  Not all hardware can do a set_par()
instantaneously, some may require seconds.  And that will become a usability
problem. Just imagine switching from one console to another and it takes
5 seconds.

Tony



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
