From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: Fw: framebuffer blitting performance loss
  2.6.12 -> 2.6.13-rc3
Date: Fri, 29 Jul 2005 22:10:23 +0200
Message-ID: <42EA8D2F.9040801@t-online.de>
References: <20050715033912.1cd9b6c3.akpm@osdl.org>	<200507221158.23454.adaplas@gmail.com> <20050729001735.5934622f.akpm@osdl.org> <42EA430C.2010405@t-online.de> <42EA4E6A.70907@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DybAB-0000nu-33
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 13:08:59 -0700
Received: from mailout09.sul.t-online.com ([194.25.134.84])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DybAA-0004tq-Lv
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 13:08:59 -0700
In-Reply-To: <42EA4E6A.70907@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hi Tony,

>
> Thank you for your persistence.  I think I know the culprit.  Someone
> insisted on using memcpy in fb_pad_aligned_buffer().  I have already
> fixed this before, but apparently, the memcpy was brought back.  Try
> the attached patch and let me know.
>
> Tony

Replacing memcpy() with this inline code helps. Performance is slightly=20
slower than
it was in 2.6.12,  but this is hardly measurable and could be caused by=20
other changes
in the kernel.

The most affected test, (test 3, cyblafb, ypan) now is about 7ms slower=20
than it was
in 2.6.12. Without your patch the performance penalty was 202ms!

Yes, please send the patch to Linus asap, it=B4s a must for 2.6.13.

Someone should look at memcpy ;-)

cu,
 Knut


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
