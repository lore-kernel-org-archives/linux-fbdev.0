From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: BUG: fb_imageblit called before fb_check_var
 and fb_set_par function
Date: Fri, 26 Aug 2005 20:21:06 +0200
Message-ID: <430F5D92.4080300@t-online.de>
References: <430DB8E6.8000204@t-online.de> <430DD026.2070303@gmail.com> <430DEAD0.8070403@t-online.de> <430E094A.9030603@gmail.com> <430ED17E.6000504@t-online.de> <430F20D2.4060601@gmail.com> <430F43A7.5000103@t-online.de> <430F4AC2.70403@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8imY-0002SR-Sx
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Aug 2005 11:18:26 -0700
Received: from mailout04.sul.t-online.com ([194.25.134.18])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E8imX-00010m-Gn
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Aug 2005 11:18:26 -0700
In-Reply-To: <430F4AC2.70403@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org


> This has been discussed before.  Not all hardware can do a set_par()
> instantaneously, some may require seconds.  And that will become a=20
> usability
> problem. Just imagine switching from one console to another and it take=
s
> 5 seconds.

That would be unacceptable, agreed. But it=B4s also not really acceptable=
=20
to risk to execute a few
dozend imageblits in redraw_screen() while the hardware might be in an=20
unusable state. Checking
for that situation every imageblit would have a big performance penalty.

knut


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
