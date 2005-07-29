From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: Fw: framebuffer blitting performance loss
  2.6.12 -> 2.6.13-rc3
Date: Fri, 29 Jul 2005 16:54:04 +0200
Message-ID: <42EA430C.2010405@t-online.de>
References: <20050715033912.1cd9b6c3.akpm@osdl.org>	<200507221158.23454.adaplas@gmail.com> <20050729001735.5934622f.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyWEK-0002kE-EM
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 07:52:56 -0700
Received: from mailout06.sul.t-online.com ([194.25.134.19])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DyWEK-0007sd-1r
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 07:52:56 -0700
In-Reply-To: <20050729001735.5934622f.akpm@osdl.org>
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
Cc: Andrew Morton <akpm@osdl.org>, adaplas@gmail.com

Hi everybody!

>>I haven't seen any significant performance penalty, between 2.6.12-rc5-mm1
>>and 2.6.13-rc3-mm1.
>>
>>Based on your results, I would pinpoint the culprit to be in
>>video/console/bitblit.c.  However, the changes there are minor, and should not
>>alter the peformance.
>>
>>
>
>So.. what happened here?  Is the problem still present in 2.6.13-rc4?
>
>
Yes, the problem still is present in 2.6.13-rc4.
================================================

There is only an insignificant difference of max +/- 2ms between
2.6.13-rc3 and 2.6.13-rc4 for all measurements.

Test 1:   reset;time cat scrolltest0
Test 2:   reset;time cat scrolltest80
Test 3:   reset;time cat scrolltest160

scrolltest0 is a file with 2000 empty lines.
scrolltest80 is a file with 2000 lines of 80 characters each.
scrolltest 160 is a file with 2000 lines of 160 characters each.

vesafb tests are made with the original vesafb of the respective kernel 
versions,
cyblafb tests all use the same source file, accelerations: fillrect, 
bitblit, copyarea
2.6.13-rc* are compiled for 1000Hz system timer as it is also used for 
2.6.12.

chipset: trident cyberblade/i1
video mode: vesa 0x307 (1280x1024@75hz)
8x16 font

Nothing but the kernel changed between the tests,
the time values given are system time in seconds.


 vga=0x307 | test 1   test 2   test 3  | test 1   test 2    test 3 
           |    video=vesafb:ypan      |       video=vesafb
-----------+---------------------------+---------------------------
2.6.12     | 3,753s   4,825s   5,936s  | 4,258s  65,645s  126,898s
2.6.13-rc4 | 3,937s   5,135s   6,302s  | 4,304s  71,515s  138,674s
           |  +4,9%   +6,42%   +6,17%  | +1,08%   +8,94%    +9,28%


 vga=0x307 | test 1   test 2   test 3  | test 1   test 2    test 3 
           |    video=cyblafb          |   video=cyblafb:noypan
-----------+---------------------------+---------------------------
2.6.12     | 0,228s   0,549s   0,870s  | 7,692s   8,015s    8,335s
2.6.13-rc4 | 0,235s   0,654s   1,072s  | 7,699s   8,120s    8,549s
           | +3,07%  +19,13%  +23,22%  | +0,09%   +1,31%    +2,57%


The numbers show very clearly that 2.6.13-rc* blitting is much slower than
the blitting of 2.6.12. For cyblafb the time spend for the actual 
blitting is
about 257ms for test3, so the actual performance loss for the pre-driver 
part
is above 30%

Now for a real world example:

      reset; time cat patch-2.6.13-rc4

cyblafb, kernel 2.6.12     : 173,013s
cyblafb, kernel 2.6.13-rc4 : 196,181s
   difference              :  23,168s ( +13,4% )

Could anyone take the time to measure performance of some other drivers?
Those using ypan scrolling and hardware accelerated bitblit should be
most affected.


cu,
 Knut





-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
