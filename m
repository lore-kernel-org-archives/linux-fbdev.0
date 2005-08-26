From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: BUG: fb_imageblit called before fb_check_var
 and fb_set_par function
Date: Fri, 26 Aug 2005 18:30:31 +0200
Message-ID: <430F43A7.5000103@t-online.de>
References: <430DB8E6.8000204@t-online.de> <430DD026.2070303@gmail.com> <430DEAD0.8070403@t-online.de> <430E094A.9030603@gmail.com> <430ED17E.6000504@t-online.de> <430F20D2.4060601@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8h3W-0006K5-NV
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Aug 2005 09:27:50 -0700
Received: from mailout07.sul.t-online.com ([194.25.134.83])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E8h3U-0005vg-66
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Aug 2005 09:27:50 -0700
In-Reply-To: <430F20D2.4060601@gmail.com>
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
Cc: Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@gmail.com>, benh@kernel.crashing.org

Hi Antonino,

> ...and the driver happily draws to the screen. No bug.
> I believe, from here on, everything will work as expected.
>
> So it seems that when kdm loads the first time, it failed to set the
> mode to KD_GRAPHICS which triggered the bug. Maybe it's a bug in
> kdm then?

Well, it might be a kdm bug, but that bug is widely spread then. SuSE 
9.2 and Debian Sarge
are affected at least. I would call it a kernel design flaw / bug if we 
allow this kind of
situation to happen. But why does this happen only if kdm is started 
early? This question
must be answered. Even if the answer is that kdm does something wrong, 
it would be
a good idea to call e.g. *fb_set_par() unconditionally for every console 
switch ...

cu,
 Knut


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
